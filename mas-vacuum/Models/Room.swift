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
    
    private var _agentDirections: [Int: Direction] = [0: .down, 1: .left]
    var agentDirections: [Int: Direction] {
        var result: [Int: Direction] = [:]
        queue.sync {
            result = self._agentDirections
        }
        return result
    }
    
    private var _agentPositions: [Int: Position] = [0: Position(0, 0), 1: Position(3, 3)]
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
    
    // DIRECTION methods
    func updateDirection(vacuum: Vacuum, direction: Direction) {
        queue.async(flags: .barrier) {
            self._agentDirections[vacuum.id] = direction
        }
    }
    
    // POSITION methods
    
    func updatePosition(vacuum: Vacuum, position: Position) {
        queue.async(flags: .barrier) {
            self._agentPositions[vacuum.id] = position
        }
    }
    
    func getPosition(of vacuum: Vacuum) -> Position {
        return agentPositions[vacuum.id]!
    }
    
    func getNextPosition(of vacuum: Vacuum) -> Position {
        let currentPosition = getPosition(of: vacuum)
        let nextPosition = currentPosition + agentDirections[vacuum.id]!.getPosition()
        return nextPosition
    }
    
    // STATE methods
    func getState(at position: Position, for vacuum: Vacuum) -> State {
        if isWall(at: position) { return .wall }
        for (vacuumId, vacuumPosition) in agentPositions {
            if vacuumId != vacuum.id && vacuumPosition == position { return .otherAgent }
        }
        let currentTile = floor[position.y][position.x]
        if currentTile == .dirt { return .dirt }
        return .clean
    }
    
    func isWall(at position: Position) -> Bool {
        if position.x < 0 || position.x >= Constants.roomSize { return true }
        if position.y < 0 || position.y >= Constants.roomSize { return true }
        if floor[position.y][position.x] == .wall { return true }
        return false
    }
    
    // FLOOR methods
    
    func execute(_ action: Action, vacuum: Vacuum, nextPosition: Position) {
        print("Vacuum \(vacuum.id!) decided to do \(action)")
        switch action {
        case .move:
            updatePosition(vacuum: vacuum, position: nextPosition)
        case .clean:
            let currentPosition = agentPositions[vacuum.id]!
            updateFloor(at: currentPosition, with: .clean)
        case .rotate:
            let direction = agentDirections[vacuum.id]!
            let newDirection = Direction(number: (direction.rawValue % 4 + 1))
            updateDirection(vacuum: vacuum, direction: newDirection)
        }
    }
    
    func updateFloor(at position: Position, with state: State) {
        queue.async(flags: .barrier) {
            self._floor[position.y][position.x] = state
        }
    }
    
    func isClean() -> Bool {
        for i in 0..<floor.count {
            for j in 0..<floor[i].count {
                if floor[i][j] == .dirt {
                    return false
                }
            }
        }
        return true
    }
}

extension Room: CustomStringConvertible {
    var description: String {
        var string = ""
        for i in 0..<floor.count {
            for j in 0..<floor[i].count {
                string += getSimbol(at: Position(j, i))
            }
            string += "\n"
        }
        return string
    }
    
    private func getSimbol(at currentPosition: Position) -> String {
        for (id, position) in agentPositions {
            if position == currentPosition {
                return "\(agentDirections[id]!) "
            }
        }
        return "\(floor[currentPosition.y][currentPosition.x].rawValue) "
    }
}
