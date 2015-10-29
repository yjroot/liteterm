//
//  FormView.swift
//  liteterm
//
//  Created by yjroot on 2015. 9. 28..
//  Copyright (c) 2015년 Liteterm team. All rights reserved.
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
        let profileSelector = ProfileSelector(profile: self.profile, keyList: path.componentsSeparatedByString("/"))
        let field = FormField(path: path, controller: TextField(label: label, profileSelector: profileSelector)!)
        self.addField(field)
    }
    
    func addPasswordField(label: String, path:String) {
        let profileSelector = ProfileSelector(profile: self.profile, keyList: path.componentsSeparatedByString("/"))
        let field = FormField(path: path, controller: PasswordField(label: label, profileSelector: profileSelector)!)
        self.addField(field)
    }
    
    func addNumberField(label: String, path:String) {
        let profileSelector = ProfileSelector(profile: self.profile, keyList: path.componentsSeparatedByString("/"))
        let field = FormField(path: path, controller: NumberField(label: label, profileSelector: profileSelector)!)
        self.addField(field)
    }
    
    func addSelectField(label: String, path:String, options: [(String, String)]) {
        let profileSelector = ProfileSelector(profile: self.profile, keyList: path.componentsSeparatedByString("/"))
        let controller = SelectField(label: label, profileSelector: profileSelector)!
        controller.options = options

        let field = FormField(path: path, controller: controller)
        self.addField(field)
    }
    
    private func addField(field: FormField) {
        fields.append(field)
        self.addView(field.controller.view, inGravity: NSStackViewGravity.Top)
    }
    
    var _profile: BaseProfile!
    var profile: BaseProfile {
        set(profile) {
            self._profile = profile
        }
        get {
            return self._profile
        }
    }
}
