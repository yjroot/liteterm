//
//  SessionProfile.swift
//  lightterm
//
//  Created by yjroot on 2015. 7. 24..
//  Copyright (c) 2015년 Netsarang. All rights reserved.
//

import Foundation

class SessionProfile {
    var filename: String? = nil
    
    init(filename: String? = nil) {
        self.filename = filename
    }
    
    subscript(key : String) -> String? {
        get {
            return nil
        }
        set(newValue) {
            
        }
    }
}