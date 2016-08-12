//
//  IntroAnimationScene0.swift
//  EducationGame
//
//  Created by Abha Vedula on 7/31/16.
//  Copyright © 2016 Abha Vedula. All rights reserved.
//

import UIKit
import SpriteKit

//MOST RECENT

class IntroAnimationScene0: SKScene {
    
    var viewController: IntroAnimationViewController!
    
    var sky: SKSpriteNode!
    var skyFrames: [SKTexture]!
    
    
    
    init(size: CGSize, viewController: IntroAnimationViewController) {
        super.init(size: size)
        self.viewController = viewController
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMoveToView(view: SKView) {
        
        backgroundColor = (UIColor.blackColor())
        
        let dungeon = SKSpriteNode(imageNamed: "outside")
        dungeon.size = CGSizeMake(800, 800)
        dungeon.position = CGPoint(x: 510, y: -160)
        dungeon.zPosition = 1
        dungeon.setScale(1.7)
        dungeon.zRotation = CGFloat(M_PI/10)
        addChild(dungeon)
        
        let skyAtlas = SKTextureAtlas(named: "sky2")
        var skyFrames2 = [SKTexture]()
        
        let numImages = skyAtlas.textureNames.count
        for var i=1; i<=numImages; i += 1 {
            let textureName = "sky\(i)"
            skyFrames2.append(skyAtlas.textureNamed(textureName))
        }
        
        skyFrames = skyFrames2
        let firstFrame = skyFrames[0]
        sky = SKSpriteNode(texture: firstFrame)
        sky.position = CGPoint(x: size.height/2, y: size.width/2)
        sky.size = CGSizeMake(667, 375)
        //sky.setScale(2)
        //sky.zRotation = CGFloat(M_PI/10) * -1
        sky.zPosition = 0
        addChild(sky)
        
        let next = SKAction.runBlock({
            self.nextScene()
        })
        
        
        let wait = SKAction.waitForDuration(0.5)
        
        sky.runAction((SKAction.sequence(
            [SKAction.animateWithTextures(skyFrames,
                timePerFrame: 0.17,
                resize: false,
                restore: false), wait, next])))
        
    }
    
    
    func nextScene() {
        let transition = SKTransition.fadeWithDuration(1)
        let next = IntroAnimationScene1(size: self.size, viewController: viewController)
        self.view?.presentScene(next, transition: transition)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
