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
    
    init(cols: Int, rows: Int) {
        self.cols = cols
        self.rows = rows
        self.handler = InsertTerminalHandler(terminal: self)
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
    func putData(data: [Character]) {
        for c in data {
            self.handler.putData(c)
        }
    }
    
    func putData(data: String) {
        self.putData(Array(data.characters))
    }
}