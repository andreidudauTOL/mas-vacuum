//
//  Vacuum.swift
//  mas-vacuum
//
//  Created by Andrei Dudau on 6/27/19.
//  Copyright © 2019 Andrei Dudau. All rights reserved.
//

import Foundation

struct Vacuum {
    static var objectCount = 0
    
    var id: Int!
    var currentTile: State!
    var nextTile: State!
    var currentDirection: Direction!
    
    init() {
        id = Vacuum.objectCount
        Vacuum.objectCount += 1
    }
    
    mutating func setCurrentTile(state: State) {
        currentTile = state
    }
    
    mutating func setNextTile(state: State) {
        nextTile = state
    }
    
    func computeAction() -> Action? {
        if currentTile == .dirt { return .clean }
        if nextTile == .wall || nextTile == .otherAgent { return .rotate }
        
        if Bool.random() { // if vacuum only goes straight and turns only at obstacles it will just circle the room
            return .move
        } else {
            return .rotate
        }
    }
    
}
