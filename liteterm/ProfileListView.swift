//
//  ProfileListView.swift
//  liteterm
//
//  Created by yjroot on 2015. 10. 13..
//  Copyright © 2015년 Liteterm Team. All rights reserved.
//

import Cocoa

class ProfileListView: NSOutlineView {
    var manager: SessionProfileManager! = SessionProfileManager()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setDataSource(self)
        setDelegate(self)
    }
    
    func setManager(manager: SessionProfileManager) {
        self.manager = manager
        self.reloadData()
    }
}

extension ProfileListView: NSOutlineViewDelegate, NSOutlineViewDataSource {
    func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
        if manager == nil {
            return 0
        }

        if item == nil {
            return self.manager.profiles.count
        }
        
        return 0
    }
    
    func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        return false
    }
    
    func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        return self.manager[self.manager.profiles[index]]!
    }
    
    func outlineView(outlineView: NSOutlineView, viewForTableColumn tableColumn: NSTableColumn?, item: AnyObject) -> NSView? {
        let profile = item as! SessionProfile
        
        let view = outlineView.makeViewWithIdentifier("Profile", owner: self) as! NSTableCellView
        if let textField = view.textField {
            textField.stringValue = profile.name
        }
        
        return view
    }
    
    func outlineView(outlineView: NSOutlineView, shouldShowOutlineCellForItem item: AnyObject) -> Bool {
        return false
    }
    
    func outlineViewSelectionDidChange(notification: NSNotification) {
        //(self.itemAtRow(self.selectedRow) as! SessionProfile).name
    }
}
