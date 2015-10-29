//
//  BaseProfile.swift
//  liteterm
//
//  Created by yjroot on 2015. 9. 10..
//  Copyright (c) 2015년 Liteterm team. All rights reserved.
//

import Foundation

protocol BaseProfile: CustomStringConvertible {
    var parent: BaseProfile { get set }
    func getValue(keys: [String]) -> String?
    func setValue(keys: [String], value: String)
    subscript(key : String) -> ProfileSelector { get }
}

class ProfileSelector {
    var profile: BaseProfile
    var list: [String]
    
    init(profile: BaseProfile, keyList: [String]) {
        self.profile = profile
        self.list = keyList
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
            var profile = self.profile
            var result: String? = nil
            
            while result == nil {
                result = profile.getValue(self.list)
                profile = profile.parent
            }
            return result!
        }
        set(newValue) {
            self.profile.setValue(self.list, value: newValue)
        }
    }
    
    var int: Int {
        get {
            return Int(self.value) ?? 0
        }
        set(newValue) {
            self.value = String(newValue)
        }
    }
    
    var string: String {
        get {
            return self.value
        }
        set(newValue) {
            self.value = newValue
        }
    }
    
    var bool: Bool {
        get {
            return self.value.lowercaseString == "true"
        }
        set(newValue) {
            self.value = newValue ? "true" : "false"
        }
    }
}
