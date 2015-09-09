//
//  OptionWindowController.swift
//  lightterm
//
//  Created by Alex Jeong on 7/24/15.
//  Copyright (c) 2015 Netsarang. All rights reserved.
//

import Cocoa

let keyHideTabOnlyOneTab = "HideTabOnlyOneTab"
let keyHideTabNumber = "HideTabNumber"
let keyHideMenubar = "AutoHideMenuBar"
let keyCommandHoldingSeconds = "HoldingSecondsForShowingTab"
let keyCursorAppearance = "CursorAppearance"

class OptionWindowController : NSWindowController{

    var optionWindow:NSWindow = NSWindow()
    
    var hideTabOnlyOneTab:AnyObject = false
    var hideTabNumber:AnyObject = false
    var hideMenubar:AnyObject = false
    var commandHoldingSeconds:AnyObject = 5
    var cursorAppearance:AnyObject = 1
    
    
    var mainW: NSWindow = NSWindow()
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activateIgnoringOtherApps(true)
    }
    
    func OpenWindow(){
        self.window!.beginSheet(self.window!, completionHandler: nil)
    }
    
    ///////////////////
    func LoadOptionData(){
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths[0] as! String
        let path = documentsDirectory.stringByAppendingPathComponent("Options.plist")
        let fileManager = NSFileManager.defaultManager()
        //check if file exists
        if(!fileManager.fileExistsAtPath(path)) {
            // If it doesn't, copy it from the default file in the Bundle
            if let bundlePath = NSBundle.mainBundle().pathForResource("Options", ofType: "plist") {
                let resultDictionary = NSMutableDictionary(contentsOfFile: bundlePath)
                println("Bundle Options.plist file is --> \(resultDictionary?.description)")
                fileManager.copyItemAtPath(bundlePath, toPath: path, error: nil)
                println("copy")
            } else {
                println("Options.plist not found. Please, make sure it is part of the bundle.")
            }
        } else {
            println("Options.plist already exits at path.")
            // use this to delete file from documents directory
            //fileManager.removeItemAtPath(path, error: nil)
        }
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        println("Loaded Options.plist file is --> \(resultDictionary?.description)")
        var myDict = NSDictionary(contentsOfFile: path)
        if let dict = myDict {
            //loading values
            hideTabOnlyOneTab = dict.objectForKey(keyHideTabOnlyOneTab)!
            hideTabNumber = dict.objectForKey(keyHideTabNumber)!
            hideMenubar = dict.objectForKey(keyHideMenubar)!
            commandHoldingSeconds = dict.objectForKey(keyCommandHoldingSeconds)!
            cursorAppearance = dict.objectForKey(keyCursorAppearance)!
            //...
        } else {
            println("WARNING: Couldn't create dictionary from Options.plist! Default values will be used!")
        }
    }
    
    func SaveOptionData(){
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("Options.plist")
        var dict: NSMutableDictionary = ["XInitializerItem": "DoNotEverChangeMe"]
        //saving values
        dict.setObject(hideTabOnlyOneTab, forKey: keyHideTabOnlyOneTab)
        dict.setObject(hideTabNumber, forKey: keyHideTabOnlyOneTab)
        dict.setObject(hideMenubar, forKey: keyHideTabOnlyOneTab)
        dict.setObject(commandHoldingSeconds, forKey: keyHideTabOnlyOneTab)
        dict.setObject(cursorAppearance, forKey: keyHideTabOnlyOneTab)
        //...
        //writing to Options.plist
        dict.writeToFile(path, atomically: false)
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        println("Saved Options.plist file is --> \(resultDictionary?.description)")
    }
}