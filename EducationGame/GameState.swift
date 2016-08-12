//
//  GameState.swift
//  Graph
//
//  Created by John Kriston on 7/7/16.
//  Copyright © 2016 John Kriston. All rights reserved.
//

import Foundation

class GameState {
    var score: Int
    var bestScore: Int
    var timeOut: Int = 0
    var carType: Int = 0
    var level: Int = 0
    
    init() {
        // Init
        score = 0
        bestScore = 50
        
        
        // Load game state
        let defaults = NSUserDefaults.standardUserDefaults()
        
        bestScore = defaults.integerForKey("bestScore")
        
    }
    
    class var sharedInstance: GameState {
        struct Singleton {
            static let instance = GameState()
        }
        
        return Singleton.instance
    }
    
    func saveState() {
        // Update bestScore if the current score is less than
        bestScore = min(score, bestScore)
        
        // Store in user defaults
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(bestScore, forKey: "bestScore")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}