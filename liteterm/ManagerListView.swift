//
//  ManagerListView.swift
//  liteterm
//
//  Created by yjroot on 2015. 10. 13..
//  Copyright © 2015년 Liteterm Team. All rights reserved.
//

import Cocoa

class ManagerListView: NSOutlineView {
    var managers: [SessionProfileManager] = []
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        indentationPerLevel = 0
        indentationMarkerFollowsCell = false
        setDataSource(self)
        setDelegate(self)
    }
    
    func addManager(manager: SessionProfileManager) {
        self.managers.append(manager)
        self.reloadData()
    }
}

extension ManagerListView: NSOutlineViewDelegate, NSOutlineViewDataSource {
    func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
        if item == nil {
            return managers.count
        }
        return 0
    }
    
    func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        return false
    }
    
    
    func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        return managers[index]
    }
    
    func outlineView(outlineView: NSOutlineView, viewForTableColumn tableColumn: NSTableColumn?, item: AnyObject) -> NSView? {
        let manager = item as! SessionProfileManager
        
        let view = outlineView.makeViewWithIdentifier("Manager", owner: self) as! NSTableCellView
        if let textField = view.textField {
            textField.stringValue = manager.name
        }
        
        if let iconView = view.imageView {
            iconView.image = NSWorkspace.sharedWorkspace().iconForFileType(NSFileTypeForHFSTypeCode(OSType(kOpenFolderIcon)))
        }
        
        return view
    }
    
    func outlineView(outlineView: NSOutlineView, shouldShowOutlineCellForItem item: AnyObject) -> Bool {
        return false
    }
    
    func outlineViewSelectionDidChange(notification: NSNotification) {
       Swift.print((self.itemAtRow(self.selectedRow) as! SessionProfileManager).name)
    }
}
