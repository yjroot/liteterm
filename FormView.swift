//
//  FormView.swift
//  liteterm
//
//  Created by yjroot on 2015. 9. 28..
//  Copyright (c) 2015년 Liteterm team. All rights reserved.
//

import Cocoa

class FormView: NSStackView {
    class FormField {
        var path: String
        var condition: String?
        var controller: BaseField
        var showing: Bool
        
        init(path: String, controller: BaseField, condition: String? = nil) {
            self.path = path
            self.controller = controller
            self.condition = condition
            self.showing = false
        }
    }
    
    var profile: BaseProfile!
    var fields: [FormField] = []
    
    func removeAllFields() {
        for field in fields {
            if field.showing {
                self.removeView(field.controller.view)
            }
        }
        fields.removeAll(keepCapacity: true)
        self.spacing = 5
    }
    
    func updateFields() {
        var count = 0
        for field in fields {
            let show: Bool = self.profile.checkCondition(field.condition)
            
            if show != field.showing {
                if show {
                    self.insertView(field.controller.view, atIndex: count, inGravity: NSStackViewGravity.Top)
                    field.showing = true
                } else {
                    self.removeView(field.controller.view)
                    field.showing = false
                }
            }
            
            if show {
                count += 1
            }
        }
    }
    
    func setForm(form: XMLElement, profile: BaseProfile) {
        self.profile = profile
        self.removeAllFields()
        
        let fields = getFields(form)
        for field in fields {
            if field.attributes["label"] == nil || field.attributes["path"] == nil {
                continue
            }
            
            let path = field.attributes["path"]!
            let profileSelector = ProfileSelector(profile: self.profile, keyList: path.componentsSeparatedByString("/"))
            
            var controller: BaseField!
            switch field.name {
            case "text":
                controller = TextField(formView: self, label: field.attributes["label"]!, profileSelector: profileSelector)!
                
            case "password":
                controller = PasswordField(formView: self, label: field.attributes["label"]!, profileSelector: profileSelector)!
                
            case "number":
                controller = NumberField(formView: self, label: field.attributes["label"]!, profileSelector: profileSelector)!
                
            case "select":
                let selectController = SelectField(formView: self, label: field.attributes["label"]!, profileSelector: profileSelector)!
                var options: [(String, String)] = []
                for optionElement in field.children {
                    if optionElement.name != "option" {
                        continue
                    }
                
                    options.append((optionElement.text!, optionElement.attributes["value"]!))
                }
                selectController.options = options
                controller = selectController
            default:
                continue
            }
            
            self.fields.append(FormField(path: path, controller: controller, condition: field.attributes["if"]))
        }
        updateFields()
    }
}

extension BaseProfile {
    func checkCondition(condition: String?) -> Bool {
        if condition == nil {
            return true
        }
        
        let equal = condition!.componentsSeparatedByString("==")
        if equal.count == 2 {
            let path = equal[0]
            let value = equal[1]
            
            if ProfileSelector(profile: self, keyList: path.componentsSeparatedByString("/")).string == value {
                return true
            } else {
                return false
            }
        }
        return true
    }
}