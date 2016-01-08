//
//  CSITerminalHandler.swift
//  liteterm
//
//  Created by yjroot on 2016. 1. 1..
//  Copyright © 2016년 Liteterm Team. All rights reserved.
//

import Foundation

class CSITerminalHandler: TerminalHandler {
    //Control Sequence Introducer
    
    let terminal: Terminal
    let parameters: NumberListTerminalHandler
    init(terminal: Terminal) {
        self.terminal = terminal
        self.parameters = NumberListTerminalHandler()
    }
    
    func putData(data: Character) -> Bool {
        if parameters.putData(data) {
            return true
        }
        
        switch data {
        case "A":
            parameters.defaultNumber = 1
            terminal.cursor.row = max(terminal.cursor.row - parameters[0], 0)
            break
        case "B":
            parameters.defaultNumber = 1
            terminal.cursor.row = min(terminal.cursor.row + parameters[0],
                                      terminal.rows - 1)
            break
        case "C":
            parameters.defaultNumber = 1
            terminal.cursor.col = min(terminal.cursor.col + parameters[0],
                                      terminal.cols - 1)
            break
        case "D":
            parameters.defaultNumber = 1
            terminal.cursor.col = max(terminal.cursor.col - parameters[0], 0)
            break
        case "E":
            parameters.defaultNumber = 1
            terminal.cursor.col = 0
            terminal.cursor.row = min(terminal.cursor.row + parameters[0],
                terminal.rows - 1)
            break
        case "F":
            parameters.defaultNumber = 1
            terminal.cursor.col = 0
            terminal.cursor.row = max(terminal.cursor.row - parameters[0], 0)
            break
        case "G":
            parameters.defaultNumber = 1
            self.terminal.moveCursor(0, col: parameters[0])
            break
        case "H":
            parameters.defaultNumber = 1
            self.terminal.setCursor(parameters[0] - 1, col: parameters[1] - 1)
            break
        default:
            break
        }
        
        self.terminal.handler = nil
        
        return true
    }
}