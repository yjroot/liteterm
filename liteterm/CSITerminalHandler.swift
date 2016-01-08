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
        
        parameters.defaultNumber = 1
        switch data {
        case "A":
            terminal.moveCursor(-parameters[0])
            break
        case "B":
            terminal.moveCursor(parameters[0])
            break
        case "C":
            terminal.moveCursor(0, col: parameters[0])
            break
        case "D":
            terminal.moveCursor(0, col: -parameters[0])
            break
        case "E":
            terminal.setCursor(terminal.cursor.row + parameters[0], col: 0)
            break
        case "F":
            terminal.setCursor(terminal.cursor.row - parameters[0], col: 0)
            break
        case "G":
            self.terminal.moveCursor(0, col: parameters[0])
            break
        case "H":
            self.terminal.setCursor(parameters[0] - 1, col: parameters[1] - 1)
            break
        case "J":
            parameters.defaultNumber = 0
            switch parameters[0] {
            case 3:
                // TODO: Erase saved line
                break
            case 2:
                terminal.erase()
                break
            case 1:
                terminal.erase(end: terminal.cursor)
                break
            case 0:
                terminal.erase(terminal.cursor)
                break
            default:
                break
            }
            self.terminal.setCursor(parameters[0] - 1, col: parameters[1] - 1)
            break
        case "K":
            self.terminal.setCursor(parameters[0] - 1, col: parameters[1] - 1)
            break
        default:
            break
        }
        
        self.terminal.handler = nil
        
        return true
    }
}