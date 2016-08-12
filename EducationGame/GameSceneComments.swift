/*
//  GameScene.swift
//  CarGame
//
//  Created by John Kriston on 7/7/16.
//  Copyright (c) 2016 John Kriston. All rights reserved.
//

import UIKit
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var pointer = 0
    var angle = 0
    var foregroundNode: SKNode!
    var hudNode: SKNode!
    var player: SKNode!
    // Tap To Start node
    let tapToStartNode = SKSpriteNode(imageNamed: "TapToStart")
    
    // To Accommodate iPhone 6
    var scaleFactor: CGFloat!
    
    var wall: SKNode!
    var rightArrow: SKNode!
    var upArrow: SKNode!
    var downArrow: SKNode!
    var one: SKNode!
    var two: SKNode!
    var three: SKNode!
    var four: SKNode!
    var five: SKNode!
    var six: SKNode!
    var seven: SKNode!
    var eight: SKNode!
    var nine: SKNode!
    var lblScore: SKLabelNode!
    var lblText: SKLabelNode!
    // Game over
    var gameOver = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        backgroundColor = SKColor.blackColor()
        //Foreground
        foregroundNode = SKNode()
        addChild(foregroundNode)
        // HUD
        hudNode = SKNode()
        addChild(hudNode)
        //Add the Player
        player = createPlayer()
        foregroundNode.addChild(player)
        // Tap to Start
        tapToStartNode.position = CGPoint(x: size.width / 2, y: 180)
        hudNode.addChild(tapToStartNode)
        //RightArrow
        rightArrow = createRightArrow()
        foregroundNode.addChild(rightArrow)
        //UpArrow
        upArrow = createUpArrow()
        foregroundNode.addChild(upArrow)
        //DownArrow
        downArrow = createDownArrow()
        foregroundNode.addChild(downArrow)
        // Add stars
        one = createDistanceAtPosition(.Three)
        one.position = CGPoint(x: size.width * 0.075, y: size.height * 0.65)
        foregroundNode.addChild(one)
        
        two = createDistanceAtPosition(.Three)
        two.position = CGPoint(x: size.width * 0.075, y: size.height * 0.20)
        foregroundNode.addChild(two)
        
        three = createDistanceAtPosition(.Five)
        three.position = CGPoint(x: size.width * 0.3, y: size.height * 0.775)
        foregroundNode.addChild(three)
        
        four = createDistanceAtPosition(.Four)
        four.position = CGPoint(x: size.width * 0.3, y: size.height * 0.55)
        foregroundNode.addChild(four)
        
        five = createDistanceAtPosition(.Three)
        five.position = CGPoint(x: size.width * 0.3, y: size.height * 0.325)
        foregroundNode.addChild(five)
        
        six = createDistanceAtPosition(.Three)
        six.position = CGPoint(x: size.width * 0.3, y: size.height * 0.125)
        foregroundNode.addChild(six)
        
        seven = createDistanceAtPosition(.Three)
        seven.position = CGPoint(x: size.width * 0.7, y: size.height * 0.67)
        foregroundNode.addChild(seven)
        
        eight = createDistanceAtPosition(.Three)
        eight.position = CGPoint(x: size.width * 0.7, y: size.height * 0.325)
        foregroundNode.addChild(eight)
        
        nine = createDistanceAtPosition(.Three)
        nine.position = CGPoint(x: size.width * 0.7, y: size.height * 0.125)
        foregroundNode.addChild(nine)
        
        
        
        //Set contact delegat
        physicsWorld.contactDelegate = self
        
        lblScore = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        lblScore.fontSize = 30
        lblScore.fontColor = SKColor.whiteColor()
        lblScore.position = CGPoint(x: size.width * 0.675, y: size.height * 0.9)
        lblScore.text = "0"
        hudNode.addChild(lblScore)
        
        lblText = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        lblText.fontSize = 30
        lblText.fontColor = SKColor.whiteColor()
        lblText.position = CGPoint(x: size.width * 0.45, y: size.height * 0.9)
        lblText.text = "Distance Traveled:"
        hudNode.addChild(lblText)
        
        GameState.sharedInstance.score = 0
        gameOver = false
        
        wall = createWallAtPosition()
        wall.position = CGPoint(x: 160, y: 170)
        foregroundNode.addChild(wall)
        
        
        /*
         var r = 0
         if let levelPath = NSBundle.mainBundle().pathForResource("Street", ofType: "txt") {
         
         let levelString: NSString?
         do {
         levelString = try NSString(contentsOfFile: levelPath, usedEncoding: nil)
         levelString!.enumerateLinesUsingBlock({ (line, stop) -> () in
         let arr = Array(line.characters)
         for (i, c) in arr.enumerate() {
         let position = CGPoint(x: (16 * i) + 10, y: (16 * r) + 5)
         if c == "x" {
         let wallNode = WallNode()
         let sprite = SKSpriteNode(imageNamed: "WhiteBlock.jpeg")
         sprite.position = position
         sprite.size = CGSizeMake(10, 10)
         
         
         sprite.physicsBody = SKPhysicsBody(rectangleOfSize: sprite.size)
         sprite.physicsBody?.dynamic = false
         
         sprite.physicsBody?.categoryBitMask = CollisionCategoryBitmask.wall
         sprite.physicsBody?.collisionBitMask = 0
         
         
         wallNode.addChild(sprite)
         self.foregroundNode.addChild(wallNode)
         
         }
         }
         r += 1
         })
         } catch _ {
         levelString = nil
         print("no")
         }
         
         }
         */
        
        
    }
    
    func createPlayer() -> SKNode {
        let playerNode = SKNode()
        playerNode.position = CGPoint(x: size.width * 0.01, y: size.height * 0.43)
        
        let sprite = SKSpriteNode(imageNamed: "RedCar")
        sprite.size = CGSizeMake( 50, 25)
        playerNode.addChild(sprite)
        
        // 1
        playerNode.physicsBody = SKPhysicsBody(rectangleOfSize: sprite.size)
        // 2
        playerNode.physicsBody?.dynamic = false
        // 3
        playerNode.physicsBody?.allowsRotation = true
        // 4
        playerNode.physicsBody?.restitution = 1.0
        playerNode.physicsBody?.friction = 0.0
        playerNode.physicsBody?.angularDamping = 0.0
        playerNode.physicsBody?.linearDamping = 0.0
        playerNode.physicsBody?.affectedByGravity = false
        
        // 1
        playerNode.physicsBody?.usesPreciseCollisionDetection = true
        // 2
        playerNode.physicsBody?.categoryBitMask = CollisionCategoryBitmask.player
        // 3
        playerNode.physicsBody?.collisionBitMask = 0
        // 4
        playerNode.physicsBody?.contactTestBitMask = CollisionCategoryBitmask.star | CollisionCategoryBitmask.wall
        return playerNode
    }
    
    override func update(currentTime: NSTimeInterval) {
        
        if gameOver {
            return
        }
        //Check to see if game is over
        if player.position.x > size.width - 15 {
            endGame()
        }
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // 1
        // If we're already playing, ignore touches
        if player.physicsBody!.dynamic {
            return
        }
        
        // 2
        // Remove the Tap to Start node
        tapToStartNode.removeFromParent()
        
        // 3
        // Start the player by putting them into the physics simulation
        player.physicsBody?.dynamic = true
    }
    
    
    
    
    
    func createRightArrow() -> SKNode{
        let rightNode = SKNode()
        rightNode.position = CGPoint(x: size.width * 0.9, y: size.height * 0.9)
        
        let sprite = SKSpriteNode(imageNamed: "RightArrow")
        sprite.size = CGSizeMake(20,25)
        rightNode.addChild(sprite)
        return rightNode
    }
    
    func createUpArrow() -> SKNode{
        let upNode = SKNode()
        upNode.position = CGPoint(x: size.width * 0.85, y: size.height * 0.95)
        
        let sprite = SKSpriteNode(imageNamed: "UpArrow")
        sprite.size = CGSizeMake(25,20)
        upNode.addChild(sprite)
        return upNode
    }
    
    func createDownArrow() -> SKNode{
        let downNode = SKNode()
        downNode.position = CGPoint(x: size.width * 0.85, y: size.height * 0.85)
        
        let sprite = SKSpriteNode(imageNamed: "DownnArrow")
        sprite.size = CGSizeMake(25,20)
        downNode.addChild(sprite)
        return downNode
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?){
        //get location of last touch
        //let loc = touches[touches.endIndex].locationInNode(self)
        //if go.containsPoint(loc)
        
        for touch: AnyObject in touches{
            //Get the location of the touch in this scene
            let location = touch.locationInNode(self)
            //Check if the location of the touch is withinthe button's bounds
            if downArrow.containsPoint(location){
                player.zRotation = CGFloat(-M_PI_2)
                pointer = 1
                player.position = CGPoint(x: player.position.x, y: player.position.y - 10)
                
            } else if upArrow.containsPoint(location){
                
                player.zRotation = CGFloat(M_PI_2)
                pointer = 2
                player.position = CGPoint(x: player.position.x, y: player.position.y + 10)
                
            }
            else if rightArrow.containsPoint(location){
                if pointer == 0{
                    player.position = CGPoint(x: player.position.x + 10, y: player.position.y)
                }
                if pointer == 1{
                    player.zRotation = CGFloat(0)
                    player.position = CGPoint(x: player.position.x + 10, y: player.position.y)
                    pointer = 0
                }
                if pointer == 2{
                    player.zRotation = CGFloat(0)
                    player.position = CGPoint(x: player.position.x + 10, y: player.position.y)
                    pointer = 0
                }
                
            }
        }
    }
    
    func createDistanceAtPosition(type: StarType) -> StarNode {
        // 1
        let node = StarNode()
        node.name = "NODE_STAR"
        
        // 2
        node.starType = type
        var sprite: SKSpriteNode
        if type == .Five {
            sprite = SKSpriteNode(imageNamed: "five")
        } else if type == .Four {
            sprite = SKSpriteNode(imageNamed: "four")
        }
        else if type == .Three{
            sprite = SKSpriteNode(imageNamed: "three")
        }
        else if type == .Two{
            sprite = SKSpriteNode(imageNamed: "two")
        }
        else {
            sprite = SKSpriteNode(imageNamed: "one")
        }
        sprite.size = CGSizeMake(25, 25)
        node.addChild(sprite)
        
        // 3
        node.physicsBody = SKPhysicsBody(rectangleOfSize: sprite.size)
        
        // 4
        node.physicsBody?.dynamic = false
        
        node.physicsBody?.categoryBitMask = CollisionCategoryBitmask.star
        node.physicsBody?.collisionBitMask = 0
        
        
        
        return node
    }
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        // 1
        var updateHUD = false
        
        // 2
        let whichNode = (contact.bodyA.node != player) ? contact.bodyA.node : contact.bodyB.node
        
        let other = whichNode as! GameObjectNode
        // 3
        updateHUD = other.collisionWithPlayer(player)
        
        
        
        // Update the HUD if necessary
        if updateHUD {
            // 4 TODO: Update HUD in Part 2
            lblScore.text = String(format: "%d", GameState.sharedInstance.score)
            
        }
        
    }
    
    func endGame() {
        // 1
        gameOver = true
        
        // 2
        // Save stars and high score
        GameState.sharedInstance.saveState()
        
        // 3
        let reveal = SKTransition.fadeWithDuration(0.5)
        let endGameScene = EndGameScene(size: self.size)
        self.view!.presentScene(endGameScene, transition: reveal)
    }
    
    func createWallAtPosition() -> WallNode{
        let node = WallNode()
        node.name = "NODE_WALL"
        
        var sprite: SKSpriteNode
        sprite = SKSpriteNode(imageNamed: "WhiteBlock.jpeg")
        sprite.size = CGSizeMake(20, 20)
        node.addChild(sprite)
        
        node.physicsBody = SKPhysicsBody(rectangleOfSize: sprite.size)
        node.physicsBody?.dynamic = false
        node.physicsBody?.categoryBitMask = CollisionCategoryBitmask.wall
        node.physicsBody?.collisionBitMask = 0
        
        return node
    }
    
    
    
    
    
    
    
    
    
}
*/
