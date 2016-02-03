//
//  ControlCharacterTerminalHandler.swift
//  liteterm
//
//  Created by yjroot on 2016. 1. 1..
//  Copyright © 2016년 Liteterm Team. All rights reserved.
//

import Foundation

class ControlCharacterTerminalHandler: TerminalHandler {
    let terminal: Terminal
    init(terminal: Terminal) {
        self.terminal = terminal
    }
    
    func putData(data: Character) -> Bool {
        switch data {
        case "\u{8}":
            backspace()
            break
        case "\n":
            newline()
            break
        case "\r":
            carriagereturn()
            break
        case "\r\n":
            carriagereturn()
            newline()
            break
        case "\u{1b}":
            escape()
            break
        default:
            return false
        }
        
        return true
    }
    
    func backspace() {
        var cursor = self.terminal.cursor
        cursor.col--
        if cursor.col < 0 {
            cursor.col += self.terminal.cols
            cursor.row--
        }
        if cursor.row < 0 {
            cursor.row = 0
            cursor.col = 0
        }
        self.terminal.setCursor(cursor)
    }
    
    func newline() {
        if terminal.cursor.row == terminal.scrollBottom {
            self.terminal.scrollUp()
        }
        self.terminal.moveCursor(1)
    }
    
    func carriagereturn() {
        self.terminal.setCursor(self.terminal.cursor.row, col: 0)
    }
    
    func escape() {
        self.terminal.handler = EscapeSequenceTerminalHandler(terminal: self.terminal)
    }
}