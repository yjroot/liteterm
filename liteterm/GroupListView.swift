//
//  GroupListView.swift
//  liteterm
//
//  Created by yjroot on 2015. 10. 24..
//  Copyright © 2015년 Liteterm Team. All rights reserved.
//

import Cocoa

class GroupListView: NSOutlineView {
    @IBOutlet var controller: SessionProfileWindowController!
    @IBOutlet var formView: FormView!
    
    var fields: XMLElement!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setDataSource(self)
        setDelegate(self)
    }
}

func getChildren(element: XMLElement) -> [XMLElement] {
    return element.children.filter { (child: XMLElement) -> Bool in
        return ["form", "group"].contains(child.name)
    }
}

func getFields(element: XMLElement) -> [XMLElement] {
    return element.children.filter { (child: XMLElement) -> Bool in
        return ["text", "password", "number", "select"].contains(child.name)
    }
}

extension GroupListView: NSOutlineViewDelegate, NSOutlineViewDataSource {
    func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
        
        if controller == nil {
            return 0;
        } else if item == nil {
            return getChildren(controller.fields).count
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
            children = getChildren(controller.fields)
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
        formView.setForm(self.itemAtRow(self.selectedRow) as! XMLElement)
    }
}

extension FormView {
    func setForm(form: XMLElement) {
        self.removeAllFields()
        
        let fields = getFields(form)
        for field in fields {
            switch field.name {
            case "text":
                self.addTextField(field.attributes["label"]!, path: field.attributes["path"]!)
                
            case "password":
                self.addPasswordField(field.attributes["label"]!, path: field.attributes["path"]!)
                
            case "number":
                self.addNumberField(field.attributes["label"]!, path: field.attributes["path"]!)
                
            case "select":
                var options: [(String, String)] = []
                for optionElement in field.children {
                    if optionElement.name != "option" {
                        continue
                    }
                    options.append((optionElement.text!, optionElement.attributes["value"]!))
                }
                self.addSelectField(field.attributes["label"]!, path: field.attributes["path"]!, options: options)
                
            default:
                self.addTextField(field.attributes["label"]!, path: field.attributes["path"]!)
            }
        }
    }
}