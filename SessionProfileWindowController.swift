//
//  SessionProfileWindowController.swift
//  liteterm
//
//  Created by yjroot on 2015. 9. 18..
//  Copyright (c) 2015년 Liteterm team. All rights reserved.
//

import Cocoa

class SessionProfileWindowController: NSWindowController {
    @IBOutlet weak var groupListView:GroupListView!
    @IBOutlet weak var formView:FormView!
    
    var profile: SessionProfile!
    
    convenience init(profile: SessionProfile) {
        self.init(windowNibName: "SessionProfileWindow")
        self.profile = profile
    }
    
    var modalSession: NSModalSession!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.groupListView.profile = self.profile
        self.groupListView.fields = SessionProfileWindowController.fields
        self.updateWindowTitle()
        
        self.window!.makeKeyAndOrderFront(self)
        
        self.modalSession = NSApp.beginModalSessionForWindow(window!)
        NSApp.runModalSession(self.modalSession)
    }
    
    private func updateWindowTitle() {
        if self.window == nil {
            return
        }
        
        if self.profile.name == "" {
            self.window!.title = "New Session profile"
        } else {
            self.window!.title = self.profile.name
        }
    }
    
    static var fieldsXML: XMLIndexer?
    static var fields: XMLElement {
        if SessionProfileWindowController.fieldsXML == nil {
            let filePath: NSString = NSBundle.mainBundle().pathForResource("SessionProfileFields", ofType: "xml")!
            if let data: NSData = try! NSData(contentsOfFile: String(filePath), options: []) {
                SessionProfileWindowController.fieldsXML = SWXMLHash.parse(data)
            }
        }
        
        return SessionProfileWindowController.fieldsXML!["property"].element!
    }
}

extension SessionProfileWindowController: NSWindowDelegate {
    func windowWillClose(notification: NSNotification) {
        self.profile.save()
        
        if modalSession != nil {
            NSApp.endModalSession(self.modalSession)
            self.modalSession = nil
        }
    }
}