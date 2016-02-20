//
//  TerminalFontList.swift
//  liteterm
//
//  Created by yjroot on 2016. 2. 10..
//  Copyright © 2016년 Liteterm Team. All rights reserved.
//

import Foundation

class TerminalFontList: BaseTerminalFont {
    var fonts: [BaseTerminalFont] = []
    var lastFont: BaseTerminalFont!
    func drawChar(char: Character, position: CGPoint, width: Int, color: RGBColor, context: CGContextRef) -> Bool {
        for font in fonts {
            let result = font.drawChar(char, position: position, width:width, color: color, context: context)
            if result {
                lastFont.flush()
                lastFont = font
                return true
            }
        }
        
        return false
    }
    
    func flush() {
        if lastFont != nil {
            lastFont.flush()
            lastFont = nil
        }
    }
    
    func reset() {
        if lastFont != nil {
            lastFont.reset()
            lastFont = nil
        }
    }
}
