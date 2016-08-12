//
//  AnimationExplanationScene2.swift
//  Maze 3
//
//  Created by Abha Vedula on 7/16/16.
//  Copyright © 2016 Abha Vedula. All rights reserved.
//

import UIKit
import SpriteKit

class MazeAnimationScene2: SKScene {
    
    var viewController: MazeViewController!
    
    var maze: SKSpriteNode!
    
    var speech: SKSpriteNode!
    
    var text: SKLabelNode!
    
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
        
        print("maze animation 2")
        
        self.backgroundColor = UIColor.blackColor()
        
        
        maze = SKSpriteNode(imageNamed: "mazee")
        maze.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        maze.zPosition = 5
        maze.setScale(0.93)
        addChild(self.maze)
        maze.alpha = 0.1
        maze.runAction((SKAction.fadeInWithDuration(3)))
        
        
        for i in 0..<4 {
            let imageNames = ["up", "down", "left", "right"]
            let imageName = imageNames[i]
            
            
            let label = SKLabelNode(text: imageName)
            label.fontSize = 30
            label.zPosition = 3
            label.position = CGPoint(x: 0, y: -8)
            label.fontName = "Avenir-Black"
            
            let sprite = SKSpriteNode(imageNamed: "redBox")
            sprite.yScale = 1.2
            sprite.zPosition = 2
            
            let pos = [[100, 340], [100, 290], [280, 340], [280,290]]
            
            sprite.position = CGPoint(x: pos[i][0], y: pos[i][1])
            
            self.addChild(sprite)
            sprite.addChild(label)
            
        }
        
        
        speech = SKSpriteNode(imageNamed: "speech")
        self.speech.position = CGPoint(x: 515, y: 100)
        self.speech.zPosition = 6
        //self.speech.alpha = 0
        self.speech.hidden = true
        self.speech.setScale(0.9)
        //self.speech.runAction(SKAction.fadeInWithDuration(3))
        
        addChild(speech)
        
        let speechShow = SKAction.runBlock({
            self.speech.hidden = false
            
        })
        let wait = SKAction.waitForDuration(3)
        
        let sequence = SKAction.sequence([wait, speechShow])
        speech.runAction(sequence)
        
        
        
        var arr = ["I think there's", "an exit on the", "other side."]
        var xPos = 30
        for i in 0..<arr.count {
            let label = SKLabelNode(text: arr[i])
            label.zPosition = self.speech.zPosition + 1
            label.fontColor = UIColor.blackColor()
            label.fontName = "ChalkboardSE-Bold"
            label.fontSize = 23
            label.position = CGPoint(x: -10, y: CGFloat(xPos - 30 * i))
            self.speech.addChild(label)
        }
        
        
        
    }
    //CHANGES HERE
    func changeText() {
        
        
        var speechBubble = SKSpriteNode(imageNamed: "speech")
        speechBubble.position = CGPoint(x: 515, y: 100)
        speechBubble.zPosition = 20
        speechBubble.setScale(0.9)
        addChild(speechBubble)
        var arr = ["It's so dark, I'm", "going to need", "help getting out", "of this maze."]
        var xPos = 35
        for i in 0..<arr.count {
            let label = SKLabelNode(text: arr[i])
            label.zPosition = speechBubble.zPosition + 1
            label.fontColor = UIColor.blackColor()
            label.fontName = "ChalkboardSE-Bold"
            label.fontSize = 23
            label.position = CGPoint(x: -10, y: CGFloat(xPos - 25 * i))
            speechBubble.addChild(label)
        }
        
    }
    //CHANGES HERE
    func showInstructions() {
        
        
        var speechBubble = SKSpriteNode(imageNamed: "speech")
        speechBubble.position = CGPoint(x: 515, y: 100)
        speechBubble.zPosition = 50
        speechBubble.setScale(0.9)
        addChild(speechBubble)
        var arr = ["I think you can use", "the blocks to guide","me out."]
        var xPos = 20
        for i in 0..<arr.count {
            let label = SKLabelNode(text: arr[i])
            label.zPosition = speechBubble.zPosition + 1
            label.fontColor = UIColor.blackColor()
            label.fontName = "ChalkboardSE-Bold"
            label.fontSize = 23
            label.position = CGPoint(x: -10, y: CGFloat(xPos - 25 * i))
            speechBubble.addChild(label)
        }
    }
    
    
    
    //CHANGES HERE
    func showInstructions2() {
        
        var speechBubble = SKSpriteNode(imageNamed: "speech")
        speechBubble.position = CGPoint(x: 515, y: 100)
        speechBubble.zPosition = 140
        speechBubble.setScale(0.9)
        addChild(speechBubble)
        var arr = ["This is just like", "programming a", "computer."]
        var xPos = 30
        for i in 0..<arr.count {
            let label = SKLabelNode(text: arr[i])
            label.zPosition = speechBubble.zPosition + 1
            label.fontColor = UIColor.blackColor()
            label.fontName = "ChalkboardSE-Bold"
            label.fontSize = 23
            label.position = CGPoint(x: -10, y: CGFloat(xPos - 27 * i))
            speechBubble.addChild(label)
        }
        
        
    }
    
    //CHANGES HERE
    func showInstructions3() {
        
        let arr = ["Computers need", "very specific instructions,", "because they take", "everything literally and", "can't read", "between the lines."]
        
        var speechBubble = SKSpriteNode(imageNamed: "speech")
        speechBubble.position = CGPoint(x: 515, y: 100)
        speechBubble.zPosition = 300
        speechBubble.setScale(0.9)
        addChild(speechBubble)
        let xPos = 55
        for i in 0..<arr.count {
            let label = SKLabelNode(text: arr[i])
            label.zPosition = speechBubble.zPosition + 1
            label.fontColor = UIColor.blackColor()
            label.fontName = "ChalkboardSE-Bold"
            label.fontSize = 18
            label.position = CGPoint(x: -10, y: CGFloat(xPos - 20 * i))
            speechBubble.addChild(label)
        }
    }
    
    //CHANGES HERE
    func showInstructions4() {
        
        let arr = ["Drag the blocks", "into the box to tell", "me how to move. Make sure", "I don't run into the ghost", "or fall into the hole.", "Take advantage of", "the portals!"]
        
        var speechBubble = SKSpriteNode(imageNamed: "speech")
        speechBubble.position = CGPoint(x: 515, y: 100)
        speechBubble.zPosition = 1000
        speechBubble.setScale(0.9)
        addChild(speechBubble)
        let xPos = 60
        for i in 0..<arr.count {
            let label = SKLabelNode(text: arr[i])
            label.zPosition = speechBubble.zPosition + 1
            label.fontColor = UIColor.blackColor()
            label.fontName = "ChalkboardSE-Bold"
            label.fontSize = 18
            label.position = CGPoint(x: -10, y: CGFloat(xPos - 20 * i))
            speechBubble.addChild(label)
        }
    }
    
    
    
    func startGame() {
        self.start = SKLabelNode(text: "Click here to start playing")
        start.fontName = "ChalkboardSE-Bold"
        self.start.fontColor = UIColor.whiteColor()
        self.start.position = CGPoint(x: self.size.width/2, y: self.size.height/2 + 20)
        self.start.zPosition = 7
        self.addChild(self.start)
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        countTouches += 1
        if countTouches == 1 {
            changeText()
        } else if countTouches == 2 {
            showInstructions()
        } else if countTouches == 3 {
            showInstructions2()
        } else if countTouches == 4 {
            showInstructions3()
        } else if countTouches == 5 {
            showInstructions4()
        } else if countTouches == 6 {
            startGame()
        } else if countTouches == 7 {
            self.viewController.mazeGame()
        }
        
        
    }
    
    
}
