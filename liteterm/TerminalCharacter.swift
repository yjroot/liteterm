//
//  TerminalCharacter.swift
//  liteterm
//
//  Created by yjroot on 2015. 12. 29..
//  Copyright © 2015년 Liteterm Team. All rights reserved.
//

import Foundation

struct TerminalCharacter {
    var chars: Character!
    var attr: TerminalCharacterAttributes = TerminalCharacterAttributes()
    var wcwidth: Int {
        if chars == nil {
            return 1
        }
        let characterString = String(chars)
        
        for unicodeScalar in characterString.unicodeScalars {
            let width = mk_wcwidth(Int32(unicodeScalar.value))
            if width > 0 {
                return Int(width)
            }
        }
        return 1
    }
    
    init(chars: Character! = nil, attr: TerminalCharacterAttributes = TerminalCharacterAttributes()) {
        self.chars = chars
        self.attr = attr
    }
    
    var string: String {
        if chars == nil {
            return " "
        }
        return String(self.chars)
    }
}