//
//  PasswordField.swift
//  liteterm
//
//  Created by yjroot on 2015. 9. 28..
//  Copyright (c) 2015년 Liteterm team. All rights reserved.
//

import Cocoa

class PasswordField: BaseField {
    @IBOutlet weak var secureTextField: NSSecureTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secureTextField.stringValue = self.profileSelector.string
    }
}

extension PasswordField: NSTextFieldDelegate {
    override func controlTextDidChange(obj: NSNotification) {
        self.profileSelector.string = secureTextField.stringValue
    }
}