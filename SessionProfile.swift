//
//  SessionProfile.swift
//  lightterm
//
//  Created by yjroot on 2015. 7. 24..
//  Copyright (c) 2015년 Netsarang. All rights reserved.
//

import Foundation

class SessionProfile {
    var parent: BaseProfile = DefaultProfile()
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
    
    func save() -> Bool {
        if var path: String = self.filepath {
            "\(self)".writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding)
            return true
        }
        return false
    }
}

extension SessionProfile: BaseProfile {
    subscript(key : String) -> ProfileSelector {
        get {
            return ProfileSelector(profile: self, key: key)
        }
    }
    
    func getValue(keys: [String]) -> String {
        var xml: XMLIndexer = self.root
        for key in keys {
            xml = xml[key]
        }
        if var element: XMLElement = xml.element {
            return element.text ?? ""
        }
        return self.parent.getValue(keys) ?? ""
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
    
    var description: String {
        return self.xml!.description
    }
}