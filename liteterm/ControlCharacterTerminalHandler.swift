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
        self.terminal.cursor.col--
        if self.terminal.cursor.col < 0 {
            self.terminal.cursor.col += self.terminal.cols
            self.terminal.cursor.row--
        }
        if self.terminal.cursor.row < 0 {
            self.terminal.cursor.row = 0
            self.terminal.cursor.col = 0
        }
    }
    
    func newline() {
        self.terminal.cursor.row++
    }
    
    func carriagereturn() {
        self.terminal.cursor.col = 0
    }
    
    func escape() {
        self.terminal.handler = EscapeSequenceTerminalHandler(terminal: self.terminal)
    }
}