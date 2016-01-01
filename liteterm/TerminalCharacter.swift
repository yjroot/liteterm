//
//  TerminalCharacter.swift
//  liteterm
//
//  Created by yjroot on 2015. 12. 29..
//  Copyright © 2015년 Liteterm Team. All rights reserved.
//

import Foundation

struct TerminalCharacter {
    var chars: [Character] = []
    var attr: TerminalCharacterAttributes = TerminalCharacterAttributes()
    var wcwidth: Int {
        get {
            return 1;
        }
    }
    init(chars: [Character] = [], attr: TerminalCharacterAttributes = TerminalCharacterAttributes()) {
        self.chars = chars
        self.attr = attr
    }
}