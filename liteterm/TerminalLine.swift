//
//  TerminalLine.swift
//  liteterm
//
//  Created by yjroot on 2015. 12. 29..
//  Copyright © 2015년 Liteterm Team. All rights reserved.
//

import Foundation

class TerminalLine {
    var chars: [TerminalCharacter] = []
    
    init() {
    }
    
    subscript(key: Int) -> TerminalCharacter {
        get {
            if key < self.chars.count {
                return self.chars[key]
            }
            
            return TerminalCharacter()
        }
        set(value) {
            while self.chars.count <= key {
                self.chars.append(TerminalCharacter())
            }
            
            return self.chars[key] = value
        }
    }
    
    var count: Int {
        return self.chars.count
    }
    
    var string: String {
        get {
            return self.chars.map({ (char) -> String in
                return char.string
            }).joinWithSeparator("")
        }
    }
    
    func erase(var begin: Int! = nil, var end: Int! = nil) {
        if begin == nil {
            begin = 0
        }
        if end == nil {
            end = chars.count
        }
        if end < chars.count - 1 {
            for col in begin ... end {
                chars[col] = TerminalCharacter()
            }
        } else if begin < chars.count {
            chars = [TerminalCharacter](chars[0..<begin])
        }
    }
}