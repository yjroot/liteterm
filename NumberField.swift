//
//  NumberField.swift
//  lightterm
//
//  Created by yjroot on 2015. 9. 28..
//  Copyright (c) 2015년 Netsarang. All rights reserved.
//

import Cocoa

class NumberField: BaseField {
    @IBOutlet weak var textField: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.formatter = OnlyIntegerValueFormatter()
    }

    class OnlyIntegerValueFormatter: NSNumberFormatter {
        override func isPartialStringValid(partialString: String, newEditingString newString: AutoreleasingUnsafeMutablePointer<NSString?>, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>) -> Bool {
            
            var regex = NSRegularExpression(pattern: "[^\\d]", options: nil, error: nil)!
            if regex.numberOfMatchesInString(partialString, options: nil, range: NSRange(location:0, length:count(partialString))) != 0 {
                NSBeep()
                return false
            }
            return true
        }
    }
}
