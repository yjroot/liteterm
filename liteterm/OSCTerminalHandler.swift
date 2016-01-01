//
//  OSCTerminalHandler.swift
//  liteterm
//
//  Created by yjroot on 2016. 1. 1..
//  Copyright © 2016년 Liteterm Team. All rights reserved.
//

import Foundation

class OSCTerminalHandler: TerminalHandler {
    let termianl: Terminal
    required init(terminal: Terminal) {
        self.termianl = terminal
    }
    
    func putData(data: Character) -> Bool {
        return true
    }
}