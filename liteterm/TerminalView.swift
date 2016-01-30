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
        return Int(self.frame.height / font.height)
    }
    var cols: Int {
        return Int(self.frame.width / font.width)
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
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
    
    func pointToTermPosition(var point: CGPoint) -> TerminalPosition {
        point.x -= padding.x
        point.y -= padding.y
        return TerminalPosition(row: max(Int((frame.height - point.y) / font.height), 0), col: max(Int(point.x / font.width), 0))
    }
    
    override func drawRect(dirtyRect: NSRect) {
        //super.drawRect(dirtyRect)
        let context = NSGraphicsContext.currentContext()!
        context.saveGraphicsState()
        
        if self.terminal == nil {
            CGContextSetFillColorWithColor(context.CGContext, NSColor.blackColor().CGColor)
            CGContextFillRect(context.CGContext, dirtyRect)
            context.restoreGraphicsState()
            return
        }
        
        CGContextSetFillColorWithColor(context.CGContext, NSColor.blackColor().CGColor)
        CGContextFillRect(context.CGContext, dirtyRect)
        
        let begin = pointToTermPosition(CGPoint(x: dirtyRect.origin.x, y: dirtyRect.origin.y + dirtyRect.height))
        var end = pointToTermPosition(CGPoint(x: dirtyRect.origin.x + dirtyRect.width, y: dirtyRect.origin.y))
        end.col = max(min(end.col, self.cols - 1), 0)
        end.row = max(min(end.row, self.rows - 1), 0)
        
        for y in begin.row...end.row {
            let termLine = self.terminal[y]
            for x in begin.col...end.col {
                let termChar = termLine[x]
                let rect = CGRect(x: font.width * CGFloat(x) + padding.x, y: frame.height - (font.height * CGFloat(y + 1) + padding.y), width: font.width, height: font.height)
                
                let backgroundColor = NSColor.blackColor()
                
                CGContextSetFillColorWithColor(context.CGContext, backgroundColor.CGColor)
                CGContextFillRect(context.CGContext, rect)
                
                if termChar.chars != nil {
                    self.font.addChar(termChar.chars, position: rect.origin)
                }
            }
        }
        self.font.draw(context.CGContext, color: NSColor.whiteColor().CGColor)
        
        context.restoreGraphicsState()
    }
    
    func updateText(position: TerminalPosition, length: Int = 1) {
        let rect = CGRect(x: Int(font.width * (CGFloat(position.col) - 0.5) + padding.x), y: Int(frame.height - (font.height * (CGFloat(position.row + 1) + 0.5) + padding.y)), width: Int(font.width * CGFloat(length + 1)), height: Int(font.height * 2))
        
        self.displayRect(rect)
    }
    
    override func keyDown(theEvent: NSEvent) {
        self.interpretKeyEvents([theEvent])
    }
    
    override func insertText(insertString: AnyObject) {
        if terminal == nil {
            return
        }
        
        terminal.putData(insertString as! String)
    }
    
    func newline(lines: Int = 1) {
    }
    
    func addScroll(line: TerminalLine) {
    }
}
