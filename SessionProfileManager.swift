//
//  SessionProfileManager.swift
//  lightterm
//
//  Created by yjroot on 2015. 7. 24..
//  Copyright (c) 2015년 Netsarang. All rights reserved.
//

import Foundation

class SessionProfileManager {
    let profileDirPath: String
    
    init(profileDirPath: String? = nil) {
        if (profileDirPath == nil) {
            let documentsPath : AnyObject = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask,true)[0]
            self.profileDirPath = documentsPath.stringByAppendingString("/lightterm")
        } else {
            self.profileDirPath = profileDirPath!
        }
    }
    
    var profiles: [String] {
        get {
            var profiles = [String]()
            let fileManager = NSFileManager.defaultManager()
            let files = fileManager.contentsOfDirectoryAtPath(self.profileDirPath, error: nil) ?? []
            let litFiles = files.filter({(file: AnyObject)-> Bool in
                return (file as? NSString)?.pathExtension == "lit"
            })
            
            for filename in litFiles {
                profiles.append((filename as! String).stringByDeletingPathExtension)
            }
            return profiles;
        }
    }
    
    subscript(name : String) -> SessionProfile? {
        get {
            let profilePath = self.profileDirPath.stringByAppendingPathComponent(name.stringByAppendingPathExtension("lit")!)
            let fileManager = NSFileManager.defaultManager()

            if (!fileManager.fileExistsAtPath(profilePath)) {
                return nil;
            }
            return SessionProfile(filepath: profilePath)
        }
        set(profile) {
            let profilePath = self.profileDirPath.stringByAppendingPathComponent(name.stringByAppendingPathExtension("lit")!)
            profile?.filepath = profilePath
            profile?.save()
        }
    }
}