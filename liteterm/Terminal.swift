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
    var savedCursor: TerminalPosition = TerminalPosition()
    var cols: Int
    var rows: Int
    var viewer: TerminalView!
    var scrollTop: Int
    var scrollBottom: Int
    
    init(cols: Int, rows: Int) {
        self.cols = cols
        self.rows = rows
        for _ in 0..<rows {
            self.lines.append(TerminalLine())
        }
        scrollTop = 0
        scrollBottom = rows - 1
        let defaultHandlers = TerminalHandlerList()
        defaultHandlers.add(InsertTerminalHandler(terminal: self))
        defaultHandlers.add(ControlCharacterTerminalHandler(terminal: self))
        self.defaultHandler = defaultHandlers
    }
    
    subscript(key: Int) -> TerminalLine {
        get {
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
    }
    
    func putData(data: [Character]) {
        for c in data {
            self.putData(c)
        }
    }
    
    func putData(data: String) {
        self.putData(Array(data.characters))
    }
    
    func scrollRange(var lines: Int, var top: Int! = nil, var bottom: Int! = nil) {
        top = max(0, top ?? 0)
        bottom = min(self.rows - 1, bottom ?? self.rows - 1)
        if top > bottom {
            return
        }
        
        lines = min(lines, bottom - top + 1)
        lines = max(lines, -(bottom - top + 1))
        
        while 0 < lines {
            self.lines.removeAtIndex(bottom)
            self.lines.insert(TerminalLine(), atIndex: top)
            if (top..<bottom).contains(cursor.row) {
                cursor.row++
            }
            lines--
        }
        
        while lines < 0 {
            let line = self.lines.removeAtIndex(top)
            self.lines.insert(TerminalLine(), atIndex: bottom)
            if top == 0 && self.viewer != nil {
                self.viewer.addScroll(line)
            }
            if ((top + 1)...bottom).contains(cursor.row) {
                cursor.row--
            }
            lines++
        }
    }
    
    func scrollUp(lines: Int = 1) {
        self.scrollRange(-lines, top: self.scrollTop, bottom: self.scrollBottom)
    }
    
    func scrollDown(lines: Int = 1) {
        self.scrollRange(lines, top: self.scrollTop, bottom: self.scrollBottom)
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
    
    func saveCursor() {
        self.savedCursor = self.cursor
    }
    
    func restoreCursor() {
        self.setCursor(self.savedCursor.row, col: self.savedCursor.col)
    }
    
    func erase(var begin: TerminalPosition! = nil, var end: TerminalPosition! = nil) {
        begin = begin ?? TerminalPosition(row: 0, col: 0)
        end = end ?? TerminalPosition(row: self.rows - 1, col: self.cols)
        
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