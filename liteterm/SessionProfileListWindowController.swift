//
//  SessionProfileListWindowController.swift
//  liteterm
//
//  Created by yjroot on 2015. 10. 11..
//  Copyright © 2015년 Liteterm Team. All rights reserved.
//

import Cocoa

class SessionProfileListWindowController: NSWindowController {
    @IBOutlet weak var managerListView: ManagerListView!
    @IBOutlet weak var profileListView: ProfileListView!
    
    convenience init() {
        self.init(windowNibName: "SessionProfileListWindow")
    }
    
    var modalSession: NSModalSession!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.managerListView.addManager(SessionProfileManager())
        self.managerListView.selectRowIndexes(NSIndexSet(index: 0), byExtendingSelection: false)
        
        self.window!.makeKeyAndOrderFront(self)
        
        self.modalSession = NSApp.beginModalSessionForWindow(window!)
        NSApp.runModalSession(self.modalSession)
    }
    
    var sessionProfileWindowController: SessionProfileWindowController!
    @IBAction func onNew(sender: AnyObject) {
        let newProfileDialog: NSAlert = NSAlert()
        newProfileDialog.window.title = "New profile"
        newProfileDialog.messageText = "Please enter a new profile name"
        
        newProfileDialog.alertStyle = NSAlertStyle.InformationalAlertStyle
        
        newProfileDialog.addButtonWithTitle("Create")
        newProfileDialog.addButtonWithTitle("Cancel")
        
        let textField = NSTextField(frame: NSRect(x: 0, y: 0, width: 240, height: 24))
        newProfileDialog.accessoryView = textField
        
        newProfileDialog.icon = NSImage()
        
        if newProfileDialog.runModal() == NSAlertFirstButtonReturn {
            if profileListView.manager.profiles.contains(textField.stringValue) {
                let alert: NSAlert = NSAlert()
                alert.alertStyle = NSAlertStyle.CriticalAlertStyle
                alert.messageText = "The name already exists"
                alert.runModal()
            }
            
            let newProfile = SessionProfile()
            profileListView.manager[textField.stringValue] = newProfile
            profileListView.reloadData()
            
            sessionProfileWindowController = SessionProfileWindowController(profile: newProfile)
            sessionProfileWindowController.loadWindow()
            sessionProfileWindowController.showWindow(self)
        }
    }
    
    @IBAction func onOpenSession(sender: AnyObject) {
        let profile = self.profileListView.itemAtRow(self.profileListView.selectedRow) as! SessionProfile
        print(profile.name)
    }
}

extension SessionProfileListWindowController: NSWindowDelegate {
    func windowWillClose(notification: NSNotification) {
        if modalSession != nil {
            NSApp.endModalSession(self.modalSession)
            self.modalSession = nil
        }
    }
}
