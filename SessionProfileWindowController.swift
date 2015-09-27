//
//  SessionProfileWindowController.swift
//  lightterm
//
//  Created by yjroot on 2015. 9. 18..
//  Copyright (c) 2015년 Netsarang. All rights reserved.
//

import Cocoa

class SessionProfileWindowController: NSWindowController {
    var object: SessionProfileController!
    
    convenience init() {
        var object = SessionProfileController()
        self.init(windowNibName: "SessionProfile", owner: object)
        self.object = object
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        object.sourceListView!.expandItem(nil, expandChildren: true)
        object.sourceListView!.selectRowIndexes(NSIndexSet(index: 0), byExtendingSelection: false)
        object.window!.title = "New Session profile"
    }
}