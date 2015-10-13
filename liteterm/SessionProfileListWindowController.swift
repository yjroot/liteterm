//
//  SessionProfileListWindowController.swift
//  liteterm
//
//  Created by yjroot on 2015. 10. 11..
//  Copyright © 2015년 Liteterm Team. All rights reserved.
//

import Cocoa

class SessionProfileListWindowController: NSWindowController {
    var object: SessionProfileListController!
    convenience init() {
        let object = SessionProfileListController()
        self.init(windowNibName: "SessionProfileListWindow", owner: object)
        self.object = object
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.object.managerListView.addManager(SessionProfileManager())
        self.object.managerListView.selectRowIndexes(NSIndexSet(index: 0), byExtendingSelection: false)
        self.object.window.makeKeyAndOrderFront(self)
    }
}
