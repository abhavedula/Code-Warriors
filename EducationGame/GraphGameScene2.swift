//
//  GameScene.swift
//  CarGame
//
//  Created by John Kriston on 7/7/16.
//  Copyright (c) 2016 John Kriston. All rights reserved.
//

import UIKit
import SpriteKit

class GraphGameScene2: SKScene, SKPhysicsContactDelegate {
    
    var viewController: GraphViewController!
    
    
    var width: CGFloat!
    var height: CGFloat!
    
    var pointer = 0
    var rightpointer = 0
    var downpointer = 0
    var uppointer = 0
    var angle = 0
    var foregroundNode: SKNode!
    var hudNode: SKNode!
    var player: SKNode!
    // Tap To Start node
    let tapToStartNode = SKSpriteNode(imageNamed: "TapToStart")
    
    // To Accommodate iPhone 6
    var scaleFactor: CGFloat!
    
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
    var ten: SKNode!
    var eleven: SKNode!
    var twelve: SKNode!
    var thirteen: SKNode!
    var fourteen: SKNode!
    var fifteen: SKNode!
    var sixteen: SKNode!
    var seventeen: SKNode!
    var eighteen: SKNode!
    var nineteen: SKNode!
    var twenty: SKNode!
    var lblScore: SKLabelNode!
    var lblText: SKLabelNode!
    var timerLabel: SKLabelNode!
    // Game over
    var gameOver = false
    var timeSecond = 60
    var timer: SKLabelNode!
    var go: SKNode!
    var reset: SKNode!
    var box: SKShapeNode!
    var stop : SKNode!
      var redLines = SKSpriteNode(imageNamed: "redLines3")
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(size: CGSize, viewController: GraphViewController) {
        super.init(size: size)
        self.viewController = viewController
        
        width = size.width
        height = size.height
        
        
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
        tapToStartNode.position = CGPoint(x: width / 2, y: 180)
        tapToStartNode.zPosition = 5
        hudNode.addChild(tapToStartNode)
        
        //backgroundLines
        redLines.size = CGSizeMake(size.width, size.height)
        redLines.position = CGPoint(x: size.width/2, y: size.height/2)
        redLines.zPosition = 1
        addChild(redLines)
        
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
        one.position = CGPoint(x: width * 0.05, y: height * 0.65)
        foregroundNode.addChild(one)
        
        two = createDistanceAtPosition(.One)
        two.position = CGPoint(x: width * 0.11, y: height * 0.23)
        foregroundNode.addChild(two)
        
        three = createDistanceAtPosition(.One)
        three.position = CGPoint(x: width * 0.11, y: height * 0.065)
        foregroundNode.addChild(three)
        
        four = createDistanceAtPosition(.Two)
        four.position = CGPoint(x: width * 0.163, y: height * 0.4)
        foregroundNode.addChild(four)
        
        five = createDistanceAtPosition(.One)
        five.position = CGPoint(x: width * 0.2, y: height * 0.6)
        foregroundNode.addChild(five)
        
        six = createDistanceAtPosition(.One)
        six.position = CGPoint(x: width * 0.2, y: height * 0.75)
        foregroundNode.addChild(six)
        
        seven = createDistanceAtPosition(.Three)
        seven.position = CGPoint(x: width * 0.25, y: height * 0.35)
        foregroundNode.addChild(seven)
        
        eight = createDistanceAtPosition(.Four)
        eight.position = CGPoint(x: width * 0.35, y: height * 0.62)
        foregroundNode.addChild(eight)
        
        nine = createDistanceAtPosition(.Two)
        nine.position = CGPoint(x: width * 0.4, y: height * 0.75)
        foregroundNode.addChild(nine)
        
        ten = createDistanceAtPosition(.Two)
        ten.position = CGPoint(x: width * 0.45, y: height * 0.3)
        foregroundNode.addChild(ten)
        
        eleven = createDistanceAtPosition(.Two)
        eleven.position = CGPoint(x: width * 0.4, y: height * 0.065)
        foregroundNode.addChild(eleven)
        
        twelve = createDistanceAtPosition(.Two)
        twelve.position = CGPoint(x: width * 0.4, y: height * 0.42)
        foregroundNode.addChild(twelve)
        
        thirteen = createDistanceAtPosition(.One)
        thirteen.position = CGPoint(x: width * 0.69, y: height * 0.065)
        foregroundNode.addChild(thirteen)
        
        fourteen = createDistanceAtPosition(.One)
        fourteen.position = CGPoint(x: width * 0.69, y: height * 0.425)
        foregroundNode.addChild(fourteen)
        
        fifteen = createDistanceAtPosition(.Two)
        fifteen.position = CGPoint(x: width * 0.775, y: height * 0.75)
        foregroundNode.addChild(fifteen)
        
        sixteen = createDistanceAtPosition(.One)
        sixteen.position = CGPoint(x: width * 0.775, y: height * 0.425)
        foregroundNode.addChild(sixteen)
        
        seventeen = createDistanceAtPosition(.Five)
        seventeen.position = CGPoint(x: width * 0.915, y: height * 0.3)
        foregroundNode.addChild(seventeen)
        
        eighteen = createDistanceAtPosition(.One)
        eighteen.position = CGPoint(x: width * 0.891, y: height * 0.71)
        foregroundNode.addChild(eighteen)
        
        nineteen = createDistanceAtPosition(.Four)
        nineteen.position = CGPoint(x: width * 0.55, y: height * 0.3)
        foregroundNode.addChild(nineteen)
        
        twenty = createDistanceAtPosition(.One)
        twenty.position = CGPoint(x: width * 0.58, y: height * 0.75)
        foregroundNode.addChild(twenty)
        
        
        
        
        
        
        
        
        
        timerLabel = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        timerLabel.fontSize = 30
        timerLabel.fontColor = SKColor.whiteColor()
        timerLabel.position = CGPoint(x: width * 0.7, y: height * 0.875)
        timerLabel.text = "Time: "
        foregroundNode.addChild(timerLabel)
        
        timer = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        timer = SKLabelNode(text: "60")
        timer.fontSize = 30
        timer.fontColor = SKColor.greenColor()
        timer.position = CGPoint(x: width * 0.8, y: height * 0.875)
        foregroundNode.addChild(timer)
        
        
        
        
        
        
        //Set contact delegate
        physicsWorld.contactDelegate = self
        
        lblScore = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        lblScore.fontSize = 30
        lblScore.fontColor = SKColor.whiteColor()
        lblScore.position = CGPoint(x: width * 0.575, y: height * 0.875)
        lblScore.text = "0"
        hudNode.addChild(lblScore)
        
        lblText = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        lblText.fontSize = 30
        lblText.fontColor = SKColor.whiteColor()
        lblText.position = CGPoint(x: width * 0.35, y: height * 0.875)
        lblText.text = "Distance Traveled:"
        hudNode.addChild(lblText)
        
        //Create wall
        
        var r = 0
        if let levelPath = NSBundle.mainBundle().pathForResource("Street2", ofType: "txt") {
            
            let levelString: NSString?
            do {
                levelString = try NSString(contentsOfFile: levelPath, usedEncoding: nil)
                levelString!.enumerateLinesUsingBlock({ (line, stop) -> () in
                    let arr = Array(line.characters)
                    for (i, c) in arr.enumerate() {
                        let position = CGPoint(x: (16 * i) + 10, y: (16 * r) + 5)
                        if c == "x" {
                            let wall = self.createWall(.Normal)
                            wall.position = position
                            self.foregroundNode.addChild(wall)
                        }
                    }
                    r += 1
                })
            } catch _ {
                levelString = nil
                print("no")
            }
            
        }
        
        
        
        GameState.sharedInstance.score = 0
        gameOver = false
        
        
        
    }
    
    
    func timeAction() {
        
        let actionWait = SKAction.waitForDuration(1)
        
        let actionRun = SKAction.runBlock({
            self.timeSecond -= 1
            if self.timeSecond == 0{
                GameState.sharedInstance.timeOut = 1
                self.endGame()
            }
            self.timer.text = "\(self.timeSecond)"
            if self.timeSecond < 16 {
                self.timer.fontColor = SKColor.yellowColor()
            }
            if self.timeSecond < 6 {
                self.timer.fontColor = SKColor.redColor()
            }
            
        })
        timer.runAction(SKAction.repeatActionForever(SKAction.sequence([actionWait, actionRun])), withKey: "timer")
    }
    
    
    func createPlayer() -> SKNode {
        let playerNode = SKNode()
        playerNode.position = CGPoint(x: width * 0.01, y: height * 0.75)
        var sprite = SKSpriteNode(imageNamed: "RedCar")
        let carType = GameState.sharedInstance.carType
        if carType == 1{
            sprite = SKSpriteNode(imageNamed: "RedCar")
        }
        if carType == 2{
            sprite = SKSpriteNode(imageNamed: "BlueCar")
        }
        if carType == 3{
            sprite = SKSpriteNode(imageNamed: "GreenCar")
        }
        if carType == 4{
            sprite = SKSpriteNode(imageNamed: "OrangeCar")
        }
        if carType == 5{
            sprite = SKSpriteNode(imageNamed: "YellowCar")
        }
        if carType == 6{
            sprite = SKSpriteNode(imageNamed: "LightBlueCar")
        }
        if carType == 7{
            sprite = SKSpriteNode(imageNamed: "PinkCar")
        }
        if carType == 8{
            sprite = SKSpriteNode(imageNamed: "PurpleCar")
        }
        sprite.size = CGSizeMake( 35, 20)
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
        if player.position.x > width - 15 {
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
        timeAction()
    }
    
    func createWall(type: WallType) -> SKNode{
        
        let node = WallNode()
        node.wallType = type
        
        var sprite = SKSpriteNode(imageNamed: "WhiteBlock.jpeg")
        sprite.size = CGSizeMake(10, 10)
        node.addChild(sprite)
        
        node.physicsBody = SKPhysicsBody(rectangleOfSize: sprite.size)
        node.physicsBody?.dynamic = false
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.categoryBitMask = CollisionCategoryBitmask.wall
        node.physicsBody?.contactTestBitMask = CollisionCategoryBitmask.player
        node.physicsBody?.usesPreciseCollisionDetection = true
        node.physicsBody = SKPhysicsBody(rectangleOfSize: sprite.size)
        node.physicsBody?.dynamic = false
        
        node.physicsBody?.categoryBitMask = CollisionCategoryBitmask.wall
        node.physicsBody?.collisionBitMask = 0
        
        return node
        
    }
    
    
    func createRightArrow() -> SKNode{
        let rightNode = SKNode()
        rightNode.position = CGPoint(x: width * 0.9, y: height * 0.93)
        
        let sprite = SKSpriteNode(imageNamed: "RightArrow")
        sprite.size = CGSizeMake(20,25)
        rightNode.addChild(sprite)
        return rightNode
    }
    
    func createUpArrow() -> SKNode{
        let upNode = SKNode()
        upNode.position = CGPoint(x: width * 0.85, y: height * 0.98)
        
        let sprite = SKSpriteNode(imageNamed: "UpArrow")
        sprite.size = CGSizeMake(25,20)
        upNode.addChild(sprite)
        return upNode
    }
    
    func createDownArrow() -> SKNode{
        let downNode = SKNode()
        downNode.position = CGPoint(x: width * 0.85, y: height * 0.88)
        
        let sprite = SKSpriteNode(imageNamed: "DownnArrow")
        sprite.size = CGSizeMake(25,20)
        downNode.addChild(sprite)
        return downNode
    }
    
    
    func createStopSign() -> SKNode{
        let stopNode = SKNode()
        stopNode.position = CGPoint(x: width * 0.85, y: height * 0.9)
        
        let sprite = SKSpriteNode(imageNamed: "Stop")
        sprite.size = CGSizeMake(200, 100)
        stopNode.addChild(sprite)
        return stopNode
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
                if downpointer == 0{
                    player.zRotation = CGFloat(-M_PI_2)
                    pointer = 1
                    rightpointer = 0
                    downpointer = 1
                    uppointer = 0
                    player.physicsBody!.velocity = CGVectorMake(0, -20)
                }
                else{
                    player.physicsBody!.applyForce(CGVectorMake(0, -20))
                }
            } else if upArrow.containsPoint(location){
                if uppointer == 0{
                    player.zRotation = CGFloat(M_PI_2)
                    pointer = 2
                    rightpointer = 0
                    downpointer = 0
                    uppointer = 1
                    player.physicsBody!.velocity = CGVectorMake(0,20)
                }
                else{
                    player.physicsBody!.applyForce(CGVectorMake(0, 20))
                }
            }
            else if rightArrow.containsPoint(location){
                if pointer == 0 && rightpointer == 0{
                    player.physicsBody!.velocity = CGVectorMake(20, 0)
                    rightpointer = 1
                    uppointer = 0
                    downpointer = 0
                }
                if pointer == 0 && rightpointer == 1{
                    player.physicsBody!.applyForce(CGVectorMake(20,0))
                    uppointer = 0
                    downpointer = 0
                    
                }
                if pointer == 1{
                    player.zRotation = CGFloat(0)
                    player.physicsBody!.velocity = CGVectorMake(20, 0)
                    pointer = 0
                    uppointer = 0
                    downpointer = 0
                }
                if pointer == 2{
                    player.zRotation = CGFloat(0)
                    player.physicsBody!.velocity = CGVectorMake(20, 0)
                    pointer = 0
                    uppointer = 0
                    downpointer = 0
                }
                
            }
            else{
                player.physicsBody!.velocity = CGVectorMake(0,0)
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
        else{
            player.physicsBody?.velocity = CGVectorMake(0,0)
        }
    }
    
    func endGame() {
        // 1
        gameOver = true
        
        // 2
        // Save stars and high score
        GameState.sharedInstance.saveState()
        
        // 3
        //        let reveal = SKTransition.fadeWithDuration(0.5)
        //        let endGameScene = EndGameScene(size: self.size)
        //        self.view!.presentScene(endGameScene, transition: reveal)
        self.viewController.endGame()
    }
    
    
    
    
    
    
    
    
    
}



