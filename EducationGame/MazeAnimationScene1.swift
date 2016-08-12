//
//  AnimationExplanationScene.swift
//  Maze 3
//
//  Created by Abha Vedula on 7/11/16.
//  Copyright © 2016 Abha Vedula. All rights reserved.
//

import UIKit
import SpriteKit

class MazeAnimationScene1: SKScene {
    
    var viewController: MazeViewController!
    
    var player : SKSpriteNode!
    var playerWalkingFrames : [SKTexture]!
    
    var bgImage: SKSpriteNode!
    var bgImage2: SKSpriteNode!
    
    var door : SKSpriteNode!
    var doorOpenFrames : [SKTexture]!
    
    var openDoor = SKSpriteNode(imageNamed: "door4-2")
    
    var maze: SKSpriteNode!
    
    var speech: SKSpriteNode!
    
    var text: SKLabelNode!
    
    var instructions: SKLabelNode!
    
    var start: SKLabelNode!
    
    var countTouches = 0
    
    init(size: CGSize, viewController: MazeViewController) {
        super.init(size: size)
        self.viewController = viewController
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        
        speech = SKSpriteNode(imageNamed: "speech")
        speech.position = CGPoint(x: 490, y: 165)
        speech.zPosition = 1
        speech.setScale(0.4)
        self.addChild(speech)
        
        //CHANGES HERE
        text = SKLabelNode(text: "I see a door!")
        text.fontColor = UIColor.blackColor()
        text.zPosition = speech.zPosition + 1
        text.fontSize = 38
        text.fontName = "ChalkboardSE-Bold"
        speech.addChild(text)
        text.position = CGPoint(x: -10, y: 0)
        
        
        
        openDoor.hidden = true
        bgImage = SKSpriteNode(imageNamed: "bg")
        bgImage.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        bgImage.setScale(0.93)
        print(size.width)
        print(size.height)
        
        self.addChild(bgImage)
        
        let playerAnimatedAtlas = SKTextureAtlas(named: "playerImages")
        var walkFrames = [SKTexture]()
        
        //CHANGES HERE
        let numImagesPlayer = playerAnimatedAtlas.textureNames.count
        for var i = 1; i <= numImagesPlayer; i += 1 {
            let playerTextureName = "run\(i)"
            walkFrames.append(playerAnimatedAtlas.textureNamed(playerTextureName))
        }
        
        playerWalkingFrames = walkFrames
        
        
        let firstPlayerFrame = playerWalkingFrames[0]
        player = SKSpriteNode(texture: firstPlayerFrame)
        player.position = CGPoint(x: 660, y: 100)
        player.xScale = 1.5
        player.yScale = 1.5
        player.zPosition = 1
        addChild(player)
        
        //door
        
        let doorAnimatedAtlas = SKTextureAtlas(named: "doorImages2")
        var doorFrames = [SKTexture]()
        
        let numImagesDoor = playerAnimatedAtlas.textureNames.count
        for var i = 1; i <= numImagesDoor/2; i += 1 {
            let doorTextureName = "door\(i)"
            doorFrames.append(doorAnimatedAtlas.textureNamed(doorTextureName))
        }
        
        doorOpenFrames = doorFrames
        
        
        
        startAnimation()
        
        
    }
    
    func startAnimation() {
        //This is our general runAction method to make our player walk.
        player.runAction(SKAction.repeatActionForever(
            SKAction.animateWithTextures(playerWalkingFrames,
                timePerFrame: 0.2,
                resize: false,
                restore: true)),
                         withKey:"walkingInPlaceplayer")
        
        
        
        
        let scale = SKAction.scaleXBy(0.9, y: 0.9, duration: 0.001)
        
        if (player.actionForKey("playerMoving") != nil) {
            //stop just the moving to a new location, but leave the walking legs movement running
            player.removeActionForKey("playerMoving")
        }
        
        if (player.actionForKey("walkingInPlaceplayer") == nil) {
            //if legs are not moving go ahead and start them
            startAnimation()
        }
        
        
        let moveAction = SKAction.moveTo(CGPoint(x: 375, y: 105), duration:1.5)
        
        let speechAction = SKAction.moveTo(CGPoint(x: 275, y: 160), duration:1.5)
        
        
        let moveAction2 = SKAction.moveTo(CGPoint(x: 181, y: 110), duration:1.5)
        
        let speechAction2 = SKAction.moveTo(CGPoint(x: 81, y: 165), duration:1.5)
        
        
        let moveAction3 = SKAction.moveTo(CGPoint(x: 70, y: 115), duration:1)
        
        
        
        let speechDoneAction = (SKAction.runBlock({
            
            self.speech.hidden = true
            
        }))
        
        let textDoneAction = (SKAction.runBlock({
            
            self.text.hidden = true
            
        }))
        
        
        let doneAction = (SKAction.runBlock({
            
            print("Animation Completed")
            self.playerMoveEnded()
            
        }))
        
        
        let showDoor = (SKAction.runBlock({
            
            self.bgImage2 = SKSpriteNode(imageNamed: "bg2")
            self.bgImage2.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
            self.bgImage2.zPosition = 2
            self.bgImage2.xScale = 1.2
            self.addChild(self.bgImage2)
            print("changed")
            
            
            let firstDoorFrame = self.doorOpenFrames[0]
            self.door = SKSpriteNode(texture: firstDoorFrame)
            
            self.door.zPosition = 3
            self.door.xScale = 4
            self.door.yScale = 5
            self.door.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
            self.addChild(self.door)
            
            
        }))
        
        
        let openTheDoor = (SKAction.runBlock({
            self.door.runAction(
                SKAction.animateWithTextures(self.doorOpenFrames,
                    timePerFrame: 0.7,
                    resize: false,
                    restore: false),
                withKey:"openDoor")
            
        }))
        
        
        
        
        let showOpenDoor = (SKAction.runBlock({
            self.openDoor.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
            self.openDoor.zPosition = 4
            self.openDoor.xScale = 4
            self.openDoor.yScale = 5
            self.openDoor.hidden = false
            
            self.addChild(self.openDoor)
            
        }))
        
        
        let wait2 = SKAction.waitForDuration(3)
        
        let wait3 = SKAction.waitForDuration(1)
        
        var zoom = 2
        
        
        let zoomInDoor = (SKAction.runBlock({
            self.door.hidden = true
            self.openDoor.xScale = 2 * CGFloat(zoom)
            self.openDoor.yScale = 2.5 * CGFloat(zoom)
            zoom += 1
        }))
        
        let showNextScene = SKAction.runBlock({
            
            self.viewController.nextScene()
            
            
        })
        
        
        
        let playerRuns = (SKAction.sequence([moveAction, scale, moveAction2, scale, moveAction3, doneAction]))
        player.runAction(playerRuns, withKey:"playerMoving")
        
        let playerSpeech = (SKAction.sequence([speechAction, speechAction2, speechDoneAction]))
        speech.runAction(playerSpeech)
        
        
        let approachDoor = (SKAction.sequence([wait3, wait2, showDoor, openTheDoor, wait2, showOpenDoor, wait2]))
        bgImage.runAction(approachDoor)
        
        
        let goInDoor = (SKAction.sequence([zoomInDoor, wait3, zoomInDoor, wait3, zoomInDoor, wait3, zoomInDoor, zoomInDoor, showNextScene]))
        openDoor.runAction(goInDoor)
        
        
    }
    
    
    func playerMoveEnded() {
        player.removeAllActions()
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    
    
}
