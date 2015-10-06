//
//  BaseField.swift
//  liteterm
//
//  Created by yjroot on 2015. 9. 28..
//  Copyright (c) 2015년 Liteterm team. All rights reserved.
//

import Cocoa

class BaseField: NSViewController {
    @IBOutlet weak var labelView: NSTextField!
    
    var fieldLabel: String
    var fieldValue: String
    var fieldPlaceholder: String
    
    init?(label: String, value: String? = nil, placeholder: String? = nil) {
        self.fieldLabel = label
        self.fieldValue = value ?? ""
        self.fieldPlaceholder = placeholder ?? ""
        super.init(nibName: (NSStringFromClass(self.dynamicType) as NSString).pathExtension, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.fieldLabel = ""
        self.fieldValue = ""
        self.fieldPlaceholder = ""
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.labelView.stringValue = fieldLabel
    }
}
