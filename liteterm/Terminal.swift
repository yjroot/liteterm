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
    
    func scrollUp(var lines: Int = 1) {
        while lines-- != 0 {
            let line = self.lines.removeFirst()
            self.lines.append(TerminalLine())
            if self.viewer != nil {
                self.viewer.addScroll(line)
            }
            cursor.row = max(cursor.row - 1, 0)
        }
    }
    
    func scrollDown(var lines: Int = 1) {
        while lines-- != 0{
            self.lines.removeLast()
            self.lines.insert(TerminalLine(), atIndex: 0)
            cursor.row = min(cursor.row + 1, rows - 1)
        }
    }
    
    func setCursor(row: Int = 0, col: Int = 0) {
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
    
    func moveCursor(row: Int = 0, col: Int = 0) {
        self.setCursor(self.cursor.row + row, col: self.cursor.col + col)
    }
    
    func erase(var begin: TerminalPosition! = nil, var end: TerminalPosition! = nil) {
        if begin == nil {
            begin = TerminalPosition(row: 0, col: 0)
        }
        if end == nil {
            end = TerminalPosition(row: self.rows - 1, col: self.cols)
        }
        
        var beginLine = begin.row
        var endLine = end.row
        if beginLine == endLine {
            self.lines[beginLine].erase(begin.col, end: end.col)
            return
        }
        
        if begin.col != 0 {
            self.lines[beginLine].erase(begin.col)
            beginLine++
        }
        if end.col != self.cols {
            self.lines[endLine].erase(end: end.col)
            endLine--
        }
        for row in beginLine ... min(endLine, self.lines.count - 1) {
            self.lines[row] = TerminalLine()
        }
    }
}