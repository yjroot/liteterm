//
//  TerminalHandlerList.swift
//  liteterm
//
//  Created by yjroot on 2016. 1. 2..
//  Copyright © 2016년 Liteterm Team. All rights reserved.
//

import Foundation

class TerminalHandlerList: TerminalHandler {
    var handlers: [TerminalHandler] = []
    
    func putData(data: Character) -> Bool {
        for handler in self.handlers {
            if handler.putData(data) {
                return true
            }
        }
        return false
    }
    
    func add(handler: TerminalHandler) {
        self.handlers.append(handler)
    }
}