//
//  SessionProfile.swift
//  liteterm
//
//  Created by yjroot on 2015. 7. 24..
//  Copyright (c) 2015년 Liteterm team. All rights reserved.
//

import Foundation

enum ProfileError: ErrorType {
    case UnkonwnVersion
}

class SessionProfile {
    var parent: BaseProfile = OptionProfile.sharedInstance
    var error: Bool = false
    var filepath: NSURL? = nil
    
    private var xml: XMLIndexer? = nil
    var root: XMLIndexer {
        if self.xml != nil {
            return self.xml!["liteterm"]
        }
        
        if let data: NSData = NSData(contentsOfURL: self.filepath!) {
            // TODO: Because parse mothod will be slow with large file, it needs
            //       to change to lazy mothod. But, lazy parse does not support
            //       description yet.
            let xml = SWXMLHash.parse(data)
            if xml["liteterm"].element?.attributes["version"] == "0.01" {
                self.xml = xml
            }
        }
        
        if self.xml == nil {
            let root = XMLElement(name: rootElementName)
            root.addElement("liteterm", withAttributes: ["version":"0.01"])
            self.xml = XMLIndexer(root)
        }
        
        return self.xml!["liteterm"]
    }
    
    var name: String {
        return self.filepath?.URLByDeletingPathExtension?.lastPathComponent ?? ""
    }
    
    init(filepath: NSURL) {
        self.filepath = filepath
    }
    
    func save() -> Bool {
        if let path: NSURL = self.filepath {
            do {
                try "\(self)".writeToURL(path, atomically: true, encoding: NSUTF8StringEncoding)
            } catch _ {
            }
            return true
        }
        return false
    }
}

extension SessionProfile: BaseProfile {
    subscript(key : String) -> ProfileSelector {
        get {
            return ProfileSelector(profile: self, keyList: [key])
        }
    }
    
    func getValue(keys: [String]) -> String? {
        var xml: XMLIndexer = self.root
        for key in keys {
            xml = xml[key]
        }
        if let element: XMLElement = xml.element {
            return element.text ?? ""
        }
        return nil
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
