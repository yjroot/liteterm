//
//  InsertTerminalHandler.swift
//  liteterm
//
//  Created by yjroot on 2016. 1. 1..
//  Copyright © 2016년 Liteterm Team. All rights reserved.
//

import Foundation

class InsertTerminalHandler: TerminalHandler {
    let terminal: Terminal
    init(terminal: Terminal) {
        self.terminal = terminal
    }
    
    func putData(data: Character) -> Bool {
        if data.unicode < 32 {
            return false
        }
        let char = TerminalCharacter(chars: data, attr: self.terminal.attr)
        insertChar(char)
        return true
    }
    
    func insertChar(char: TerminalCharacter) {
        var cursor = self.terminal.cursor
        if self.terminal.cols < char.wcwidth + cursor.col {
            cursor.col = 0
            cursor.row++
        }
        self.terminal[cursor.row][cursor.col] = char
        self.terminal.updateText(cursor, length: char.wcwidth)
        cursor.col += char.wcwidth
        self.terminal.setCursor(cursor)
    }
}

extension Character {
    var unicode: UInt32 {
        let characterString = String(self)
        let scalars = characterString.unicodeScalars
        
        return scalars[scalars.startIndex].value
    }
}