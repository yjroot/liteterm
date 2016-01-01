//
//  NumberField.swift
//  liteterm
//
//  Created by yjroot on 2015. 9. 28..
//  Copyright (c) 2015년 Liteterm team. All rights reserved.
//

import Cocoa

class NumberField: BaseField {
    @IBOutlet weak var textField: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.formatter = OnlyIntegerValueFormatter()
        if self.profileSelector.exist {
            textField.integerValue = self.profileSelector.int
        } else {
            textField.placeholderString = self.profileSelector.string
        }
    }

    class OnlyIntegerValueFormatter: NSNumberFormatter {
        override func isPartialStringValid(partialString: String, newEditingString newString: AutoreleasingUnsafeMutablePointer<NSString?>, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>) -> Bool {
            
            let regex = try! NSRegularExpression(pattern: "[^\\d]", options: [])
            if regex.numberOfMatchesInString(partialString, options: [], range: NSRange(location:0, length:partialString.characters.count)) != 0 {
                NSBeep()
                return false
            }
            return true
        }
    }
}

extension NumberField: NSTextFieldDelegate {
    override func controlTextDidChange(obj: NSNotification) {
        self.profileSelector.int = textField.integerValue
        formView.updateFields()
    }
}
