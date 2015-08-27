//
//  SessionProfile.swift
//  lightterm
//
//  Created by yjroot on 2015. 7. 24..
//  Copyright (c) 2015년 Netsarang. All rights reserved.
//

import Foundation

class SessionProfile {
    var error: Bool = false
    
    var xml: XMLIndexer? = nil
    var filepath: String? = nil
    var name: String? = nil
    
    init(filepath: String? = nil) {
        if filepath != nil {
            self.filepath = filepath
            self.name = filepath?.lastPathComponent.stringByDeletingPathExtension
            
            let data: NSData? = NSData(contentsOfFile:self.filepath!, options: nil, error: nil)
            if data == nil {
                self.error = false
                return
            }
            self.xml = SWXMLHash.lazy(data!)
        }
        
    }
    
    subscript(key : String) -> SessionProfileSelector {
        get {
            return SessionProfileSelector(profile: self, key: key)
        }
        set(newValue) {
            
        }
    }
}

class SessionProfileSelector {
    var profile: SessionProfile
    var list: [String]
    
    init(profile: SessionProfile, key: String) {
        self.profile = profile
        self.list = [key]
    }
    
    init(selector: SessionProfileSelector, key: String) {
        self.profile = selector.profile
        self.list = selector.list + [key]
    }
    
    subscript(key : String) -> SessionProfileSelector {
        get {
            return SessionProfileSelector(selector: self, key: key)
        }
        set(newValue) {
            
        }
    }
    
    var value: String {
        get {
            var xml: XMLIndexer = self.profile.xml!["lightterm"]
            for key in self.list {
                xml = xml[key]
            }
            if var element: XMLElement = xml.element {
                return element.text ?? ""
            }
            return ""
        }
        set(newValue) {
        }
    }
}