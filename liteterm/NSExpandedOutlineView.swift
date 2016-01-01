//
//  NSExpandedOutlineView.swift
//  liteterm
//
//  Created by yjroot on 2015. 9. 27..
//  Copyright (c) 2015년 Liteterm team. All rights reserved.
//

import Cocoa

class NSExpandedOutlineView: NSOutlineView {
    override func viewWillStartLiveResize() {
        self.expandItem(nil, expandChildren: true)
    }
}
