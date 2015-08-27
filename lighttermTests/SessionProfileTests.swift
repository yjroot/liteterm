//
//  SessionProfileTests.swift
//  lightterm
//
//  Created by yjroot on 2015. 7. 24..
//  Copyright (c) 2015년 Netsarang. All rights reserved.
//

import Cocoa
import XCTest

class SessionProfileTests: XCTestCase {
    var sessionProfilePath: String = ""
    var manager: SessionProfileManager?

    override func setUp() {
        super.setUp()
        
        self.sessionProfilePath = NSBundle(forClass: SessionProfile.self).resourcePath!
        self.manager = SessionProfileManager(profileDirPath: self.sessionProfilePath)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testNew() {
        let profile = SessionProfile()
        
        XCTAssert(profile.filepath == nil)
        XCTAssert(profile.name == nil)
    }
    
    func testOpen() {
        var sshProfile = self.manager!["ssh"]!
        XCTAssert(sshProfile.name == "ssh")
    }
    
    func testGetValue() {
        var sshProfile = self.manager!["ssh"]!
        
        XCTAssert(sshProfile["connection"]["host"].value == "www.lightterm.com")
        XCTAssert(sshProfile["connection"]["protocol"].value == "ssh")
        XCTAssert(sshProfile["connection"]["ssh"]["port"].value == "22")
        XCTAssert(sshProfile["not"]["exist"].value == "")
    }
}
