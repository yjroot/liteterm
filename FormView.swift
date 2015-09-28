//
//  FormView.swift
//  lightterm
//
//  Created by yjroot on 2015. 9. 28..
//  Copyright (c) 2015년 Netsarang. All rights reserved.
//

import Cocoa

class FormView: NSStackView {
    struct FormField {
        var path: String
        var controller: BaseField
    }
    
    var fields: [FormField] = []
    
    func removeAllFields() {
        for field in fields {
            self.removeView(field.controller.view)
        }
        fields.removeAll(keepCapacity: true)
        self.spacing = 5
    }
    
    func addTextField(label: String, path:String) {
        var field = FormField(path: path, controller: TextField(label: label)!)
        self.addField(field)
    }
    
    func addPasswordField(label: String, path:String) {
        var field = FormField(path: path, controller: PasswordField(label: label)!)
        self.addField(field)
    }
    
    func addNumberField(label: String, path:String) {
        var field = FormField(path: path, controller: NumberField(label: label)!)
        self.addField(field)
    }
    
    func addSelectField(label: String, path:String, options: [String:String]) {
        var controller = SelectField(label: label)!
        controller.options = options

        var field = FormField(path: path, controller: controller)
        self.addField(field)
    }
    
    private func addField(field: FormField) {
        fields.append(field)
        self.addView(field.controller.view, inGravity: NSStackViewGravity.Top)
    }
}
