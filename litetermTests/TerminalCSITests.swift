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
        XCTAssert(terminal.lines.count <= 5)
        self.terminal = nil
        super.tearDown()
    }
    
    // [A
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
    
    // [B
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
    
    // [C
    func testCUF() {
        terminal.putData("\u{1b}[C")
        XCTAssert(terminal.cursor.col == 1)
        terminal.putData("\u{1b}[1C")
        XCTAssert(terminal.cursor.col == 2)
        terminal.putData("\u{1b}[30C")
        XCTAssert(terminal.cursor.col == 9)
    }
    
    // [D
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
    
    // [E
    func testCNL() {
        terminal.putData("012345\u{1b}[E")
        XCTAssert(terminal.cursor.row == 1)
        XCTAssert(terminal.cursor.col == 0)
    }
    
    // [F
    func testCPL() {
        terminal.putData("\n\n012345\u{1b}[F")
        XCTAssert(terminal.cursor.row == 1)
        XCTAssert(terminal.cursor.col == 0)
    }
    
    // [G
    func testCHA() {
        terminal.putData("\u{1b}[G")
        XCTAssert(terminal.cursor.row == 0)
        XCTAssert(terminal.cursor.col == 1)
        terminal.putData("\u{1b}[1G")
        XCTAssert(terminal.cursor.row == 0)
        XCTAssert(terminal.cursor.col == 2)
        terminal.putData("\u{1b}[5G")
        XCTAssert(terminal.cursor.row == 0)
        XCTAssert(terminal.cursor.col == 7)
        terminal.putData("\u{1b}[5G")
        XCTAssert(terminal.cursor.row == 0)
        XCTAssert(terminal.cursor.col == 9)
    }
    
    // [H [f
    func testCUPandHVP() {
        terminal.putData("\u{1b}[2;3H")
        XCTAssert(terminal.cursor.row == 1)
        XCTAssert(terminal.cursor.col == 2)
        terminal.putData("\u{1b}[f")
        XCTAssert(terminal.cursor.row == 0)
        XCTAssert(terminal.cursor.col == 0)
        terminal.putData("\u{1b}[100;100H")
        XCTAssert(terminal.cursor.row == 4)
        XCTAssert(terminal.cursor.col == 9)
        terminal.putData("\u{1b}[0;0f")
        XCTAssert(terminal.cursor.row == 0)
        XCTAssert(terminal.cursor.col == 0)
    }
    
    // [J
    func testED() {
        for _ in 0...4 {
            terminal.putData("0123456789")
        }
        terminal.putData("\u{1b}[3;6H")
        terminal.putData("\u{1b}[J")
        XCTAssert(terminal[2].string == "01234")
        XCTAssert(terminal[3].string == "")
        XCTAssert(terminal[4].string == "")
        terminal.putData("\u{1b}[H")
        for _ in 0...4 {
            terminal.putData("0123456789")
        }
        terminal.putData("\u{1b}[3;6H")
        terminal.putData("\u{1b}[2J")
        XCTAssert(terminal[0].string == "")
        XCTAssert(terminal[1].string == "")
        XCTAssert(terminal[2].string == "")
        XCTAssert(terminal[3].string == "")
        XCTAssert(terminal[4].string == "")
        terminal.putData("\u{1b}[H")
        for _ in 0...4 {
            terminal.putData("0123456789")
        }
        terminal.putData("\u{1b}[3;6H")
        terminal.putData("\u{1b}[1J")
        XCTAssert(terminal[0].string == "")
        XCTAssert(terminal[1].string == "")
        XCTAssert(terminal[2].string == "      6789")
    }
    
    // [K
    func testEL() {
        for _ in 0...4 {
            terminal.putData("0123456789")
        }
        terminal.putData("\u{1b}[1;6H")
        terminal.putData("\u{1b}[K")
        XCTAssert(terminal[0].string == "01234")
        terminal.putData("\u{1b}[B")
        terminal.putData("\u{1b}[0K")
        XCTAssert(terminal[1].string == "01234")
        terminal.putData("\u{1b}[B")
        terminal.putData("\u{1b}[1K")
        XCTAssert(terminal[2].string == "      6789")
        terminal.putData("\u{1b}[B")
        terminal.putData("\u{1b}[2K")
        XCTAssert(terminal[3].string == "")
        XCTAssert(terminal[4].string == "0123456789")
    }
    
    // [S
    func testSU() {
        terminal.putData("0\r\n1\r\n2\r\n3\r\n4\u{1b}[S")
        XCTAssert(terminal[0].string == "1")
        XCTAssert(terminal[4].string == "")
        terminal.putData("\u{1b}[2S")
        XCTAssert(terminal[0].string == "3")
        XCTAssert(terminal[2].string == "")
        XCTAssert(terminal[3].string == "")
        XCTAssert(terminal[4].string == "")
        XCTAssert(terminal.cursor.row == 1)
        terminal.putData("\u{1b}[5S")
        XCTAssert(terminal.cursor.row == 0)
    }
    
    // [T
    func testSD() {
        terminal.putData("0\r\n1\r\n2\r\n3\r\n4\u{1b}[T")
        XCTAssert(terminal[0].string == "")
        XCTAssert(terminal[4].string == "3")
        terminal.putData("\u{1b}[2;0H")
        terminal.putData("\u{1b}[2T")
        XCTAssert(terminal[0].string == "")
        XCTAssert(terminal[1].string == "")
        XCTAssert(terminal[2].string == "")
        XCTAssert(terminal[4].string == "1")
        XCTAssert(terminal.cursor.row == 3)
        terminal.putData("\u{1b}[5T")
        XCTAssert(terminal.cursor.row == 4)
    }
    
    func testSCPandRCP() {
        terminal.putData("\u{1b}[3;4H")
        XCTAssert(terminal.cursor.row == 2)
        XCTAssert(terminal.cursor.col == 3)
        terminal.putData("\u{1b}[s")
        XCTAssert(terminal.savedCursor.row == 2)
        XCTAssert(terminal.savedCursor.col == 3)
        terminal.putData("\u{1b}[H")
        XCTAssert(terminal.cursor.row == 0)
        XCTAssert(terminal.cursor.col == 0)
        terminal.putData("\u{1b}[u")
        XCTAssert(terminal.cursor.row == 2)
        XCTAssert(terminal.cursor.col == 3)
    }

}
