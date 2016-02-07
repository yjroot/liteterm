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
        let textColor = NSColor.whiteColor()
        let backgroundColor = NSColor.greenColor()
        
        let context = NSGraphicsContext.currentContext()!
        context.saveGraphicsState()
        let currentContext = context.CGContext
        
        CGContextSetFillColorWithColor(context.CGContext, backgroundColor.CGColor)
        CGContextFillRect(context.CGContext, dirtyRect)
        for i in 0...self.text.count {
            let rect = CGRect(origin: CGPoint(x: terminal.font.width * CGFloat(i), y: 0.0), size: CGSize(width: terminal.font.width, height: terminal.font.height))
            let char = self.text[i]
            
            if char.chars != nil {
                terminal.font.addChar(char.chars, position: rect.origin)
            }
        }
        self.terminal.font.draw(currentContext, color: textColor.CGColor)
        
        context.restoreGraphicsState()
    }
}
