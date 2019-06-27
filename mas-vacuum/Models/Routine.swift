//
//  Routine.swift
//  mas-vacuum
//
//  Created by Andrei Dudau on 6/27/19.
//  Copyright © 2019 Andrei Dudau. All rights reserved.
//

import Foundation
import UIKit

struct Routine {
    var room: Room!
    var vacuum: Vacuum!
    var queue: DispatchQueue!
    var label: UILabel?
    
    func run(initialPosition: Position) {
        room.updatePosition(vacuum: vacuum, position: initialPosition)
        print("---- running Routine \(vacuum.id!)")
        DispatchQueue.global(qos: .background).async {
            while (!self.room.isClean()) {
                usleep(100000)
                self.drawRoom()
                let currentPosition = self.room.getPosition(of: self.vacuum)
                let nextPosition = self.room.getNextPosition(of: self.vacuum)
                let currentTile = self.room.getState(at: currentPosition, for: self.vacuum)
                let nextTile = self.room.getState(at: nextPosition, for: self.vacuum)
                let action = Vacuum.computeAction(currentTile: currentTile, nextTile: nextTile)
                self.room.execute(action, vacuum: self.vacuum, nextPosition: nextPosition)
                print("----- next step")
            }
        }
        drawRoom()
        print("---- FINISHED")
    }
    
    func drawRoom() {
        print(room!)
        guard let label = label else {return}
        DispatchQueue.main.async {
            label.text = self.room.description
        }
    }
}
