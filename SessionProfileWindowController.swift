//
//  SessionProfileWindowController.swift
//  liteterm
//
//  Created by yjroot on 2015. 9. 18..
//  Copyright (c) 2015년 Liteterm team. All rights reserved.
//

import Cocoa

class SessionProfileWindowController: NSWindowController {
    var object: SessionProfileController!
    
    convenience init() {
        let object = SessionProfileController()
        self.init(windowNibName: "SessionProfileWindow", owner: object)
        self.object = object
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        object.sourceListView!.expandItem(nil, expandChildren: true)
        object.sourceListView!.selectRowIndexes(NSIndexSet(index: 0), byExtendingSelection: false)
        object.window!.title = "New Session profile"
    }
}
