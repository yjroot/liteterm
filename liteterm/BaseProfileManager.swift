//
//  BaseProfileManager.swift
//  liteterm
//
//  Created by yjroot on 2015. 10. 24..
//  Copyright © 2015년 Liteterm Team. All rights reserved.
//

import Foundation

protocol BaseProfileManager {
    var name: String { get }
    // TODO:
    // var icon: NSImage
    
    var profiles: [String] { get }
    subscript(name : String) -> SessionProfile? { get set }
}