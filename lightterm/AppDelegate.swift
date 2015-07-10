//
//  AppDelegate.swift
//  lightterm
//
//  Created by yjroot on 2015. 6. 18..
//  Copyright (c) 2015년 Netsarang. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        window.titleVisibility = NSWindowTitleVisibility.Hidden
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    let sessionDetailWindowController = SessionDetailWindowController(windowNibName: "SessionDetail")
    
    @IBAction func newSession(sender: AnyObject) {
        sessionDetailWindowController.showWindow(sender)
    }
    
    @IBAction func openSession(AnyObject) {
        let alert = NSAlert()
        alert.messageText = "Event"
        alert.addButtonWithTitle("OK")
        alert.informativeText = "Open Session."
        
        alert.beginSheetModalForWindow(window, completionHandler: nil)
    }
}

