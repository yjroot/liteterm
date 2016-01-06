//
//  TerminalCSITests.swift
//  liteterm
//
//  Created by yjroot on 2016. 1. 6..
//  Copyright © 2016년 Liteterm Team. All rights reserved.
//

import XCTest

class TerminalCSITests: XCTestCase {
    var terminal: Terminal!
    
    override func setUp() {
        super.setUp()
        self.terminal = Terminal(cols:10, rows: 5)
    }
    
    override func tearDown() {
        self.terminal = nil
        super.tearDown()
    }
    
    func testCUU() {
        terminal.putData("\u{1b}[A")
        XCTAssert(terminal.cursor.row == 0)
        terminal.putData("\u{1b}[1A")
        XCTAssert(terminal.cursor.row == 0)
        terminal.putData("\u{1b}[3A")
        XCTAssert(terminal.cursor.row == 0)
        terminal.putData("\u{1b}[3B")
        XCTAssert(terminal.cursor.row == 3)
        terminal.putData("\u{1b}[A")
        XCTAssert(terminal.cursor.row == 2)
        terminal.putData("\u{1b}[3A")
        XCTAssert(terminal.cursor.row == 0)
    }
    
    func testCUD() {
        terminal.putData("\u{1b}[B")
        XCTAssert(terminal.cursor.row == 1)
        terminal.putData("\u{1b}[1B")
        XCTAssert(terminal.cursor.row == 2)
        terminal.putData("\u{1b}[3B")
        XCTAssert(terminal.cursor.row == 4)
        terminal.putData("\u{1b}[B")
        XCTAssert(terminal.cursor.row == 4)
    }
    
    func testCUF() {
        terminal.putData("\u{1b}[C")
        XCTAssert(terminal.cursor.col == 1)
        terminal.putData("\u{1b}[1C")
        XCTAssert(terminal.cursor.col == 2)
        terminal.putData("\u{1b}[30C")
        XCTAssert(terminal.cursor.col == 9)
    }
    
    func testCUB() {
        terminal.putData("\u{1b}[9C")
        XCTAssert(terminal.cursor.col == 9)
        terminal.putData("\u{1b}[D")
        XCTAssert(terminal.cursor.col == 8)
        terminal.putData("\u{1b}[1D")
        XCTAssert(terminal.cursor.col == 7)
        terminal.putData("\u{1b}[30D")
        XCTAssert(terminal.cursor.col == 0)
    }
    
    func testCNL() {
        terminal.putData("012345\u{1b}[E")
        XCTAssert(terminal.cursor.row == 1)
        XCTAssert(terminal.cursor.col == 0)
    }
    
    func testCPL() {
        terminal.putData("\n\n012345\u{1b}[F")
        XCTAssert(terminal.cursor.row == 1)
        XCTAssert(terminal.cursor.col == 0)
    }
    
}
