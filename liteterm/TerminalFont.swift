//
//  TerminalFont.swift
//  liteterm
//
//  Created by yjroot on 2016. 1. 27..
//  Copyright © 2016년 Liteterm Team. All rights reserved.
//

import Cocoa

class TerminalFont: BaseTerminalFont {
    var font: NSFont
    var width: CGFloat = 10.0
    var height: CGFloat = 18.0
    
    init() {
        NSFontManager.sharedFontManager().availableFontFamilies
        font = NSFont(name: "나눔고딕", size: 18)!
        height = font.ascender - font.descender
        width = height * 0.6
    }
    
    var glyphs: [CGGlyph] = []
    var positions: [CGPoint] = []
    var widths: [Int] = []
    var context: CGContextRef!
    var color: RGBColor!
    
    func drawChar(char: Character, position: CGPoint, width: Int, color: RGBColor, context: CGContextRef) -> Bool {
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
        widths.append(width)
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
            positionsArray[i].x += ((self.width * CGFloat(widths[i])) - advancesArray[i].width) / 2
            positionsArray[i].y -= self.font.descender
        }
        advancesArray.dealloc(glyphsArray.count)
        CGContextSetFillColorWithColor(context, color.CGColor);
        CTFontDrawGlyphs(self.font, glyphsArray, positionsArray, glyphs.count, context);
        
        reset()
    }
    
    func reset() {
        glyphs = []
        positions = []
        widths = []
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