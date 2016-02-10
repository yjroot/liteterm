//
//  TerminalFont.swift
//  liteterm
//
//  Created by yjroot on 2016. 1. 27..
//  Copyright © 2016년 Liteterm Team. All rights reserved.
//

import Cocoa

class TerminalFont {
    var font: CTFont
    let width: CGFloat = 10.0
    let height: CGFloat = 18.0
    
    init() {
        NSFontManager.sharedFontManager().availableFontFamilies
        font = NSFont.systemFontOfSize(15.0)
    }
    
    var glyphs: [CGGlyph] = []
    var positions: [CGPoint] = []
    var context: CGContextRef!
    var color: RGBColor!
    
    func drawChar(char: Character, position: CGPoint, color: RGBColor, context: CGContextRef) -> Bool {
        if self.context != nil && color != self.color {
            flush()
        }
        self.context = context
        self.color = color
        let charArray: Array<UniChar> = Array<UniChar>(String(char).utf16)
        let glyphArray: UnsafeMutablePointer<CGGlyph> = UnsafeMutablePointer<CGGlyph>.alloc(charArray.count)
        if !CTFontGetGlyphsForCharacters(self.font, charArray, glyphArray, charArray.count) {
            self.flush()
            return false
        }
        
        let glyph = glyphArray[0]
        glyphArray.dealloc(charArray.count)
        if glyph == 0 {
            self.flush()
            return false
        }
        glyphs.append(glyph)
        positions.append(position)
        return true
    }
    
    func flush() {
        if context == nil || color == nil || self.glyphs.count == 0{
            return
        }
        
        let glyphsArray: Array<CGGlyph> = Array<CGGlyph>(self.glyphs)
        var positionsArray: Array<CGPoint> = Array<CGPoint>(self.positions)
        let advancesArray: UnsafeMutablePointer<CGSize> = UnsafeMutablePointer<CGSize>.alloc(glyphsArray.count)
        
        CTFontGetAdvancesForGlyphs(self.font, CTFontOrientation.Default, glyphsArray, advancesArray, glyphsArray.count)
        for i in 0..<glyphsArray.count {
            positionsArray[i].x += (self.width - advancesArray[i].width) / 2
        }
        advancesArray.dealloc(glyphsArray.count)
        CGContextSetFillColorWithColor(context, color.CGColor);
        CTFontDrawGlyphs(self.font, glyphsArray, positionsArray, glyphs.count, context);
        
        reset()
    }
    
    func reset() {
        glyphs = []
        positions = []
        context = nil
        color = nil
    }
}

func ==(left: RGBColor, right: RGBColor) -> Bool {
    return left.red == right.red && left.green == right.green && left.blue == right.blue
}

func !=(left: RGBColor, right: RGBColor) -> Bool {
    return !(left == right)
}