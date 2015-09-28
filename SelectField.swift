//
//  SelectField.swift
//  lightterm
//
//  Created by yjroot on 2015. 9. 28..
//  Copyright (c) 2015년 Netsarang. All rights reserved.
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
        popupButton.addItemsWithTitles(self.options.keys.array)
    }
    
    private var _options: [String:String] = [:]
    var options: [String:String] {
        get {
            return _options
        }
        set (options) {
            _options = options
            updateItems()
        }
    }
}
