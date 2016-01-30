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
    func addChar(char: Character, position: CGPoint) -> Bool {
        let charArray: Array<UniChar> = Array<UniChar>(String(char).utf16)
        let glyphArray: UnsafeMutablePointer<CGGlyph> = UnsafeMutablePointer<CGGlyph>.alloc(charArray.count)
        if !CTFontGetGlyphsForCharacters(self.font, charArray, glyphArray, charArray.count) {
            return false
        }
        
        let glyph = glyphArray[0]
        glyphArray.dealloc(charArray.count)
        if glyph == 0 {
            return false
        }
        glyphs.append(glyph)
        positions.append(position)
        return true
    }
    
    func draw(context: CGContext, color: CGColor) {
        let glyphsArray: Array<CGGlyph> = Array<CGGlyph>(self.glyphs)
        var positionsArray: Array<CGPoint> = Array<CGPoint>(self.positions)
        let advancesArray: UnsafeMutablePointer<CGSize> = UnsafeMutablePointer<CGSize>.alloc(glyphsArray.count)
        
        CTFontGetAdvancesForGlyphs(self.font, CTFontOrientation.Default, glyphsArray, advancesArray, glyphsArray.count)
        for i in 0..<glyphsArray.count {
            positionsArray[i].x += (self.width - advancesArray[i].width) / 2
        }
        advancesArray.dealloc(glyphsArray.count)
        CGContextSetFillColorWithColor(context, color);
        CTFontDrawGlyphs(self.font, glyphsArray, positionsArray, glyphs.count, context);
        
        glyphs = []
        positions = []
    }
}