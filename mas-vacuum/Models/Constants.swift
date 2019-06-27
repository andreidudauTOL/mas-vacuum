//
//  Constants.swift
//  mas-vacuum
//
//  Created by Andrei Dudau on 6/27/19.
//  Copyright © 2019 Andrei Dudau. All rights reserved.
//

import Foundation


struct Constants {
    static let roomSize = 4
    static let queueName = "concurrentQueue"
}

enum State: Int {
    case wall = -1, clean, dirt, otherAgent
}

enum Action {
    case move, clean, rotate
}

enum Direction: Int, CustomStringConvertible {
    case up = 0, right, down, left
    
    init(number: Int) {
        switch number {
        case 0: self = .up
        case 1: self = .right
        case 2: self = .down
        case 3: self = .left
        default: self = .up
        }
    }
    
    func getPosition() -> Position {
        switch self {
        case .up:
            return Position(0, -1)
        case .right:
            return Position(1, 0)
        case .down:
            return Position(0, 1)
        case .left:
            return Position(-1, 0)
        }
    }
    
    var description: String {
        switch self {
        case .up:
            return "⬆️"
        case .right:
            return "➡"
        case .down:
            return "⬇️"
        case .left:
            return "⬅"
        }
    }
}
