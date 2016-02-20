//
//  TerminalView.swift
//  liteterm
//
//  Created by yjroot on 2015. 6. 19..
//  Copyright (c) 2015년 Liteterm team. All rights reserved.
//

import Cocoa

class TerminalView: NSView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        cursorView = TerminalCursorView(terminal: self)
        addSubview(cursorView)
    }
    
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
    
    var cursorView: TerminalCursorView!
    
    override var acceptsFirstResponder: Bool {
        return true
    }
    
    override func acceptsFirstMouse(theEvent: NSEvent?) -> Bool {
        return true
    }
    
    override func mouse(aPoint: NSPoint, inRect aRect: NSRect) -> Bool {
        return true
    }
    
    override func mouseDown(theEvent: NSEvent) {
    }
    
    override func viewWillStartLiveResize() {
        cursorView.hidden = true
    }
    
    override func viewDidEndLiveResize() {
        terminal.rows = self.rows
        terminal.cols = self.cols
        
        updateCursorPosition()
        cursorView.hidden = false
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
        let rect = termPositionToRect(position, length: char.wcwidth)
        let textColor = terminal.palette[char.attr.textColor]
        
        if char.chars != nil {
            self.font.drawChar(char.chars, position: rect.origin, width: char.wcwidth, color: textColor, context: currentContext)
        }
    }
    
    func _drawBackground(char: TerminalCharacter, position: TerminalPosition) {
        let rect = termPositionToRect(position, length: char.wcwidth)
        let backgroundColor = terminal.palette[char.attr.backgroundColor]
        
        CGContextSetFillColorWithColor(currentContext, backgroundColor.CGColor)
        CGContextFillRect(currentContext, rect)
    }
    
    var currentContext: CGContext!
    override func drawRect(dirtyRect: NSRect) {
        let context = NSGraphicsContext.currentContext()!
        context.saveGraphicsState()
        currentContext = context.CGContext
        
        CGContextSetFillColorWithColor(context.CGContext, NSColor.blackColor().CGColor)
        CGContextFillRect(context.CGContext, dirtyRect)
        
        let begin = pointToTermPosition(CGPoint(x: dirtyRect.origin.x - 0.1, y: dirtyRect.origin.y + dirtyRect.height + 0.1))
        let end = pointToTermPosition(CGPoint(x: dirtyRect.origin.x + dirtyRect.width + 0.1, y: dirtyRect.origin.y - 0.1))
        
        if self.terminal != nil {
            for position in begin...end {
                self._drawBackground(self.terminal[position], position: position)
            }
            for position in begin...end {
                self._drawChar(self.terminal[position], position: position)
            }
            self.font.flush()
        }
        
        /*if debugmode {
            let color = NSColor(red: CGFloat(arc4random()%100)/100, green: CGFloat(arc4random()%100)/100, blue: CGFloat(arc4random()%100)/100, alpha: 0.5)
            CGContextSetFillColorWithColor(context.CGContext, color.CGColor)
            CGContextFillRect(context.CGContext, dirtyRect)
        }*/
        
        currentContext = nil
        context.restoreGraphicsState()
    }
    
    func updateText(position: TerminalPosition, length: Int = 1) {
        let rect = CGRect(x: Int(font.width * (CGFloat(position.col) - 0.5) + padding.x), y: Int(frame.height - (font.height * (CGFloat(position.row + 1) + 0.5) + padding.y)), width: Int(font.width * CGFloat(length + 1)), height: Int(font.height * 2))
        
        self.displayRect(rect)
    }
    
    func updateCursor(markedText: NSAttributedString!, position: TerminalPosition) {
        if cursorView == nil {
            return
        }
        
        let attributes: TerminalCharacterAttributes = TerminalCharacterAttributes()
        
        let string: String
        if markedText != nil {
            string = markedText.string
        } else {
            string = " "
        }
        
        let characters = string.characters
        cursorView.text.erase()
        for char in characters {
            let terminalCharacter = TerminalCharacter(chars: char, attr: attributes)
            cursorView.text.chars.append(terminalCharacter)

            for _ in 1..<terminalCharacter.wcwidth {
                cursorView.text.chars.append(TerminalCharacter())
            }
        }
        
        self.updateCursorPosition()
        self.cursorView.display()
    }
    
    func updateCursorPosition() {
        var cursorDrawPosition = TerminalPosition()
        if terminal != nil {
            cursorDrawPosition = terminal.cursor
        }
        if self.cols <= cursorDrawPosition.col + cursorView.text.count {
            cursorDrawPosition.col = self.cols - cursorView.text.count
        }
        
        self.cursorView.frame = termPositionToRect(cursorDrawPosition, length: cursorView.text.count)
    }
    
    override func keyDown(theEvent: NSEvent) {
        self.interpretKeyEvents([theEvent])
    }
    
    func newline(lines: Int = 1) {
    }
    
    func addScroll(line: TerminalLine) {
    }
    
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
        self.updateCursor(nil, position: terminal.cursor)
    }
    
    func setMarkedText(aString: AnyObject, selectedRange: NSRange, replacementRange: NSRange) {
        self._selectedRange = selectedRange
        self._markedRange = replacementRange
        
        if let attributedString = aString as? NSAttributedString {
            self.updateCursor(attributedString, position: terminal.cursor)
        } else if let string = aString as? NSString {
            self.updateCursor(NSAttributedString(string: string as String), position: terminal.cursor)
        } else {
            self.updateCursor(nil, position: terminal.cursor)
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

extension RGBColor {
    var CGColor: CGColorRef {
        return NSColor(red: CGFloat(red) / 65535.0, green: CGFloat(green) / 65535.0, blue: CGFloat(blue) / 65535.0, alpha: 1.0).CGColor
    }
}