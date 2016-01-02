//
//  TerminalView.swift
//  liteterm
//
//  Created by yjroot on 2015. 6. 19..
//  Copyright (c) 2015년 Liteterm team. All rights reserved.
//

import Cocoa

class TerminalView: NSView {
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        let bPath:NSBezierPath = NSBezierPath(rect: dirtyRect)
        
        let backgroundColor = NSColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        backgroundColor.set()
        bPath.fill();
        
        let text = NSString(string: "liteterm")
        text.drawAtPoint(NSPoint(x: 0, y: 0), withAttributes: nil)
        //text.dr
    }
    
    func getFont() -> NSFont {
        return NSFont.systemFontOfSize(11.0)
    }
    
    func getGlyph(char: UniChar) {
    }
    
    func setTerminalSize(width: Int, height: Int) {
    }
    
    // updateText -> damage -> drawText
    
    func updateText(text: String, attr: [TerminalCharacterAttributes], x: Int, y: Int) {
    }
    
    func drawText(text: String, attr: [TerminalCharacterAttributes], x: Int, y: Int) {
    }
    
    func newline(lines: Int = 1) {
    }
    
    func addScroll(line: TerminalLine) {
    }
}
