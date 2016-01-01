//
//  TextField.swift
//  liteterm
//
//  Created by yjroot on 2015. 9. 28..
//  Copyright (c) 2015년 Liteterm team. All rights reserved.
//

import Cocoa

class TextField: BaseField {
    @IBOutlet weak var textField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.profileSelector.exist {
            textField.stringValue = self.profileSelector.string
        } else {
            textField.placeholderString = self.profileSelector.string
        }
    }
}

extension TextField: NSTextFieldDelegate {
    override func controlTextDidChange(obj: NSNotification) {
        self.profileSelector.string = textField.stringValue
        formView.updateFields()
    }
}