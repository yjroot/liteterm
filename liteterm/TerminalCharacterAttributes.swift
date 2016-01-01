//
//  TerminalCharacterAttributes.swift
//  liteterm
//
//  Created by yjroot on 2015. 11. 8..
//  Copyright © 2015년 Liteterm Team. All rights reserved.
//

import Foundation

struct TerminalCharacterAttributes {
    var textColor: Int8 = 0
    var backgroundColor: Int8 = 0
    
    var style: Int8 = 0
    
    let boldBit = Int8(1 << 0)        // 1
    let underlineBit = Int8(1 << 1)   // 4
    let blinkBit = Int8(1 << 2)       // 5
    let reverseBit = Int8(1 << 3)     // 7
    let invisBit = Int8(1 << 4)       // 8
    let wideBit = Int8(1 << 5)
    
    var bold: Bool {
        get {
            return (self.style & boldBit) != 0
        }
        set (value) {
            if value {
                self.style |= boldBit
            } else {
                self.style &= ~(boldBit)
            }
        }
    }
    
    var underline: Bool {
        get {
            return (self.style & underlineBit) != 0
        }
        set (value) {
            if value {
                self.style |= underlineBit
            } else {
                self.style &= ~(underlineBit)
            }
        }
    }
    
    var blink: Bool {
        get {
            return (self.style & blinkBit) != 0
        }
        set (value) {
            if value {
                self.style |= blinkBit
            } else {
                self.style &= ~(blinkBit)
            }
        }
    }
    
    var reverse: Bool {
        get {
            return (self.style & reverseBit) != 0
        }
        set (value) {
            if value {
                self.style |= reverseBit
            } else {
                self.style &= ~(reverseBit)
            }
        }
    }
    
    var invis: Bool {
        get {
            return (self.style & boldBit) != 0
        }
        set (value) {
            if value {
                self.style |= invisBit
            } else {
                self.style &= ~(invisBit)
            }
        }
    }
    
    var wide: Bool {
        get {
            return (self.style & wideBit) != 0
        }
        set (value) {
            if value {
                self.style |= wideBit
            } else {
                self.style &= ~(wideBit)
            }
        }
    }
}