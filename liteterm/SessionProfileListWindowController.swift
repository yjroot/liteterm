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
}

extension SessionProfileListWindowController: NSWindowDelegate {
    func windowWillClose(notification: NSNotification) {
        if modalSession != nil {
            NSApp.endModalSession(self.modalSession)
            self.modalSession = nil
        }
    }
}
