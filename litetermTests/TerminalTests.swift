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
}