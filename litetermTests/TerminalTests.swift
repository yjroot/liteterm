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
}