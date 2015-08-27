//
//  SessionProfile.swift
//  lightterm
//
//  Created by yjroot on 2015. 7. 24..
//  Copyright (c) 2015년 Netsarang. All rights reserved.
//

import Foundation

class SessionProfile {
    var filepath: String? = nil
    var name: String? = nil
    
    init(filepath: String? = nil) {
        if filepath != nil {
            self.filepath = filepath
            self.name = filepath?.lastPathComponent.stringByDeletingPathExtension
        }
    }
    
    subscript(key : String) -> String? {
        get {
            return nil
        }
        set(newValue) {
            
        }
    }
}