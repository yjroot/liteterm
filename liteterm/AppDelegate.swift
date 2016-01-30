//
//  AppDelegate.swift
//  liteterm
//
//  Created by yjroot on 2015. 6. 18..
//  Copyright (c) 2015년 Liteterm team. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var view: NSView!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        //window.titleVisibility = NSWindowTitleVisibility.Hidden
        
        let terminalView = TerminalView(frame: view.frame)
        self.view.addSubview(terminalView)
        view.autoresizesSubviews = true
        terminalView.autoresizingMask = NSAutoresizingMaskOptions([.ViewHeightSizable, .ViewWidthSizable])
        terminalView.terminal = Terminal(cols: 80, rows: 24)
        terminalView.terminal.putData("Hello liteterm!")
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    let optionWindowController = OptionWindowController(windowNibName: "Options")
    
    @IBAction func openOptions(sender: AnyObject){
        optionWindowController.openWindow()
    }
    
    // MainMenu - File
    @IBAction func newSession(sender: AnyObject) {
    }
    
    var sessionProfileListWindowController: SessionProfileListWindowController!
    @IBAction func openSession(sender: AnyObject) {
        sessionProfileListWindowController = SessionProfileListWindowController()
        sessionProfileListWindowController.loadWindow()
        sessionProfileListWindowController.showWindow(self)
    }
}

