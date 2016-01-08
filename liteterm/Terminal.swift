//
//  Terminal.swift
//  liteterm
//
//  Created by yjroot on 2015. 11. 8..
//  Copyright © 2015년 Liteterm Team. All rights reserved.
//

import Foundation

class Terminal {
    var attr: TerminalCharacterAttributes = TerminalCharacterAttributes()
    var lines: [TerminalLine] = []
    var cursor: TerminalPosition = TerminalPosition()
    var cols: Int
    var rows: Int
    var viewer: TerminalView!
    
    init(cols: Int, rows: Int) {
        self.cols = cols
        self.rows = rows
        let defaultHandlers = TerminalHandlerList()
        defaultHandlers.add(InsertTerminalHandler(terminal: self))
        defaultHandlers.add(ControlCharacterTerminalHandler(terminal: self))
        self.defaultHandler = defaultHandlers
    }
    
    subscript(key: Int) -> TerminalLine {
        get {
            while self.lines.count <= key {
                self.lines.append(TerminalLine())
            }
            return self.lines[key]
        }
    }
    
    var handler: TerminalHandler!
    var defaultHandler: TerminalHandler!
    func putData(data: Character) {
        if self.handler != nil {
            self.handler.putData(data)
        } else {
            self.defaultHandler.putData(data)
        }
        while self.rows <= self.cursor.row {
            self.scrollUp()
        }
    }
    
    func putData(data: [Character]) {
        for c in data {
            self.putData(c)
        }
    }
    
    func putData(data: String) {
        self.putData(Array(data.characters))
    }
    
    func scrollUp() {
        let line = self.lines.removeFirst()
        if self.viewer != nil {
            self.viewer.addScroll(line)
        }
        self.cursor.row--
    }
    
    func setCursor(row: Int, col: Int) {
        self.cursor.row = row
        self.cursor.col = col

        if self.cursor.row < 0 {
            self.cursor.row = 0
        } else if self.rows <= self.cursor.row {
            self.cursor.row = self.rows - 1
        }

        if self.cursor.col < 0 {
            self.cursor.col = 0
        } else if self.cols <= self.cursor.col {
            self.cursor.col = self.cols - 1
        }
    }
    
    func moveCursor(row: Int, col: Int) {
        self.setCursor(self.cursor.row + row, col: self.cursor.col + col)
    }
}