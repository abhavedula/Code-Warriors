//
//  ChooseCarScene.swift
//  EducationGame
//
//  Created by John Kriston on 7/25/16.
//  Copyright © 2016 Abha Vedula. All rights reserved.
//

import UIKit
import SpriteKit

class ChooseCarScene: SKScene, SKPhysicsContactDelegate {
    
    var viewController: GraphViewController!
    
    //Do viewController.func
    var red: SKSpriteNode!
    var blue: SKSpriteNode!
    var green: SKSpriteNode!
    var orange: SKSpriteNode!
    var yellow: SKSpriteNode!
    var lightblue: SKSpriteNode!
    var pink: SKSpriteNode!
    var purple: SKSpriteNode!
    var text1: SKLabelNode!
    var text2: SKLabelNode!
    var text3: SKLabelNode!
    
    var width: CGFloat!
    var height: CGFloat!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(size: CGSize, viewController: GraphViewController) {
        super.init(size: size)
        
        
        
        
        //CHANGES HERE
        
        if viewController.noAnimation {
            width = size.height - 50
            height = size.width
            
            
        } else {
            width = size.width - 50
            height = size.height
            
        }
        

        self.viewController = viewController
        backgroundColor = SKColor.blackColor()
        
        //Add Cars
        red = SKSpriteNode(imageNamed: "VerticalRedCar")
        red.size = CGSizeMake( 75, 100)
        red.position = CGPoint(x: width * 0.15, y: height * 0.65)
        addChild(red)
        
        blue = SKSpriteNode(imageNamed: "VerticalBlueCar")
        blue.size = CGSizeMake(75, 100)
        blue.position = CGPoint(x: width * 0.30, y: height * 0.65)
        addChild(blue)
        
        green = SKSpriteNode(imageNamed: "VerticalGreenCar")
        green.size = CGSizeMake(75, 100)
        green.position = CGPoint(x: width * 0.45, y: height * 0.65)
        addChild(green)
        
        orange = SKSpriteNode(imageNamed: "VerticalOrangeCar")
        orange.size = CGSizeMake(75, 100)
        orange.position = CGPoint(x: width * 0.60, y: height * 0.65)
        addChild(orange)
        
        yellow = SKSpriteNode(imageNamed: "VerticalYellowCar")
        yellow.size = CGSizeMake(75, 100)
        yellow.position = CGPoint(x: width * 0.15, y: height * 0.3)
        addChild(yellow)
        
        lightblue = SKSpriteNode(imageNamed: "VerticalLightBlueCar")
        lightblue.size = CGSizeMake(75, 100)
        lightblue.position = CGPoint(x: width * 0.30, y: height * 0.3)
        addChild(lightblue)
        
        pink = SKSpriteNode(imageNamed: "VerticalPinkCar")
        pink.size = CGSizeMake(75, 100)
        pink.position = CGPoint(x: width * 0.45, y: height * 0.3)
        addChild(pink)
        
        purple = SKSpriteNode(imageNamed: "VerticalPurpleCar")
        purple.size = CGSizeMake(75, 100)
        purple.position = CGPoint(x: width * 0.60, y: height * 0.3)
        addChild(purple)
        
        //CHANGES HERE
        text1 = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        text1.fontSize = 60
        text1.fontColor = SKColor.greenColor()
        text1.position = CGPoint(x: width * 0.825 + 20, y: height * 0.75)
        text1.text = "CHOOSE"
        addChild(text1)
        
        text2 = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        text2.fontSize = 60
        text2.fontColor = SKColor.blueColor()
        text2.position = CGPoint(x: width * 0.85, y: height * 0.45)
        text2.text = "YOUR"
        addChild(text2)
        
        text3 = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        text3.fontSize = 60
        text3.fontColor = SKColor.redColor()
        text3.position = CGPoint(x: width * 0.85, y: height * 0.15)
        text3.text = "CAR!"
        addChild(text3)
        
        
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?){
        //get location of last touch
        //let loc = touches[touches.endIndex].locationInNode(self)
        //if go.containsPoint(loc)
        
        for touch: AnyObject in touches{
            //Get the location of the touch in this scene
            let location = touch.locationInNode(self)
            
            //Check if the location of the touch is withinthe button's bounds
            
            if red.containsPoint(location){
                 GameState.sharedInstance.carType = 1
            }
            if blue.containsPoint(location){
                 GameState.sharedInstance.carType = 2
            }
            if green.containsPoint(location){
                 GameState.sharedInstance.carType = 3
            }
            if orange.containsPoint(location){
                 GameState.sharedInstance.carType = 4
            }
            if yellow.containsPoint(location){
                 GameState.sharedInstance.carType = 5
            }
            if lightblue.containsPoint(location){
                 GameState.sharedInstance.carType = 6
            }
            if pink.containsPoint(location){
                 GameState.sharedInstance.carType = 7
            }
            if purple.containsPoint(location){
                 GameState.sharedInstance.carType = 8
            }
            self.viewController.presentChooseLevel()
        }
    }
 
    
    
   
    
}





