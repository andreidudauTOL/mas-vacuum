//
//  ViewController.swift
//  mas-vacuum
//
//  Created by Andrei Dudau on 6/27/19.
//  Copyright © 2019 Andrei Dudau. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    let queue1 = DispatchQueue(label: "queue1", qos: .userInitiated)
    let queue2 = DispatchQueue(label: "queue2", qos: .userInitiated)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let room = Room()
        let vacuum1 = Vacuum()
        let vacuum2 = Vacuum()
        print("----- start ----- \n")
        print(room)
        startThread(queue: queue1, room: room, vacuum: vacuum1)
        startThread(queue: queue2, room: room, vacuum: vacuum2)
    }
    
    func startThread(queue: DispatchQueue, room: Room, vacuum: Vacuum) {
        queue.async {
            var routine = Routine()
            routine.room = room
            routine.vacuum = vacuum
            routine.label = self.label
            print("---- initialize Routine \(vacuum.id!)")
            routine.run(initialPosition: room.agentPositions[vacuum.id]!)
            
        }
    }


}

