//
//  InsertTerminalHandler.swift
//  liteterm
//
//  Created by yjroot on 2016. 1. 1..
//  Copyright © 2016년 Liteterm Team. All rights reserved.
//

import Foundation

class InsertTerminalHandler: TerminalHandler {
    let termianl: Terminal
    required init(terminal: Terminal) {
        self.termianl = terminal
    }
    
    func putData(data: Character) -> Bool {
        let char = TerminalCharacter(chars: [data], attr: self.termianl.attr)
        insertChar(char)
        return true
    }
    
    func insertChar(char: TerminalCharacter) {
        var cursor = self.termianl.cursor
        if self.termianl.cols < char.wcwidth + cursor.col {
            cursor.col = 0
            cursor.row++
        }
        self.termianl[cursor.row][cursor.col] = char
        cursor.col += char.wcwidth
        self.termianl.cursor = cursor
    }
}