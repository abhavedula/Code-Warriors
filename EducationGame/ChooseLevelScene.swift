//
//  ChooseLevelScene.swift
//  EducationGame
//
//  Created by John Kriston on 7/26/16.
//  Copyright © 2016 Abha Vedula. All rights reserved.
//

import SpriteKit


class ChooseLevelScene: SKScene, SKPhysicsContactDelegate {
    
    var viewController: GraphViewController!
    
    //Do viewController.func
    var text1: SKLabelNode!
    var text2: SKLabelNode!
    var text3: SKLabelNode!
    var text4: SKLabelNode!
    var text5: SKLabelNode!
    var text6: SKLabelNode!
    var easy: SKSpriteNode!
    var medium: SKSpriteNode!
    var hard: SKSpriteNode!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(size: CGSize, viewController: GraphViewController) {
        super.init(size: size)
        self.viewController = viewController
        backgroundColor = SKColor.blueColor()
        
        text1 = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        text1.fontSize = 60
        text1.fontColor = SKColor.whiteColor()
        text1.position = CGPoint(x: size.width * 0.25, y: size.height * 0.75)
        text1.text = "Choose"
        addChild(text1)
        
        text2 = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        text2.fontSize = 60
        text2.fontColor = SKColor.whiteColor()
        text2.position = CGPoint(x: size.width * 0.50, y: size.height * 0.75)
        text2.text = "The"
        addChild(text2)
        
        text3 = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        text3.fontSize = 60
        text3.fontColor = SKColor.whiteColor()
        text3.position = CGPoint(x: size.width * 0.725, y: size.height * 0.75)
        text3.text = "Level"
        addChild(text3)
        
        
        text4 = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        text4.fontSize = 40
        text4.fontColor = SKColor.greenColor()
        text4.position = CGPoint(x: size.width * 0.2, y: size.height * 0.15)
        text4.text = "EASY"
        addChild(text4)
        
        text5 = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        text5.fontSize = 40
        text5.fontColor = SKColor.yellowColor()
        text5.position = CGPoint(x: size.width * 0.50, y: size.height * 0.15)
        text5.text = "MEDIUM"
        addChild(text5)
        
        text6 = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        text6.fontSize = 40
        text6.fontColor = SKColor.redColor()
        text6.position = CGPoint(x: size.width * 0.80, y: size.height * 0.15)
        text6.text = "HARD"
        addChild(text6)
        
        easy = SKSpriteNode(imageNamed: "Game1")
        easy.size = CGSizeMake(150, 150)
        easy.position = CGPoint(x: size.width * 0.2, y: size.height * 0.45)
        addChild(easy)
        
        medium = SKSpriteNode(imageNamed: "Game2")
        medium.size = CGSizeMake(150,150)
        medium.position = CGPoint(x: size.width * 0.50, y: size.height * 0.45)
        addChild(medium)
        
        hard = SKSpriteNode(imageNamed: "Game3")
        hard.size = CGSizeMake(150,150)
        hard.position = CGPoint(x: size.width * 0.80, y: size.height * 0.45)
        addChild(hard)
        
        

    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?){
        //get location of last touch
        //let loc = touches[touches.endIndex].locationInNode(self)
        //if go.containsPoint(loc)
        
        for touch: AnyObject in touches{
            //Get the location of the touch in this scene
            let location = touch.locationInNode(self)
            
            //Check if the location of the touch is withinthe button's bounds
            
            if easy.containsPoint(location){
                self.viewController.presentGame()
            }
            if medium.containsPoint(location){
                self.viewController.presentGame1()
            }
            if hard.containsPoint(location){
                self.viewController.presentGame2()
            }
        }
    }

    
}