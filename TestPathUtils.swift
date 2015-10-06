//
//  TestPathUtils.swift
//  liteterm
//
//  Created by yjroot on 2015. 9. 13..
//  Copyright (c) 2015년 Netsarang. All rights reserved.
//

import Foundation

class PathUtils {
    static private func mergePath(a: String, b: String) ->String {
        let url = NSURL(string: b, relativeToURL: NSURL(fileURLWithPath: a))!
        return url.path!
    }
    
    static var AppSupportDir: String {
        return NSBundle(forClass: SessionProfile.self).resourcePath!
    }

    static func AppSupportPath(filename: String) -> String {
        return mergePath(AppSupportDir, b: filename)
    }
    
    static var OptionPath: String {
        return AppSupportPath("liteterm.plist")
    }
}
