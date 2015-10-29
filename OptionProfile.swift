//
//  OptionProfile.swift
//  liteterm
//
//  Created by yjroot on 2015. 9. 10..
//  Copyright (c) 2015년 Liteterm team. All rights reserved.
//

import Foundation
import Cocoa

class OptionProfile {
    static var sharedInstance: OptionProfile {
        struct Holder {
            static var instance: OptionProfile?
        }
        if Holder.instance == nil {
            Holder.instance = OptionProfile()
        }
        return Holder.instance!
    }
    
    var profile: NSMutableDictionary
    
    private init() {
        profile = NSMutableDictionary(contentsOfFile: PathUtils.OptionPath) ?? NSMutableDictionary()
        print(PathUtils.OptionPath)
    }
    
    func save() {
        self.profile.writeToFile(PathUtils.OptionPath, atomically: false)
    }
}

extension OptionProfile: BaseProfile {
    var parent: BaseProfile {
        get {
            return DefaultProfile()
        }
        set(profile) {}
    }
    
    subscript(key : String) -> ProfileSelector {
        get {
            return ProfileSelector(profile: self, keyList: [key])
        }
    }
    
    func getValue(keys: [String]) -> String? {
        var any: AnyObject? = self.profile
        for key in keys {
            switch any {
            case let dictionary as NSMutableDictionary:
                any = dictionary[key]
            default:
                return nil
            }
        }
        
        switch any {
        case let str as String:
            return str
        default:
            return nil
        }
    }
    
    func setValue(keys: [String], value: String)  {
        var dictionary: NSMutableDictionary = self.profile
        var keys = [] + keys
        let lastKey = keys.last!
        keys.removeLast()
        
        for key in keys {
            switch dictionary[key] {
            case let dictValue as NSMutableDictionary:
                dictionary = dictValue
            default:
                let dictNew = NSMutableDictionary()
                dictionary.setObject(dictNew, forKey: key)
                dictionary = dictNew
            }
        }
        dictionary.setValue(value, forKey: lastKey)
    }
    
    var description: String {
        return ""
    }
}
