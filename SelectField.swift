//
//  SelectField.swift
//  liteterm
//
//  Created by yjroot on 2015. 9. 28..
//  Copyright (c) 2015년 Liteterm team. All rights reserved.
//

import Cocoa

class SelectField: BaseField {
    @IBOutlet weak var popupButton: NSPopUpButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateItems()
    }
    
    private func updateItems() {
        if popupButton == nil {
            return
        }
        popupButton.removeAllItems()
        popupButton.addItemsWithTitles(self.options.map({ (key: String, value: String) -> String in
            return key
        }))
        
        let valueIndex = self.options.map({ (key: String, value: String) -> String in
            return value
        }).indexOf(self.profileSelector.string)
        
        if valueIndex != nil {
            popupButton.selectItemAtIndex(Int(valueIndex!))
        }
    }
    
    private var _options: [(String, String)] = []
    var options: [(String,String)] {
        get {
            return _options
        }
        set (options) {
            _options = options
            updateItems()
        }
    }
    
    @IBAction func onChange(sender: AnyObject) {
        profileSelector.string = self.options[popupButton.indexOfSelectedItem].1
        formView.updateFields()
    }
}
