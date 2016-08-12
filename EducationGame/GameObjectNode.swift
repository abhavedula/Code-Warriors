//
//  GameObjectNode.swift
//  CarGame
//
//  Created by John Kriston on 7/7/16.
//  Copyright © 2016 John Kriston. All rights reserved.
//

import SpriteKit

enum StarType: Int{
    case One
    case Two
    case Three
    case Four
    case Five
}

enum WallType: Int {
    case Normal
}


struct CollisionCategoryBitmask {
    static let player: UInt32 = 0x00
    static let star: UInt32 = 0x01
    static let wall: UInt32 = 0x02
}

class GameObjectNode: SKNode {
    func collisionWithPlayer(player: SKNode) -> Bool {
        return false
    }
    
    func checkNodeRemoval(playerY: CGFloat) {
        if playerY > self.position.x || playerY > self.position.y {
            self.removeFromParent()
        }
    }
    
    
}

class StarNode: GameObjectNode {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    let starSound = SKAction.playSoundFileNamed("StarPing1.wav", waitForCompletion: false)
    
    static func score() -> Int {
        let score = NSUserDefaults.standardUserDefaults().integerForKey("distance")
        NSUserDefaults.standardUserDefaults().setInteger(score, forKey: "finalDistance")
        NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "distance")
        NSUserDefaults.standardUserDefaults().synchronize()
        return score

    }
    
    var starType: StarType!
    override func collisionWithPlayer(player: SKNode) -> Bool {
        
        // Play sound
        runAction(starSound, completion: {
            // Remove this Star
            self.removeFromParent()
        })
        
        // Award score
        if starType == .One{
            GameState.sharedInstance.score += 1
            print("score is now: \(GameState.sharedInstance.score )")
            let score = defaults.integerForKey("distance") + 1
            defaults.setInteger(score, forKey: "distance")
            defaults.synchronize()
        }
        else if starType == .Two{
            GameState.sharedInstance.score += 2
            print("score is now: \(GameState.sharedInstance.score )")
            let score = defaults.integerForKey("distance") + 2
            defaults.setInteger(score, forKey: "distance")
            defaults.synchronize()
        }
        else if starType == .Three{
            GameState.sharedInstance.score += 3
            print("score is now: \(GameState.sharedInstance.score )")
            let score = defaults.integerForKey("distance") + 3
            defaults.setInteger(score, forKey: "distance")
            defaults.synchronize()
        }
        else if starType == .Four{
            GameState.sharedInstance.score += 4
            print("score is now: \(GameState.sharedInstance.score )")
            let score = defaults.integerForKey("distance") + 4
            defaults.setInteger(score, forKey: "distance")
            defaults.synchronize()
        }
        else{
            GameState.sharedInstance.score += 5
            print("score is now: \(GameState.sharedInstance.score )")
            let score = defaults.integerForKey("distance") + 5
            defaults.setInteger(score, forKey: "distance")
            defaults.synchronize()
        }
        
        
        
        // The HUD needs updating to show the new stars and score
        return true
    }
}

class WallNode: GameObjectNode {
    var wallType: WallType!
    
    override func collisionWithPlayer(player: SKNode) -> Bool {
        return false
    }
}
