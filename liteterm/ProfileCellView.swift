//
//  ProfileCellView.swift
//  liteterm
//
//  Created by yjroot on 2015. 10. 29..
//  Copyright © 2015년 Liteterm Team. All rights reserved.
//

import Cocoa

class ProfileCellView: NSTableCellView {
    @IBOutlet weak var descriptionField: NSTextField!
    
    private var _profile: SessionProfile!
    var profile: SessionProfile! {
        set(profile) {
            self.textField!.stringValue = profile.name
            self.descriptionField.stringValue = profile.description
            self._profile = profile
        }
        get {
            return _profile
        }
    }
    
    @IBAction func onEdit(sender: AnyObject) {
        var sessionProfileWindowController: SessionProfileWindowController!
        sessionProfileWindowController = SessionProfileWindowController(profile: self.profile)
        sessionProfileWindowController.loadWindow()
        sessionProfileWindowController.showWindow(self)
    }
}
