//
//  ControlCharacterTerminalHandler.swift
//  liteterm
//
//  Created by yjroot on 2016. 1. 1..
//  Copyright © 2016년 Liteterm Team. All rights reserved.
//

import Foundation

class ControlCharacterTerminalHandler: TerminalHandler {
    let termianl: Terminal
    required init(terminal: Terminal) {
        self.termianl = terminal
    }
    
    func putData(data: Character) -> Bool {
        switch (data) {
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
        default:
            return false
        }
        
        return true
    }
    func backspace() {
        self.termianl.cursor.col--
        if self.termianl.cursor.col < 0 {
            self.termianl.cursor.col += self.termianl.cols
            self.termianl.cursor.row--
        }
        if self.termianl.cursor.row < 0 {
            self.termianl.cursor.row = 0
            self.termianl.cursor.col = 0
        }
    }
    
    func newline() {
        self.termianl.cursor.row++
    }
    
    func carriagereturn() {
        self.termianl.cursor.col = 0
    }
}