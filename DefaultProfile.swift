//
//  DefaultProfile.swift
//  lightterm
//
//  Created by yjroot on 2015. 9. 10..
//  Copyright (c) 2015년 Netsarang. All rights reserved.
//

import Foundation

/*enum DefaultObject {
    case StringObject(String)
    case ArrayObject(Array<DefaultObject>)
    case DictObject(Dictionary<String, DefaultObject>)
}*/

class DefaultProfile {
    static let profile = [
        "connection": [
            "host": "lightterm.com",
            "protocol": "ssh",
            "ssh": [
                "auth": [
                    "username": "",
                    "password": ""
                ],
                "port": "22"
            ],
            "telnet": [
                "auth": [
                    "username": "",
                    "password": ""
                ],
                "port": "23"
            ]
        ],
        "terminal": [
            "type": "xterm"
        ]
    ]
}

extension DefaultProfile: BaseProfile {
    var parent: BaseProfile {
        get {
            return self
        }
        set(profile) {}
    }
    
    subscript(key : String) -> ProfileSelector {
        get {
            return ProfileSelector(profile: self, key: key)
        }
    }
    
    func getValue(keys: [String]) -> String? {
        var any: AnyObject? = DefaultProfile.profile
        for key in keys {
            switch any {
            case let dictionary as NSDictionary:
                any = dictionary[key]
            default:
                return ""
            }
        }
        
        switch any {
        case let str as String:
            return str
        default:
            return ""
        }
    }
    
    func setValue(keys: [String], value: String)  {
    }
    
    var description: String {
        return ""
    }
}