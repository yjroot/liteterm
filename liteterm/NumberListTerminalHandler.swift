//
//  NumberListTerminalHandler.swift
//  liteterm
//
//  Created by yjroot on 2016. 1. 4..
//  Copyright © 2016년 Liteterm Team. All rights reserved.
//

import Foundation

class NumberListTerminalHandler: TerminalHandler {
    var list: [Int!] = []
    var current: Int!
    var defaultNumber: Int!
    func putData(data: Character) -> Bool {
        let unicode = data.unicode
        
        if 48 <= unicode && unicode <= 57 {
            if current == nil {
                current = 0
            } else {
                current! *= 10
            }
            current! += Int(unicode) - 48
            return true
        } else if unicode == 59 {
            list.append(current)
            current = nil
            return true
        }
        if current != nil {
            list.append(current)
        }
        
        return false
    }
    
    subscript(key: Int) -> Int {
        get {
            if key < list.count {
                return list[key] ?? self.defaultNumber
            }
            return defaultNumber
        }
    }
}