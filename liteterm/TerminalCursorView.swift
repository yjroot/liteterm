//
//  TerminalCursorView.swift
//  liteterm
//
//  Created by yjroot on 2016. 2. 2..
//  Copyright © 2016년 Liteterm Team. All rights reserved.
//

import Cocoa

class TerminalCursorView: NSView {
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        NSColor.greenColor().set()
        NSRectFill(dirtyRect)
    }
}
