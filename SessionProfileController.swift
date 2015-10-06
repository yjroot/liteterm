//
//  SessionProfileController.swift
//  liteterm
//
//  Created by yjroot on 2015. 9. 22..
//  Copyright (c) 2015년 Liteterm team. All rights reserved.
//

import Cocoa

class SessionProfileController: NSObject {
    @IBOutlet weak var window:NSWindow!
    @IBOutlet weak var sourceListView:NSOutlineView!
    @IBOutlet weak var formView:FormView!
    
    var fields: XMLElement {
        struct Holder {
            static var xml: XMLIndexer?
        }
        if Holder.xml == nil {
            let filePath: NSString = NSBundle.mainBundle().pathForResource("SessionProfileFields", ofType: "xml")!
            if let data: NSData = try! NSData(contentsOfFile: String(filePath), options: []) {
                let xml = SWXMLHash.parse(data)
                Holder.xml = xml
            }
        }
        
        return Holder.xml!["property"].element!
    }
    
    private func getChildren(element: XMLElement) -> [XMLElement] {
        return element.children.filter { (child: XMLElement) -> Bool in
            return ["form", "group"].contains(child.name)
        }
    }
    
    private func getFields(element: XMLElement) -> [XMLElement] {
        return element.children.filter { (child: XMLElement) -> Bool in
            return ["text", "password", "number", "select"].contains(child.name)
        }
    }
    
    var viewController: BaseField!
    
    func showForm(form: XMLElement) {
        formView.removeAllFields()
        
        let fields = getFields(form)
        for field in fields {
            switch field.name {
            case "text":
                formView.addTextField(field.attributes["label"]!, path: field.attributes["path"]!)
                
            case "password":
                formView.addPasswordField(field.attributes["label"]!, path: field.attributes["path"]!)
                
            case "number":
                formView.addNumberField(field.attributes["label"]!, path: field.attributes["path"]!)
                
            case "select":
                var options: [(String, String)] = []
                for optionElement in field.children {
                    if optionElement.name != "option" {
                        continue
                    }
                    options.append((optionElement.text!, optionElement.attributes["value"]!))
                }
                formView.addSelectField(field.attributes["label"]!, path: field.attributes["path"]!, options: options)
                
            default:
                formView.addTextField(field.attributes["label"]!, path: field.attributes["path"]!)
            }
        }
    }
}

extension SessionProfileController: NSOutlineViewDelegate, NSOutlineViewDataSource {
    func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
        if item == nil {
            return getChildren(self.fields).count
        } else if let element = item as? XMLElement {
            return getChildren(element).count
        }
        
        return 0
    }
    
    func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        if let element = item as? XMLElement {
            return getChildren(element).count != 0
        }
        
        return false
    }
    
    func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        var children: [XMLElement]!
        if item == nil {
            children = getChildren(self.fields)
        } else if let element = item as? XMLElement {
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
    
    func outlineViewSelectionDidChange(notification: NSNotification) {
        self.showForm(self.sourceListView.itemAtRow(self.sourceListView.selectedRow) as! XMLElement)
    }
}
