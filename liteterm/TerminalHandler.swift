//
//  BaseTerminalHandler.swift
//  liteterm
//
//  Created by yjroot on 2015. 12. 30..
//  Copyright © 2015년 Liteterm Team. All rights reserved.
//

import Foundation

protocol TerminalHandler {
    func putData(data: Character) -> Bool
}