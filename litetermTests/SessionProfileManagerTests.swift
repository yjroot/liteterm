//
//  SessionProfileManagerTests.swift
//  liteterm
//
//  Created by yjroot on 2015. 7. 27..
//  Copyright (c) 2015년 Netsarang. All rights reserved.
//

import Cocoa
import XCTest

class SessionProfileManagerTests: XCTestCase {
    var sessionProfilePath: String = ""
    
    override func setUp() {
        super.setUp()
        self.sessionProfilePath = NSBundle(forClass: SessionProfile.self).resourcePath!
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testSessionList() {
        let manager = SessionProfileManager(profileDirPath: self.sessionProfilePath)
        
        XCTAssert(manager.profiles.contains("local"), "Pass")
        XCTAssert(manager.profiles.contains("ssh"), "Pass")
        XCTAssert(manager.profiles.contains("telnet"), "Pass")
    }
    
    func testExistCheck() {
        let manager = SessionProfileManager(profileDirPath: self.sessionProfilePath)
        
        var profile: SessionProfile? = manager["not_exist"]
        XCTAssert(profile == nil, "Pass")
        
        profile = manager["local"]
        XCTAssert(profile != nil, "Pass")
    }
}
