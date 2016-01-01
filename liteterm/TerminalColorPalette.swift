//
//  TerminalColorPalette.swift
//  liteterm
//
//  Created by yjroot on 2015. 11. 27..
//  Copyright © 2015년 Liteterm Team. All rights reserved.
//

import Foundation

struct TerminalColorPalette {
    var palette: [RGBColor]
    subscript(key : Int) -> RGBColor {
        get {
            return self.palette[key]
        }
    }
}