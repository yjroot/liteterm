//
//  SessionProfileController.swift
//  lightterm
//
//  Created by yjroot on 2015. 9. 22..
//  Copyright (c) 2015년 Netsarang. All rights reserved.
//

import Cocoa

class SessionProfileController: NSObject {
    @IBOutlet weak var window:NSWindow?
    @IBOutlet weak var sourceListView:NSOutlineView?

    var fields: XMLElement {
        struct Holder {
            static var xml: XMLIndexer?
        }
        if Holder.xml == nil {
            let filePath: NSString = NSBundle.mainBundle().pathForResource("SessionProfileFields", ofType: "xml")!
            if let data: NSData = NSData(contentsOfFile: String(filePath), options: nil, error: nil) {
                var xml = SWXMLHash.parse(data)
                Holder.xml = xml
            }
        }
        
        return Holder.xml!["property"].element!
    }
}

extension SessionProfileController: NSOutlineViewDelegate, NSOutlineViewDataSource {
    private func getChildren(element: XMLElement) -> [XMLElement] {
        return element.children.filter { (child: XMLElement) -> Bool in
            return contains(["form", "group"], child.name)
        }
    }
    
    private func getFields(element: XMLElement) -> [XMLElement] {
        return element.children.filter { (child: XMLElement) -> Bool in
            return contains(["text", "password", "select"], child.name)
        }
    }
    
    func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
        if item == nil {
            return getChildren(self.fields).count
        } else if var element = item as? XMLElement {
            return getChildren(element).count
        }
        
        return 0
    }
    
    func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        if var element = item as? XMLElement {
            return getChildren(element).count != 0
        }
        
        return false
    }
    
    func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        var children: [XMLElement]!
        if item == nil {
            children = getChildren(self.fields)
        } else if var element = item as? XMLElement {
            children = getChildren(element)
        } else {
            return self
        }
        
        return children[index]
    }
    
    func outlineView(outlineView: NSOutlineView, viewForTableColumn tableColumn: NSTableColumn?, item: AnyObject) -> NSView? {
        let element = item as! XMLElement
        
        switch element.name {
        case "form":
            let view = outlineView.makeViewWithIdentifier("FormCell", owner: self) as! NSTableCellView
            if let textField = view.textField {
                textField.stringValue = element.attributes["label"]!
            }
            return view
        case "group":
            let view = outlineView.makeViewWithIdentifier("GroupCell", owner: self) as! NSTableCellView
            if let textField = view.textField {
                textField.stringValue = element.attributes["label"]!.uppercaseString
            }
            return view
        default:
            return nil
        }
    }
    
    func outlineView(outlineView: NSOutlineView, shouldSelectItem item: AnyObject) -> Bool {
        return getFields(item as! XMLElement).count > 0
    }
}