//
//  TerminalTests.swift
//  liteterm
//
//  Created by yjroot on 2016. 1. 1..
//  Copyright © 2016년 Liteterm Team. All rights reserved.
//

import XCTest

class TerminalTests: XCTestCase {
    var terminal: Terminal!
    
    override func setUp() {
        super.setUp()
        self.terminal = Terminal(cols:10, rows: 5)
    }
    
    override func tearDown() {
        self.terminal = nil
        super.tearDown()
    }
    
    func testSetCursor() {
        terminal.setCursor(0, col: 0)
        XCTAssert(terminal.cursor.row == 0)
        XCTAssert(terminal.cursor.col == 0)
        terminal.setCursor(100, col: 100)
        XCTAssert(terminal.cursor.row == 4)
        XCTAssert(terminal.cursor.col == 9)
    }
    
    func testMoveCursor() {
        self.terminal.moveCursor(1, col: 1)
        XCTAssert(terminal.cursor.row == 1)
        XCTAssert(terminal.cursor.col == 1)
        self.terminal.moveCursor(100, col: 100)
        XCTAssert(terminal.cursor.row == 4)
        XCTAssert(terminal.cursor.col == 9)
        self.terminal.moveCursor(-2, col: -2)
        XCTAssert(terminal.cursor.row == 2)
        XCTAssert(terminal.cursor.col == 7)
    }
    
    func testErase() {
        for _ in 0...4 {
            terminal.putData("0123456789")
        }
        terminal.erase(TerminalPosition(row: 3, col:5))
        XCTAssert(terminal[3].string == "01234")
        XCTAssert(terminal[4].string == "")
        
        terminal.erase(end: TerminalPosition(row: 1, col:5))
        XCTAssert(terminal[0].string == "")
        XCTAssert(terminal[1].string == "      6789")
        
        terminal.erase(TerminalPosition(row: 1, col:9))
        XCTAssert(terminal[1].string == "      678")
    }

    func testInputText() {
        terminal.putData("liteterm")
        XCTAssert(terminal[0].string == "liteterm")
        XCTAssert(terminal[0][0].chars == ["l"])
        XCTAssert(terminal[0][1].chars == ["i"])
        XCTAssert(terminal[0][2].chars == ["t"])
        XCTAssert(terminal[0][3].chars == ["e"])
        XCTAssert(terminal[0][4].chars == ["t"])
        XCTAssert(terminal[0][5].chars == ["e"])
        XCTAssert(terminal[0][6].chars == ["r"])
        XCTAssert(terminal[0][7].chars == ["m"])
        XCTAssert(terminal[0][8].chars == [])
        XCTAssert(terminal.cursor.row == 0)
        XCTAssert(terminal.cursor.col == 8)
    }
    
    func testAutoWrap() {
        terminal.putData("0123456789liteterm")
        XCTAssert(terminal[1].string == "liteterm")
    }
    
    func testAutoWrapCursor() {
        for _ in 0...4 {
            terminal.putData("0123456789")
        }
        XCTAssert(terminal[0].string == "0123456789")
        XCTAssert(terminal[1].string == "0123456789")
        XCTAssert(terminal[2].string == "0123456789")
        XCTAssert(terminal[3].string == "0123456789")
        XCTAssert(terminal[4].string == "0123456789")
        XCTAssert(terminal.cursor.row == 4)
        XCTAssert(terminal.cursor.col == 10)
    }
    
    func testNewline() {
        terminal.putData("lite\nterm")
        XCTAssert(terminal[0].string == "lite")
        XCTAssert(terminal[1].string == "    term")
    }
    
    func testCarriageReturn() {
        terminal.putData("........\rliteterm")
        XCTAssert(terminal[0].string == "liteterm")
    }
    
    func testCRLF() {
        terminal.putData("0\r\n1\n\r2\n3\r4")
        XCTAssert(terminal[0].string == "0")
        XCTAssert(terminal[1].string == "1")
        XCTAssert(terminal[2].string == "2")
        XCTAssert(terminal[3].string == "43")
    }
    
    func testScrollUp() {
        terminal.putData("0\r\n1\r\n2\r\n3\r\n4\r\n5")
        XCTAssert(terminal[0].string == "1")
        XCTAssert(terminal[1].string == "2")
        XCTAssert(terminal[2].string == "3")
        XCTAssert(terminal[3].string == "4")
        XCTAssert(terminal[4].string == "5")
    }
    
    func testBackspace() {
        terminal.putData("\u{8}")
        XCTAssert(terminal.cursor.row == 0)
        XCTAssert(terminal.cursor.col == 0)
        terminal.putData("test")
        XCTAssert(terminal.cursor.row == 0)
        XCTAssert(terminal.cursor.col == 4)
        terminal.putData("\u{8}")
        XCTAssert(terminal.cursor.row == 0)
        XCTAssert(terminal.cursor.col == 3)
        terminal.putData("\r0123456789\u{8}")
        XCTAssert(terminal.cursor.row == 0)
        XCTAssert(terminal.cursor.col == 9)
        terminal.putData("\r01234567890\u{8}")
        XCTAssert(terminal.cursor.row == 1)
        XCTAssert(terminal.cursor.col == 0)
        terminal.putData("\u{8}")
        XCTAssert(terminal.cursor.row == 0)
        XCTAssert(terminal.cursor.col == 9)
    }
    
    func testEscape() {
        XCTAssert(terminal.cursor.row == 0)
        XCTAssert(terminal.cursor.col == 0)
        terminal.putData("\u{1b}[2B")
        XCTAssert(terminal.cursor.row == 2)
        XCTAssert(terminal.cursor.col == 0)
        terminal.putData("\u{1b}[2;3H")
        XCTAssert(terminal.cursor.row == 1)
        XCTAssert(terminal.cursor.col == 2)
        terminal.putData("\u{1b}[;2H")
        XCTAssert(terminal.cursor.row == 0)
        XCTAssert(terminal.cursor.col == 1)
        terminal.putData("\u{1b}[2;H")
        XCTAssert(terminal.cursor.row == 1)
        XCTAssert(terminal.cursor.col == 0)
    }
}