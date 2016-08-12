//
//  AnimationScene.swift
//  Game app
//
//  Created by Abha Vedula on 7/11/16.
//  Copyright © 2016 Abha Vedula. All rights reserved.
//

import UIKit
import SpriteKit

class AnimationScene: SKScene {
    
    var villain: SKSpriteNode!
    var villainThrowingFrames: [SKTexture]!
    
    var ball: SKSpriteNode!
    
    var player: SKSpriteNode!
    var playerBlockingFrames: [SKTexture]!
    
    var playerWalkingFrames : [SKTexture]!
    
    var firstFrame2: SKTexture!
    
    var speech: SKSpriteNode!


    
    
    override func didMoveToView(view: SKView) {
        let bgImage = SKSpriteNode(imageNamed: "hallway")
        bgImage.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        bgImage.zPosition = 0

        self.addChild(bgImage)
        
        ball = SKSpriteNode(imageNamed:"ball")
        self.addChild(ball)
        self.ball.position = CGPoint(x: 250, y: 230)
        self.ball.zPosition = 2
        ball.setScale(2.5)
        ball.hidden = true
        
        let villainAnimatedAtlas = SKTextureAtlas(named: "villainThrowing")
        var throwFrames = [SKTexture]()
        
        let numImages = villainAnimatedAtlas.textureNames.count
        for var i=1; i<=numImages; i += 1 {
            let villainTextureName = "villain\(i)"
            throwFrames.append(villainAnimatedAtlas.textureNamed(villainTextureName))
        }
        
        villainThrowingFrames = throwFrames
        
        let firstFrame = villainThrowingFrames[0]
        villain = SKSpriteNode(texture: firstFrame)
        villain.position = CGPoint(x: 255, y: 65)
        //villain.setScale(3)
        villain.xScale = 2.7
        villain.yScale = 3
        villain.zPosition = 1
        addChild(villain)
        
        let playerAnimatedAtlas = SKTextureAtlas(named: "playerBlocking")
        var blockFrames = [SKTexture]()
        
        let numImages2 = playerAnimatedAtlas.textureNames.count
        for var i=1; i<=numImages2; i += 1 {
            let playerTextureName = "hero\(i)"
            blockFrames.append(playerAnimatedAtlas.textureNamed(playerTextureName))
        }
        
        playerBlockingFrames = blockFrames
        
        firstFrame2 = playerBlockingFrames[0]
        player = SKSpriteNode(texture: firstFrame2)
        player.position = CGPoint(x: 396, y: 190)
        //player.setScale(3)
        player.zPosition = 1
        addChild(player)
        
        let playerAnimatedAtlas2 = SKTextureAtlas(named: "playerImages2")
        var walkFrames = [SKTexture]()
        
        
        let numImagesPlayer3 = playerAnimatedAtlas2.textureNames.count
        for var i = 1; i <= numImagesPlayer3/2; i += 1 {
            let playerTextureName2 = "run\(i)"
            walkFrames.append(playerAnimatedAtlas2.textureNamed(playerTextureName2))
        }
        
        playerWalkingFrames = walkFrames
        
        speech = SKSpriteNode(imageNamed: "speech 2")
        speech.position = CGPoint(x: 488, y: 237)
        speech.zPosition = 1
        speech.setScale(0.4)
        self.addChild(speech)
        
        var arr = ["You've got to", "help me escape!"]
        var xPos = 25
        for i in 0..<arr.count {
            let label = SKLabelNode(text: arr[i])
            label.zPosition = speech.zPosition + 1
            label.fontColor = UIColor.blackColor()
            label.fontName = "ChalkboardSE-Bold"
            label.fontSize = 30
            label.position = CGPoint(x: 0, y: CGFloat(xPos - 25 * i))
            speech.addChild(label)
        }

        startAnimation()
        
    }
    
    let timePerFrame: NSTimeInterval = 0.3
    
    func startAnimation() {
        let throwAction = (SKAction.animateWithTextures(villainThrowingFrames,
                timePerFrame: timePerFrame,
                resize: false,
                restore: false))
        
        let blockAction = (SKAction.animateWithTextures(playerBlockingFrames,
            timePerFrame: timePerFrame,
            resize: false,
            restore: false))
        
        let startRun = (SKAction.runBlock({
            
            self.firstFrame2 = self.playerWalkingFrames[0]
            self.player = SKSpriteNode(texture: self.firstFrame2)

            
        }))
        
        
        let runAction = (SKAction.animateWithTextures(playerWalkingFrames,
            timePerFrame: timePerFrame,
            resize: false,
            restore: false))
        
        
        let doneActionVillain = (SKAction.runBlock({
            
            print("Animation Completed")
            self.moveEnded(self.villain)
            
        }))
        
        let doneActionPlayer = (SKAction.runBlock({
            
            print("Animation Completed")
            self.moveEnded(self.player)
            
        }))
  
        
        let addBall = (SKAction.runBlock({

            self.ball.hidden = false
        }))
        
    
        let moveBall = (SKAction.runBlock({
            
            self.ball.position = CGPoint(x: 328, y: 261)
        }))
        
      
        
        let moveBall1 = SKAction.moveTo(CGPoint(x: 373, y: 217), duration: 0.3)
        
        let moveBall2 = SKAction.moveTo(CGPoint(x: 380, y: 215), duration: 0.1)
        
        let moveBall3 = SKAction.moveTo(CGPoint(x: 390, y: 212), duration: 0.3)
        
        let moveBall4 = SKAction.moveTo(CGPoint(x: 426, y: 201), duration: 0.4)
        
        let moveBall5 = SKAction.moveTo(CGPoint(x: 434, y: 200), duration: 0.4)
        
        
        let scale = SKAction.scaleBy(0.7, duration: 0.001)
        
        let scale2 = SKAction.scaleBy(0.9, duration: 0.001)
        
        let wait = SKAction.waitForDuration(timePerFrame * 3)
        
        let wait2 = SKAction.waitForDuration(timePerFrame)
        
        let wait3 = SKAction.waitForDuration(0.5)
        
        let fade = SKAction.fadeOutWithDuration(1)
        
//        let showNextScene = SKAction.runBlock({
//            
//            self.nextScene()
//            
//            
//        })
        
        

        
        let villainThrows = (SKAction.sequence([throwAction, doneActionVillain]))
        villain.runAction(villainThrows, withKey: "villainThrowing")
        
        let throwBall = (SKAction.sequence([wait, addBall, wait2, moveBall, wait2, scale, moveBall1,scale, moveBall2, scale, moveBall3, scale, moveBall4, scale, moveBall5, scale, fade]))
        ball.runAction(throwBall)
        
        let playerBlocks = (SKAction.sequence([wait3, blockAction, wait3, wait3, startRun, runAction, scale2, runAction])) // add showNextScene action to this sequence
        player.runAction(playerBlocks, withKey: "playerBlocking")
        

        
    }
    
//    func nextScene() {
//        let transition = SKTransition.fadeWithDuration(0.5)
//        let next = AnimationScene(size: self.size)
//        self.view?.presentScene(next, transition: transition)
//    }

    
    func moveEnded(node: SKSpriteNode) {
        node.removeAllActions()
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let t = touches.first
        let location = t!.locationInNode(self)
        print(location)
                
    }

}
