//
//  BaseProfile.swift
//  lightterm
//
//  Created by yjroot on 2015. 9. 10..
//  Copyright (c) 2015년 Netsarang. All rights reserved.
//

import Foundation

protocol BaseProfile: Printable {
    func getValue(keys: [String]) -> String
    func setValue(keys: [String], value: String)
    subscript(key : String) -> ProfileSelector { get }
}

class ProfileSelector {
    var profile: BaseProfile
    var list: [String]
    
    init(profile: BaseProfile, key: String) {
        self.profile = profile
        self.list = [key]
    }
    
    init(selector: ProfileSelector, key: String) {
        self.profile = selector.profile
        self.list = selector.list + [key]
    }
    
    subscript(key : String) -> ProfileSelector {
        get {
            return ProfileSelector(selector: self, key: key)
        }
    }
    
    var value: String {
        get {
            return self.profile.getValue(self.list)
        }
        set(newValue) {
            self.profile.setValue(self.list, value: newValue)
        }
    }
}