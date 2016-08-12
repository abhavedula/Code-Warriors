//
//  HeapAnimationScene1.swift
//  EducationGame
//
//  Created by Abha Vedula on 7/27/16.
//  Copyright © 2016 Abha Vedula. All rights reserved.
//

import UIKit
import SpriteKit

class HeapAnimationScene1: SKScene {
    
    var viewController: HeapViewController!
    
    var width: CGFloat!
    var height: CGFloat!
    
    var player : SKSpriteNode!
    var playerWalkingFrames : [SKTexture]!
    
    var player2:SKSpriteNode!
    
    var tree : SKSpriteNode!
    var treeMoving : [SKTexture]!
    
    var countTouches: Int = 0
    
    var s: SKSpriteNode = SKSpriteNode()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(size: CGSize, viewController: HeapViewController) {
        super.init(size: size)
        self.viewController = viewController
        
        //CHANGES HERE
        
        viewController.rotate()
        
        width = size.height
        height = size.width
        
        
        playerAnimation(CGPoint(x: 58, y: 85))
        
        
        let treeAtlas = SKTextureAtlas(named: "tree")
        var treeFrames = [SKTexture]()
        
        let numImagesTree = treeAtlas.textureNames.count
        for i in 1...numImagesTree {
            let treeTextureName = "tree\(i)"
            treeFrames.append(treeAtlas.textureNamed(treeTextureName))
        }
        
        treeMoving = treeFrames
        
        
        let firstTreeFrame = treeMoving[0]
        tree = SKSpriteNode(texture: firstTreeFrame)
        tree.position = CGPoint(x: 445, y: 120)
        tree.zPosition = 2
        tree.setScale(0.7)
        addChild(tree)
        
    }
    
    override func didMoveToView(view: SKView) {
        
        let bg = SKSpriteNode(imageNamed: "stairs")
        bg.position = CGPoint(x: width/2, y: height/2)
        bg.zPosition = 0
        addChild(bg)
        
        startAnimation()
        
    }
    
    func playerAnimation(pos: CGPoint) {
        let playerAnimatedAtlas = SKTextureAtlas(named: "playerImages2")
        var walkFrames = [SKTexture]()
        
        let numImagesPlayer = playerAnimatedAtlas.textureNames.count
        for i in 1...numImagesPlayer {
            let playerTextureName = "run\(i)"
            walkFrames.append(playerAnimatedAtlas.textureNamed(playerTextureName))
        }
        
        playerWalkingFrames = walkFrames
        
        
        let firstPlayerFrame = playerWalkingFrames[0]
        player = SKSpriteNode(texture: firstPlayerFrame)
        player.position = pos
        player.zPosition = 1
        addChild(player)
        
    }
    
    func startAnimation() {
        player.runAction(SKAction.repeatActionForever(
            SKAction.animateWithTextures(playerWalkingFrames,
                timePerFrame: 0.2,
                resize: false,
                restore: true)),
                         withKey:"walkingInPlaceplayer")
        
        let run = SKAction.moveToX(158, duration: 1.2)
        
        let done = SKAction.runBlock({
            self.player.removeAllActions()
            let pos = self.player.position
            self.player.removeFromParent()
            self.player2 = SKSpriteNode(imageNamed: "player")
            self.player2.position = pos
            self.player2.zPosition = 3
            self.addChild(self.player2)
        })
        
        let treeRise = SKAction.animateWithTextures(treeMoving,
                                                    timePerFrame: 1,
                                                    resize: false,
                                                    restore: false)
        
        
        
        let wait = SKAction.waitForDuration(1.5)
        
        let playerSequence = SKAction.sequence([run, done])
        player.runAction(playerSequence)
        
        let treeSequence = SKAction.sequence([wait, treeRise])
        tree.runAction(treeSequence)
        
        
    }
    
    //CHANGES HERE
    func createSpeechBubble(arr: [String], xPos: Int, x: CGFloat, y: CGFloat, z: CGFloat) -> SKSpriteNode {
        var speech = SKSpriteNode(imageNamed: "speech 2")
        speech.position = CGPoint(x: x, y: y)
        speech.zPosition = z
        speech.setScale(0.6)
        //self.addChild(speech)
        
        for i in 0..<arr.count {
            let label = SKLabelNode(text: arr[i])
            label.zPosition = speech.zPosition + 1
            label.fontColor = UIColor.blackColor()
            label.fontName = "ChalkboardSE-Bold"
            label.fontSize = 28
            label.position = CGPoint(x: 7, y: CGFloat(xPos - 30 * i))
            speech.addChild(label)
            
        }
        return speech
    }
    
    //CHANGES HERE
    func createSpeechBubble2(arr: [String], xPos: Int, x: CGFloat, y: CGFloat, z: CGFloat) -> SKSpriteNode {
        var speech = SKSpriteNode(imageNamed: "speech")
        speech.position = CGPoint(x: x, y: y)
        speech.zPosition = z
        speech.setScale(0.6)
        //self.addChild(speech)
        
        for i in 0..<arr.count {
            let label = SKLabelNode(text: arr[i])
            label.zPosition = speech.zPosition + 1
            label.fontColor = UIColor.blackColor()
            label.fontName = "ChalkboardSE-Bold"
            label.fontSize = 28
            label.position = CGPoint(x: -7, y: CGFloat(xPos - 30 * i))
            speech.addChild(label)
            
        }
        return speech
    }
    
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let t = touches.first
        let location = t!.locationInNode(self)
        print(location)
        s.removeFromParent()
        
        countTouches += 1
        if countTouches == 1 {
            s = createSpeechBubble(["I need to", "get to the door", "at the top of", "the stairs to", "escape."], xPos: 65, x: 260, y: 177, z: 5)
            self.addChild(s)
        } else if countTouches == 2 {
            s = createSpeechBubble(["The stairs are", "broken! How do", "I get there?"], xPos: 35, x: 260, y: 177, z: 30)
            self.addChild(s)
        } else if countTouches == 3 {
            player2.removeFromParent()
            s.removeFromParent()
            playerAnimation(CGPoint(x: 158, y: 85))
            player.runAction(SKAction.repeatActionForever(
                SKAction.animateWithTextures(playerWalkingFrames,
                    timePerFrame: 0.2,
                    resize: false,
                    restore: true)),
                             withKey:"walkingInPlaceplayer")
            
            let run = SKAction.moveToX(315, duration: 1.5)
            let done = SKAction.runBlock({
                self.player.removeAllActions()
                let pos = self.player.position
                self.player.removeFromParent()
                self.player2 = SKSpriteNode(imageNamed: "player")
                self.player2.position = pos
                self.player2.zPosition = 3
                self.addChild(self.player2)
            })
            
            let speech = SKAction.runBlock({
                self.s = self.createSpeechBubble2(["What is this", "thing?"], xPos: 25, x: 200, y: 177, z: 30)
                self.addChild(self.s)
            })
            
            let playerSequence = SKAction.sequence([run, done, speech])
            player.runAction(playerSequence)
            //CHANGES HERE
        } else if countTouches == 4 {
            //CHANGES HERE
            s = createSpeechBubble2(["It's growing!", "If I get on", "top, I can", "reach the", "door."], xPos: 57, x: 200, y: 177, z: 30)
            self.addChild(s)
        } else if countTouches == 5 {
            self.nextScene()
        }
        
    }
    
    func nextScene() {
        viewController.nextScene()
    }
    
}
