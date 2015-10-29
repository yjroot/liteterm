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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.groupListView.reloadData()
        self.groupListView.expandItem(nil, expandChildren: true)
        self.groupListView.selectRowIndexes(NSIndexSet(index: 0), byExtendingSelection: false)
        self.window!.title = "New Session profile"
        self.window!.makeKeyAndOrderFront(self)
        
        self.updateWindowTitle()
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
    var fields: XMLElement {
        if SessionProfileWindowController.fieldsXML == nil {
            let filePath: NSString = NSBundle.mainBundle().pathForResource("SessionProfileFields", ofType: "xml")!
            if let data: NSData = try! NSData(contentsOfFile: String(filePath), options: []) {
                SessionProfileWindowController.fieldsXML = SWXMLHash.parse(data)
            }
        }
        
        return SessionProfileWindowController.fieldsXML!["property"].element!
    }
}