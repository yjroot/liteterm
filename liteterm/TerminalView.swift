//
//  TerminalView.swift
//  liteterm
//
//  Created by yjroot on 2015. 6. 19..
//  Copyright (c) 2015년 Liteterm team. All rights reserved.
//

import Cocoa

class TerminalView: NSView {
    var _terminal: Terminal!
    var terminal: Terminal! {
        get {
            return _terminal
        }
        set (terminal) {
            if self._terminal != nil {
                self._terminal.viewer = nil
            }
            terminal.viewer = self
            terminal.rows = self.rows
            terminal.cols = self.cols
            
            self._terminal = terminal
            self.display()
        }
    }
    var font: TerminalFont = TerminalFont()
    var rows: Int {
        return max(Int(self.frame.height / font.height), 1)
    }
    var cols: Int {
        return max(Int(self.frame.width / font.width), 1)
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        addSubview(cursorView)
        self.markedText = nil
    }
    var cursorView: TerminalCursorView! = TerminalCursorView()
    
    override var acceptsFirstResponder: Bool {
        return true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func acceptsFirstMouse(theEvent: NSEvent?) -> Bool {
        return true
    }
    
    override func mouse(aPoint: NSPoint, inRect aRect: NSRect) -> Bool {
        return true
    }
    
    override func mouseDown(theEvent: NSEvent) {
    }
    
    override func viewDidEndLiveResize() {
        terminal.rows = self.rows
        terminal.cols = self.cols
    }
    
    var padding: CGPoint {
        var padding = CGPoint(x: frame.width % font.width / 2, y: frame.height % font.height / 2)
        if frame.width < font.width {
            padding.x = 0
        }
        if frame.height < font.height {
            padding.y = 0
        }
        return padding
    }
    
    func pointToTermPosition(point: CGPoint) -> TerminalPosition {
        var row = Int((frame.height - (point.y - padding.y)) / font.height)
        row = max(row, 0)
        row = min(row, self.rows - 1)
        var col = Int((point.x - padding.x) / font.width)
        col = max(col, 0)
        col = min(col, self.cols - 1)
        return TerminalPosition(row: row, col: col)
    }
    
    func termPositionToPoint(position: TerminalPosition) -> CGPoint {
        return CGPoint(x: font.width * CGFloat(position.col) + padding.x, y: frame.height - (font.height * CGFloat(position.row + 1) + padding.y))
    }
    
    func termPositionToRect(position: TerminalPosition, length: Int = 1) -> CGRect {
        return CGRect(origin: termPositionToPoint(position), size: CGSize(width: font.width * CGFloat(length), height: font.height))
    }
    
    func _drawChar(char: TerminalCharacter, position: TerminalPosition) {
        let rect = CGRect(origin: termPositionToPoint(position), size: CGSize(width: font.width, height: font.height))
        
        let backgroundColor = NSColor.blackColor()
        //backgroundColor = NSColor(red: CGFloat(arc4random()%100)/100, green: CGFloat(arc4random()%100)/100, blue: CGFloat(arc4random()%100)/100, alpha: 0.5)
        
        CGContextSetFillColorWithColor(currentContext, backgroundColor.CGColor)
        CGContextFillRect(currentContext, rect)
        
        if char.chars != nil {
            self.font.addChar(char.chars, position: rect.origin)
        }
    }
    
    var currentContext: CGContext!
    override func drawRect(dirtyRect: NSRect) {
        let context = NSGraphicsContext.currentContext()!
        context.saveGraphicsState()
        currentContext = context.CGContext
        
        CGContextSetFillColorWithColor(context.CGContext, NSColor.blackColor().CGColor)
        CGContextFillRect(context.CGContext, dirtyRect)
        
        let begin = pointToTermPosition(CGPoint(x: dirtyRect.origin.x, y: dirtyRect.origin.y + dirtyRect.height))
        let end = pointToTermPosition(CGPoint(x: dirtyRect.origin.x + dirtyRect.width, y: dirtyRect.origin.y))
        
        if self.terminal != nil {
            for position in begin...end {
                self._drawChar(self.terminal[position], position: position)
            }
            self.font.draw(currentContext, color: NSColor.whiteColor().CGColor)
        }
        
        currentContext = nil
        context.restoreGraphicsState()
    }
    
    func updateText(position: TerminalPosition, length: Int = 1) {
        let rect = CGRect(x: Int(font.width * (CGFloat(position.col) - 0.5) + padding.x), y: Int(frame.height - (font.height * (CGFloat(position.row + 1) + 0.5) + padding.y)), width: Int(font.width * CGFloat(length + 1)), height: Int(font.height * 2))
        
        self.displayRect(rect)
    }
    
    func updateCursor() {
        var cursorDrawPosition = TerminalPosition()
        if terminal != nil {
            cursorDrawPosition = terminal.cursor
        }
        if self.cols <= cursorDrawPosition.col + cursorLine.count {
            cursorDrawPosition.col = self.cols - cursorLine.count
        }
        self.cursorView.frame = termPositionToRect(cursorDrawPosition, length: cursorLine.count)
    }
    
    override func keyDown(theEvent: NSEvent) {
        self.interpretKeyEvents([theEvent])
    }
    
    func newline(lines: Int = 1) {
    }
    
    func addScroll(line: TerminalLine) {
    }
    
    var cursorLine:TerminalLine = TerminalLine()
    var markedText: NSAttributedString! {
        get {
            return self._markedText
        }
        set (markedText) {
            self._markedText = markedText
            let attributes: TerminalCharacterAttributes = TerminalCharacterAttributes()
            
            if markedText == nil {
                self.cursorLine.erase()
                self.cursorLine[0] = TerminalCharacter(chars: nil, attr: attributes)
                self.updateCursor()
                return
            }
            
            let chars = markedText.string.characters.map { (char) -> TerminalCharacter in
                return TerminalCharacter(chars: char, attr: attributes)
            }
            self.cursorLine.chars = chars
            self.updateCursor()
        }
    }
    var _markedText: NSAttributedString!
    var _selectedRange: NSRange = NSRange(location: 0,length: 0)
    var _markedRange: NSRange = NSRange(location: NSNotFound, length: 0)
    
    override func deleteBackward(sender: AnyObject?) {
    }
    
    override func deleteForward(sender: AnyObject?) {
    }
}

extension TerminalView: NSTextInputClient {
    func insertText(aString: AnyObject, replacementRange: NSRange) {
        if terminal != nil {
            terminal.putData(aString as! String)
        }
        self._markedRange = replacementRange
        self.markedText = nil
    }
    
    func setMarkedText(aString: AnyObject, selectedRange: NSRange, replacementRange: NSRange) {
        self._selectedRange = selectedRange
        self._markedRange = replacementRange
        
        if let attributedString = aString as? NSAttributedString {
            self.markedText = attributedString
        } else if let string = aString as? NSString {
            self.markedText = NSAttributedString(string: string as String)
        }
    }
    
    func unmarkText() {
        self.inputContext?.discardMarkedText()
    }
    
    func selectedRange() -> NSRange {
        return self._selectedRange
    }
    
    func markedRange() -> NSRange {
        return self._markedRange
    }
    
    func hasMarkedText() -> Bool {
        return markedRange().location != NSNotFound
    }
    
    func attributedSubstringForProposedRange(aRange: NSRange, actualRange: NSRangePointer) -> NSAttributedString? {
        return nil
    }
    
    func validAttributesForMarkedText() -> [String] {
        return []
    }
    
    func firstRectForCharacterRange(aRange: NSRange, actualRange: NSRangePointer) -> NSRect {
        return cursorView.frame
    }
    
    func characterIndexForPoint(aPoint: NSPoint) -> Int {
        return 0
    }
}