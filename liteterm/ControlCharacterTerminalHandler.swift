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
    
    func newline() {
        self.termianl.cursor.row++
    }
    
    func carriagereturn() {
        self.termianl.cursor.col = 0
    }
}