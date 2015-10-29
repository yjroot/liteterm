//
//  TerminalView.swift
//  liteterm
//
//  Created by yjroot on 2015. 6. 19..
//  Copyright (c) 2015년 Liteterm team. All rights reserved.
//

import Cocoa

class TerminalView: NSView {

    let tabViewController = LTTabViewController()
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        let bPath:NSBezierPath = NSBezierPath(rect: dirtyRect)
        
        let backgroundColor = NSColor(red: 0, green: 0, blue: 0, alpha: 1)
        backgroundColor.set()
        bPath.fill();
    }
    
    
    func showTabView(){
 
    }
    
    func hideTabView(){
        
    }
}
