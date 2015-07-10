//
//  Session.swift
//  lightterm
//
//  Created by yjroot on 2015. 7. 3..
//  Copyright (c) 2015년 Netsarang. All rights reserved.
//

import Cocoa

class Session: NSObject {
    @IBOutlet var hostField: NSTextField!
    @IBOutlet var protocolField: NSComboBox!
    @IBOutlet var portField: NSTextField!
    @IBOutlet var usernameField: NSTextField!
    @IBOutlet var passwordField: NSSecureTextField!
}
