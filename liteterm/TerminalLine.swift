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
}