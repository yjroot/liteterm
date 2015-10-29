//
//  SessionProfileManager.swift
//  liteterm
//
//  Created by yjroot on 2015. 7. 24..
//  Copyright (c) 2015년 Liteterm team. All rights reserved.
//

import Foundation

class SessionProfileManager {
    let profileDirPath: NSString
    
    init(profileDirPath: String? = nil) {
        if (profileDirPath == nil) {
            let documentsPath : String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask,true)[0]
            self.profileDirPath = (documentsPath as NSString).stringByAppendingPathComponent("/liteterm")
        } else {
            self.profileDirPath = profileDirPath!
        }
    }
    
    var profiles: [String] {
        get {
            var profiles = [String]()
            let fileManager = NSFileManager.defaultManager()
            let files: [String]
            do {
                files = try fileManager.contentsOfDirectoryAtPath(self.profileDirPath as String)
            } catch _ {
                files = []
            }
            
            let litFiles = files.filter({(file: String)-> Bool in
                return (file as NSString).pathExtension == "lit"
            })
            
            for filename in litFiles {
                profiles.append((filename as NSString).stringByDeletingPathExtension)
            }
            return profiles;
        }
    }
    
    subscript(name : String) -> SessionProfile? {
        get {
            let profilePath = self.profileDirPath.stringByAppendingPathComponent((name as NSString).stringByAppendingPathExtension("lit")!)
            let fileManager = NSFileManager.defaultManager()

            if (!fileManager.fileExistsAtPath(profilePath)) {
                return nil;
            }
            
            return SessionProfile(filepath: NSURL(fileURLWithPath: profilePath))
        }
        set (profile) {
            let profilePath = self.profileDirPath.stringByAppendingPathComponent((name as NSString).stringByAppendingPathExtension("lit")!)
            profile?.filepath = NSURL(fileURLWithPath: profilePath)
            profile?.save()
        }
    }
}
