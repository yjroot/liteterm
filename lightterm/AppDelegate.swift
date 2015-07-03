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
}

