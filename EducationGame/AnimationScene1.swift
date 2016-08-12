//
//  AnimationScene1.swift
//  Game app
//
//  Created by Abha Vedula on 7/14/16.
//  Copyright © 2016 Abha Vedula. All rights reserved.
//

import UIKit
import SpriteKit

class AnimationScene1: SKScene {
    
    var player0: SKSpriteNode!
    var playerPunchingFrames: [SKTexture]!
    var playerJumpingFrames: [SKTexture]!
    var player: SKSpriteNode!
    var player1: SKSpriteNode!
    
    var villain0: SKSpriteNode!
    var villain: SKSpriteNode!
    var villainFalls: SKSpriteNode!
    var villainFallingFrames: [SKTexture]!
    
    var speech: SKSpriteNode!
    
    var countTouches = 0
    
    override func didMoveToView(view: SKView) {
        let bgImage = SKSpriteNode(imageNamed: "room3")
        bgImage.position = CGPoint(x: self.size.height/2, y: self.size.width/2)
        bgImage.zPosition = 0
        
        self.addChild(bgImage)
        
        player0 = SKSpriteNode(imageNamed: "player")
        player0.zPosition = 1
        player0.position = CGPoint(x: 320, y: 215)
        player0.setScale(1.2)
        self.addChild(player0)
        
        villain0 = SKSpriteNode(imageNamed: "villain")
        villain0.zPosition = 1
        villain0.position = CGPoint(x: 443, y: 200)
        villain0.setScale(2)
        self.addChild(villain0)
        
        speech = SKSpriteNode(imageNamed: "speech")
        speech.position = CGPoint(x: 350, y: 305)
        speech.zPosition = 1
        speech.setScale(0.5)
        self.addChild(speech)
        
        var arr = ["HAHA I've caught", "you. Now I can steal", "all your computer", "science skills!"]
        var xPos = 35
        for i in 0..<arr.count {
            let label = SKLabelNode(text: arr[i])
            label.zPosition = speech.zPosition + 1
            label.fontColor = UIColor.blackColor()
            label.fontName = "ChalkboardSE-Bold"
            label.fontSize = 25
            label.position = CGPoint(x: -10, y: CGFloat(xPos - 20 * i))
            speech.addChild(label)
        }
    }
    
    
    func playerPunches() {
        villain0.hidden = true
        
        
        let playerAnimatedAtlas = SKTextureAtlas(named: "playerPunch")
        var punchFrames = [SKTexture]()
        
        let numImages = playerAnimatedAtlas.textureNames.count
        for var i=1; i<=numImages; i += 1 {
            let playerTextureName = "playerPunch\(i)"
            punchFrames.append(playerAnimatedAtlas.textureNamed(playerTextureName))
        }
        
        playerPunchingFrames = punchFrames
        player0.hidden = true
        let firstFrame = playerPunchingFrames[0]
        player = SKSpriteNode(texture: firstFrame)
        player.position = CGPoint(x: 320, y: 245)
        player.setScale(1.2)
        player.zPosition = 1
        addChild(player)
        
        let punchAction = (SKAction.animateWithTextures(playerPunchingFrames,
            timePerFrame: 0.2,
            resize: false,
            restore: false))
        
        let movePlayer = SKAction.moveTo(CGPoint(x: 435, y: 230), duration: 0.2)
        
        let scale = SKAction.scaleBy(1.2, duration: 0.0001)
        
        let wait = SKAction.waitForDuration(1.6)
        let wait2 = SKAction.waitForDuration(0.5)
        let wait3 = SKAction.waitForDuration(0.2)
        
        
        let showNextScene = SKAction.runBlock({
            
            self.nextScene()
            
            
        })
        
        

        
        let movePlayer1 = SKAction.moveTo(CGPoint(x: 550, y: 320), duration: 0.12)
        let movePlayer2 = SKAction.moveTo(CGPoint(x: 600, y: 160), duration: 0.15)
        let movePlayer3 = SKAction.moveTo(CGPoint(x: 685, y: 160), duration: 0.15)
        let movePlayer4 = SKAction.moveTo(CGPoint(x: 700, y: 160), duration: 0.15)

        
        let playerPunches = (SKAction.sequence([punchAction]))
        player.runAction(playerPunches)
        
        
        let playerMoves = (SKAction.sequence([movePlayer, scale, wait, movePlayer1, movePlayer2, wait2, movePlayer3, movePlayer4, showNextScene]))
        player.runAction(playerMoves)
        
      
        
    }
    
    func villainDoesFall() {
        let villainAnimatedAtlas = SKTextureAtlas(named: "villainFalling")
        var fallFrames = [SKTexture]()
        
        let numImages = villainAnimatedAtlas.textureNames.count
        for var i=1; i<=numImages; i += 1 {
            let villainTextureName = "villainFalls\(i)"
            fallFrames.append(villainAnimatedAtlas.textureNamed(villainTextureName))
        }
        
        villainFallingFrames = fallFrames
        let firstFrame = villainFallingFrames[0]
        villainFalls = SKSpriteNode(texture: firstFrame)
        villainFalls.position = CGPoint(x: 443, y: 200)
        villainFalls.setScale(2)
        villainFalls.zPosition = 2
        addChild(villainFalls)
        
        let fallAction = (SKAction.animateWithTextures(villainFallingFrames,
            timePerFrame: 0.1,
            resize: false,
            restore: false))
        
        let moveVillain = SKAction.moveTo(CGPoint(x: 540, y: 187), duration: 1)
        

        
        let wait = SKAction.waitForDuration(0.3)
        
        let villainFalling = (SKAction.sequence([moveVillain, wait, fallAction]))
        villainFalls.runAction(villainFalling)
        
    }
    
    
    func nextScene() {
        let transition = SKTransition.fadeWithDuration(0.5)
        let next = AnimationScene(size: self.size)
        self.view?.presentScene(next, transition: transition)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let t = touches.first
        let location = t!.locationInNode(self)
        print(location)
        countTouches += 1
        if countTouches == 1 {
            speech.hidden = true
            playerPunches()
            villainDoesFall()
            
        }
        
    }
}
