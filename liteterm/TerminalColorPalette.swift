//
//  TerminalColorPalette.swift
//  liteterm
//
//  Created by yjroot on 2015. 11. 27..
//  Copyright © 2015년 Liteterm Team. All rights reserved.
//

import Foundation

struct TerminalColorPalette {
    var palette: Array<RGBColor> = Array<RGBColor>()
    
    init() {
        palette.reserveCapacity(256)
        for i in 0..<16 {
            var r: UInt16 = 0
            var g: UInt16 = 0
            var b: UInt16 = 0
            
            if i & 0x08 != 0 {
                r = UInt16.max / 2
                g = UInt16.max / 2
                b = UInt16.max / 2
            }
            if i & 0x01 != 0 {
                r = UInt16.max
            }
            if i & 0x02 != 0 {
                g = UInt16.max
            }
            if i & 0x04 != 0 {
                b = UInt16.max
            }
            palette.append(RGBColor(red: r, green: g, blue: b))
        }
        
        for i in 0..<(6*6*6) {
            let r: UInt16 = UInt16(Int(UInt16.max) * ((i / 36) + 1) / 8)
            let g: UInt16 = UInt16(Int(UInt16.max) * (((i / 6) % 6) + 1) / 8)
            let b: UInt16 = UInt16(Int(UInt16.max) * ((i % 6) + 1) / 8)
            palette.append(RGBColor(red: r, green: g, blue: b))
        }
        
        for i in 0..<24 {
            let gray: UInt16 = UInt16(Int(UInt16.max) * (i + 1) / 25)
            palette.append(RGBColor(red: gray, green: gray, blue: gray))
        }
        
    }
    
    subscript(key : Int) -> RGBColor {
        get {
            return self.palette[key]
        }
    }
    
    subscript(key : UInt8) -> RGBColor {
        get {
            return self[Int(key)]
        }
    }
}