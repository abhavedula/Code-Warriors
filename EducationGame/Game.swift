//
//  Game.swift
//  Game app
//
//  Created by Abha Vedula on 7/11/16.
//  Copyright © 2016 Abha Vedula. All rights reserved.
//

import UIKit

class Game: NSObject {
    
    var name: String?
    var descr: String?
    var thumbnail: UIImage?
    var completed: Bool?
    var nameToShow: String?

    
    init(name: String) {
        self.name = name
        completed = false
    }
    
}
