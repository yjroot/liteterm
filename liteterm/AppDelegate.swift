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

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        //window.titleVisibility = NSWindowTitleVisibility.Hidden
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    let optionWindowController = OptionWindowController(windowNibName: "Options")
    
    @IBAction func openOptions(sender: AnyObject){
        optionWindowController.openWindow()
    }
    
    
    // MainMenu - File
    var sessionProfileWindowController: SessionProfileWindowController!
    @IBAction func newSession(sender: AnyObject) {
        sessionProfileWindowController = SessionProfileWindowController()
        sessionProfileWindowController.loadWindow()
        sessionProfileWindowController.awakeFromNib()
        sessionProfileWindowController.showWindow(self)
    }
    
    var sessionProfileListWindowController: SessionProfileListWindowController!
    @IBAction func openSession(sender: AnyObject) {
        sessionProfileListWindowController = SessionProfileListWindowController()
        sessionProfileListWindowController.loadWindow()
        sessionProfileListWindowController.awakeFromNib()
        sessionProfileListWindowController.showWindow(self)
    }
}

