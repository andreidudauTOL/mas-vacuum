//
//  Room.swift
//  mas-vacuum
//
//  Created by Andrei Dudau on 6/27/19.
//  Copyright © 2019 Andrei Dudau. All rights reserved.
//

import Foundation

class Room {
    var agents: [Vacuum] = []
    var agentPositions: [Position] = []
    var floor: [[State]] = [
                    [.clean, .clean, .dirt, .clean],
                    [.clean, .dirt, .clean, .clean],
                    [.clean, .dirt, .dirt, .clean],
                    [.dirt, .clean, .clean, .clean]
                            ]
    
}
