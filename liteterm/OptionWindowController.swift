//
//  OptionWindowController.swift
//  liteterm
//
//  Created by Alex Jeong on 7/24/15.
//  Copyright (c) 2015 Liteterm team. All rights reserved.
//

import Cocoa

class OptionWindowController : NSWindowController{

    var optionWindow:NSWindow = NSWindow()
    var option = OptionProfile.sharedInstance["option"]
    
    var hideTabOnlyOneTab: Bool {
        get {
            return option["HideTabOnlyOneTab"].bool
        }
        set(value) {
            option["HideTabOnlyOneTab"].bool = value
            OptionProfile.sharedInstance.save()
        }
    }
    var hideTabNumber: Bool {
        get {
            return option["HideTabNumber"].bool
        }
        set(value) {
            option["HideTabNumber"].bool = value
            OptionProfile.sharedInstance.save()
        }
    }
    var hideMenubar: Bool {
        get {
            return option["AutoHideMenuBar"].bool
        }
        set(value) {
            option["AutoHideMenuBar"].bool = value
            OptionProfile.sharedInstance.save()
        }
    }
    var commandHoldingSeconds: Int {
        get {
            return option["HoldingSecondsForShowingTab"].int
        }
        set(value) {
            option["HoldingSecondsForShowingTab"].int = value
            OptionProfile.sharedInstance.save()
        }
    }
    var cursorAppearance: Int {
        get {
            return option["CursorAppearance"].int
        }
        set(value) {
            option["CursorAppearance"].int = value
            OptionProfile.sharedInstance.save()
        }
    }
    
    var mainW: NSWindow = NSWindow()
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activateIgnoringOtherApps(true)
    }
    
    func openWindow(){
        self.window!.beginSheet(self.window!, completionHandler: nil)
    }
}
