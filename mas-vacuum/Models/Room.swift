//
//  Room.swift
//  mas-vacuum
//
//  Created by Andrei Dudau on 6/27/19.
//  Copyright © 2019 Andrei Dudau. All rights reserved.
//

import Foundation

class Room {
    var agentDirections: [Int: Direction] = [0: .up, 0: .up]
    var agentPositions: [Int: Position] = [:]
    var floor: [[State]] = [
                    [.clean, .clean, .dirt, .clean],
                    [.clean, .dirt, .clean, .clean],
                    [.clean, .dirt, .dirt, .clean],
                    [.dirt, .clean, .clean, .clean]
                            ]
    
}
