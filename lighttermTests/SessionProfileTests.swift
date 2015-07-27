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
}
