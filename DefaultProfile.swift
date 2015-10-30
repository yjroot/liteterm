//
//  DefaultProfile.swift
//  liteterm
//
//  Created by yjroot on 2015. 9. 10..
//  Copyright (c) 2015년 Liteterm team. All rights reserved.
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
            "host": "liteterm.com",
            "protocol": "ssh",
            "ssh": [
                "auth": [
                    "method": "password",
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
        ],
        "option": [
            "HideTabOnlyOneTab": "false",
            "HideTabNumber": "false",
            "AutoHideMenuBar": "false",
            "HoldingSecondsForShowingTab": "5",
            "CursorAppearance":"1"
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
