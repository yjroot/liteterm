//
//  OptionProfileTests.swift
//  liteterm
//
//  Created by yjroot on 2015. 9. 13..
//  Copyright (c) 2015년 Netsarang. All rights reserved.
//

import Cocoa
import XCTest

class OptionProfileTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSet() {
        let profile = OptionProfile.sharedInstance
        profile["option"]["profilepath"].value = PathUtils.AppSupportDir
        XCTAssert(profile["option"]["profilepath"].value == PathUtils.AppSupportDir, "Pass")
    }
    
    func testSave() {
        let profile = OptionProfile.sharedInstance
        profile["option"]["profilepath"].value = PathUtils.AppSupportDir
        profile.save()
        
        let dict = NSMutableDictionary(contentsOfFile: PathUtils.OptionPath)!
        let option = dict["option"] as! NSMutableDictionary
        XCTAssert(option["profilepath"] as! String == PathUtils.AppSupportDir, "Pass")
    }
    
    func testDefault() {
        let profile = OptionProfile.sharedInstance
        XCTAssert(profile["connection"]["ssh"]["port"].value == "22")
    }
}
