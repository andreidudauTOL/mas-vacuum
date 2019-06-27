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

enum Direction {
    case up, right, down, bottom
    
    func getPosition() -> Position {
        switch self {
        case .up:
            return Position(0, -1)
        case .right:
            return Position(1, 0)
        case .down:
            return Position(0, 1)
        case .bottom:
            return Position(-1, 0)
        }
    }
}
