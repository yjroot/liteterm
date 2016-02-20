//
//  BaseTerminalFont.swift
//  liteterm
//
//  Created by yjroot on 2016. 2. 10..
//  Copyright © 2016년 Liteterm Team. All rights reserved.
//

import Foundation

protocol BaseTerminalFont {
    func drawChar(char: Character, position: CGPoint, width: Int, color: RGBColor, context: CGContextRef) -> Bool
    func flush()
    func reset()
}