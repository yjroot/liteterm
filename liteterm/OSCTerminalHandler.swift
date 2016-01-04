//
//  OSCTerminalHandler.swift
//  liteterm
//
//  Created by yjroot on 2016. 1. 1..
//  Copyright © 2016년 Liteterm Team. All rights reserved.
//

import Foundation

class OSCTerminalHandler: TerminalHandler {
    let terminal: Terminal
    init(terminal: Terminal) {
        self.terminal = terminal
    }
    
    func putData(data: Character) -> Bool {
        return true
    }
}