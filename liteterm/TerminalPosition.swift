//
//  TerminalCursor.swift
//  liteterm
//
//  Created by yjroot on 2015. 12. 30..
//  Copyright © 2015년 Liteterm Team. All rights reserved.
//

import Foundation

struct TerminalPosition {
    var row: Int = 0
    var col: Int = 0
}

func ==(left:TerminalPosition, right: TerminalPosition) -> Bool {
    return left.row == right.row && left.col == right.col
}

func ...(begin:TerminalPosition, end: TerminalPosition) -> [TerminalPosition] {
    var list: [TerminalPosition] = []
    for y in begin.row...end.row {
        for x in begin.col...end.col {
            list.append(TerminalPosition(row: y, col: x))
        }
    }
    return list
}

func ...(begin:TerminalPosition, end: Int) -> [TerminalPosition] {
    return begin...TerminalPosition(row: begin.row, col: begin.col + end)
}