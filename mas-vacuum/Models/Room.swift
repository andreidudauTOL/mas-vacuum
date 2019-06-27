//
//  Room.swift
//  mas-vacuum
//
//  Created by Andrei Dudau on 6/27/19.
//  Copyright © 2019 Andrei Dudau. All rights reserved.
//

import Foundation

class Room {
    private let queue = DispatchQueue(label: Constants.queueName, attributes: .concurrent)
    
    private var _agentDirections: [Int: Direction] = [:]
    var agentDirections: [Int: Direction] {
        var result: [Int: Direction] = [:]
        queue.sync {
            result = self._agentDirections
        }
        return result
    }
    
    private var _agentPositions: [Int: Position] = [:]
    var agentPositions: [Int: Position] {
        var result: [Int: Position] = [:]
        queue.sync {
            result = self._agentPositions
        }
        return result
    }
    
    private var _floor: [[State]] = [
        [.clean, .clean, .dirt, .clean],
        [.clean, .dirt, .clean, .clean],
        [.clean, .dirt, .dirt, .clean],
        [.dirt, .clean, .clean, .clean]
    ]
    var floor: [[State]] {
        var result: [[State]] = []
        queue.sync {
            result = self._floor
        }
        return result
    }
    
    func updatePosition(vacuum: Vacuum, position: Position) {
        queue.async(flags: .barrier) {
            self._agentPositions[vacuum.id] = position
        }
    }
    
    func updateFloor(at position: Position, with state: State) {
        queue.async(flags: .barrier) {
            self._floor[position.x][position.y] = state
        }
    }
}

extension Room: CustomStringConvertible {
    var description: String {
        var string = ""
        for i in 0..<floor.count {
            for j in 0..<floor[i].count {
                string += String(floor[i][j].rawValue) + " "
            }
            string += "\n"
        }
        return string
    }
}
