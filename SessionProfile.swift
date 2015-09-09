//
//  SessionProfile.swift
//  lightterm
//
//  Created by yjroot on 2015. 7. 24..
//  Copyright (c) 2015년 Netsarang. All rights reserved.
//

import Foundation

class SessionProfile {
    var parent: SessionProfile? = nil
    var error: Bool = false
    var filepath: String? = nil
    
    private var xml: XMLIndexer? = nil
    var root: XMLIndexer {
        if self.xml != nil {
            return self.xml!["lightterm"]
        }
        
        if let data: NSData = NSData(contentsOfFile:self.filepath!, options: nil, error: nil) {
            // TODO: Because parse mothod will be slow with large file, it needs
            //       to change to lazy mothod. But, lazy parse does not support
            //       description yet.
            var xml = SWXMLHash.parse(data)
            if xml["lightterm"].element?.attributes["version"] == "0.01" {
                self.xml = xml
            }
        }
        
        if self.xml == nil {
            var root = XMLElement(name: rootElementName)
            root.addElement("lightterm", withAttributes: ["version":"0.01"])
            self.xml = XMLIndexer(root)
        }
        
        return self.xml!["lightterm"]
    }
    
    var name: String {
        return self.filepath?.lastPathComponent.stringByDeletingPathExtension ?? ""
    }
    
    init(filepath: String? = nil) {
        self.filepath = filepath
    }
    
    subscript(key : String) -> SessionProfileSelector {
        get {
            return SessionProfileSelector(profile: self, key: key)
        }
        set(newValue) {
            
        }
    }
    
    func save() -> Bool {
        if var path: String = self.filepath {
            "\(self)".writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding)
            return true
        }
        return false
    }
    
    func getValue(keys: [String]) -> String {
        var xml: XMLIndexer = self.root
        for key in keys {
            xml = xml[key]
        }
        if var element: XMLElement = xml.element {
            return element.text ?? ""
        }
        return self.parent?.getValue(keys) ?? ""
    }
    
    func setValue(keys: [String], value: String)  {
        var xml: XMLIndexer = self.root
        for key in keys {
            if xml[key].boolValue {
                xml = xml[key]
            } else {
                xml.element?.addElement(key, withAttributes: [:])
                xml = xml[key]
            }
        }
        xml.element?.text = value
    }
}

extension SessionProfile: Printable {
    var description: String {
        return self.xml!.description
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
            return self.profile.getValue(self.list)
        }
        set(newValue) {
            self.profile.setValue(self.list, value: newValue)
        }
    }
}