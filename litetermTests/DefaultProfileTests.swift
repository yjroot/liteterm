//
//  DefaultProfileTests.swift
//  liteterm
//
//  Created by yjroot on 2015. 9. 10..
//  Copyright (c) 2015년 Liteterm team. All rights reserved.
//

import Cocoa
import XCTest

class DefaultProfileTests: XCTestCase {
    func testDefault() {
        let profile = DefaultProfile()
        XCTAssert(profile["connection"]["ssh"]["port"].value == "22")
        XCTAssert(profile["terminal"]["type"].value == "xterm")
    }
    
    func testNotExist() {
        let profile = DefaultProfile()
        XCTAssert(profile["not"]["exist"].value == "")
    }
}
