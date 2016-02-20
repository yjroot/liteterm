//
//  TerminalCursorView.swift
//  liteterm
//
//  Created by yjroot on 2016. 2. 2..
//  Copyright © 2016년 Liteterm Team. All rights reserved.
//

import Cocoa

class TerminalCursorView: NSView {
    var terminal: TerminalView!
    var text: TerminalLine!
    init(terminal: TerminalView) {
        let frame = NSRect(x: 0, y: 0, width: terminal.font.width, height: terminal.font.width)
        self.text = TerminalLine()
        self.terminal = terminal
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func drawRect(dirtyRect: NSRect) {
        let textColor = RGBColor(red: UInt16.max, green: UInt16.max, blue: UInt16.max)
        let backgroundColor = NSColor.greenColor()
        
        let context = NSGraphicsContext.currentContext()!
        context.saveGraphicsState()
        let currentContext = context.CGContext
        
        CGContextSetFillColorWithColor(currentContext, backgroundColor.CGColor)
        CGContextFillRect(currentContext, dirtyRect)
        for i in 0...self.text.count {
            let rect = CGRect(origin: CGPoint(x: terminal.font.width * CGFloat(i), y: 0.0), size: CGSize(width: terminal.font.width, height: terminal.font.height))
            let char = self.text[i]
            
            if char.chars != nil {
                terminal.font.drawChar(char.chars, position: rect.origin, width: char.wcwidth, color: textColor, context: currentContext)
            }
        }
        self.terminal.font.flush()
        
        context.restoreGraphicsState()
    }
}
