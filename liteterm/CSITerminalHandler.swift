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
        case "B", "e":
            terminal.moveCursor(parameters[0])
            break
        case "C", "a":
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
        case "G", "`":
            self.terminal.setCursor(terminal.cursor.row, col: parameters[0] - 1)
            break
        case "d":
            self.terminal.setCursor(parameters[0] - 1, col: terminal.cursor.col)
            break
        case "H", "f":
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
            break
        case "K":
            parameters.defaultNumber = 0
            switch parameters[0] {
            case 2:
                terminal.erase(TerminalPosition(row: terminal.cursor.row,
                    col: 0),
                    end: TerminalPosition(row: terminal.cursor.row,
                        col: terminal.cols))
                break
            case 1:
                terminal.erase(TerminalPosition(row: terminal.cursor.row,
                    col: 0), end: terminal.cursor)
                break
            case 0:
                terminal.erase(terminal.cursor,
                    end: TerminalPosition(row: terminal.cursor.row,
                        col: terminal.cols))
                break
            default:
                break
            }
            break
        case "S":
            terminal.scrollUp(parameters[0])
            break
        case "T":
            terminal.scrollDown(parameters[0])
            break
        case "s":
            terminal.saveCursor()
            break
        case "u":
            terminal.restoreCursor()
            break
            
        default:
            break
        }
        
        self.terminal.handler = nil
        
        return true
    }
}