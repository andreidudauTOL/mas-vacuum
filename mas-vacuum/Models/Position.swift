//
//  Position.swift
//  mas-vacuum
//
//  Created by Andrei Dudau on 6/27/19.
//  Copyright © 2019 Andrei Dudau. All rights reserved.
//

import Foundation

struct Position {
    var x = 0
    var y = 0
    
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}

extension Position: Equatable {
    static func == (lhs: Position, rhs: Position) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
    
    static func + (lhs: Position, rhs: Position) -> Position {
        let x = lhs.x + rhs.x
        let y = lhs.y + rhs.y
        return Position(x,y)
    }
}
