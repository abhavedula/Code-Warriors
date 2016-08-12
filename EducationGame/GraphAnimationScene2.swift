//
//  NextScene.swift
//  CarGame
//
//  Created by John Kriston on 7/13/16.
//  Copyright © 2016 John Kriston. All rights reserved.
//

import SpriteKit

class GraphAnimationScene2: SKScene {
    
    var viewController: GraphViewController!
    
    var counter: Int = 0
    var bubble: SKSpriteNode = SKSpriteNode(imageNamed: "SpeechBubble")
    var bubbletwo: SKSpriteNode = SKSpriteNode(imageNamed: "bubble")
    var text: SKLabelNode!
    var text1: SKLabelNode!
    var text2: SKLabelNode!
    var text3: SKLabelNode!
    var text4: SKLabelNode!
    var text5: SKLabelNode!
    var text6: SKLabelNode!
    var spanningTree = SKSpriteNode(imageNamed: "spanningTree")
    var spanningTreeSolution = SKSpriteNode(imageNamed: "spanningTreeSolution")
    var leftArrow = SKSpriteNode(imageNamed: "leftArrow")
    var leftArrowLabel = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    var leftArrowTwo = SKSpriteNode(imageNamed: "leftArrow")
    var leftArrowTwoLabel = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    var rightArrow = SKSpriteNode(imageNamed: "RightArrow")
    var rightArrowLabel = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    var rightArrowTwo = SKSpriteNode(imageNamed: "RightArrow")
    var rightArrowTwoLabel = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    var shortest = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    var hero : SKSpriteNode!
    var heroRunningFrames : [SKTexture]!
    var multiplierForDirection: CGFloat!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    init(size: CGSize, viewController: GraphViewController) {
        super.init(size: size)
        self.viewController = viewController
        backgroundColor = SKColor.blackColor()
        
        
        
        // var bubbletwo: SKSpriteNode!
        let background = SKSpriteNode(imageNamed: "road")
        background.size = CGSizeMake(size.width, size.height)
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.zPosition = 0
        addChild(background)
        
        shortest.fontSize = 20
        shortest.zPosition = 2
        shortest.fontColor = SKColor.greenColor()
        shortest.position = CGPoint(x: size.width * 0.65, y: size.height * 0.395)
        shortest.text = "Shortest Distance from 'a' to 'g': 12"
        shortest.hidden = true
        addChild(shortest)
        
        let drivingcar = SKSpriteNode(imageNamed: "car123")
        drivingcar.size = CGSizeMake(175, 125)
        drivingcar.position = CGPoint(x: 550, y: 75)
        drivingcar.zPosition = 1
        addChild(drivingcar)
        leftArrow.size = CGSizeMake(25, 20)
        leftArrow.position = CGPoint(x: size.width * 0.56, y: size.height * 0.56)
        leftArrow.zPosition = 2
        leftArrow.hidden = true
        addChild(leftArrow)
        
        leftArrowLabel = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        leftArrowLabel.fontSize = 12
        leftArrowLabel.zPosition = 2
        leftArrowLabel.fontColor = SKColor.whiteColor()
        leftArrowLabel.position = CGPoint(x: size.width * 0.605, y: size.height * 0.54)
        leftArrowLabel.text = "Edge"
        leftArrowLabel.hidden = true
        addChild(leftArrowLabel)
        
        leftArrowTwo.size = CGSizeMake(25, 20)
        leftArrowTwo.position = CGPoint(x: size.width * 0.49, y: size.height * 0.42)
        leftArrowTwo.zPosition = 2
        leftArrowTwo.hidden = true
        addChild(leftArrowTwo)
        
        leftArrowTwoLabel = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        leftArrowTwoLabel.fontSize = 12
        leftArrowTwoLabel.zPosition = 2
        leftArrowTwoLabel.fontColor = SKColor.whiteColor()
        leftArrowTwoLabel.position = CGPoint(x: size.width * 0.535, y: size.height * 0.415)
        leftArrowTwoLabel.text = "Node"
        leftArrowTwoLabel.hidden = true
        addChild(leftArrowTwoLabel)
        
        rightArrow.size = CGSizeMake(25, 20)
        rightArrow.position = CGPoint(x: size.width * 0.51, y: size.height * 0.915)
        rightArrow.zPosition = 2
        rightArrow.hidden = true
        addChild(rightArrow)
        
        rightArrowLabel = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        rightArrowLabel.fontSize = 12
        rightArrowLabel.zPosition = 2
        rightArrowLabel.fontColor = SKColor.whiteColor()
        rightArrowLabel.position = CGPoint(x: size.width * 0.41, y: size.height * 0.915)
        rightArrowLabel.text = "Intersection/Node"
        rightArrowLabel.hidden = true
        addChild(rightArrowLabel)
        
        rightArrowTwo.size = CGSizeMake(25, 20)
        rightArrowTwo.position = CGPoint(x: size.width * 0.44, y: size.height * 0.78)
        rightArrowTwo.zPosition = 2
        rightArrowTwo.hidden = true
        addChild(rightArrowTwo)
        
        rightArrowTwoLabel = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        rightArrowTwoLabel.fontSize = 12
        rightArrowTwoLabel.zPosition = 2
        rightArrowTwoLabel.fontColor = SKColor.whiteColor()
        rightArrowTwoLabel.position = CGPoint(x: size.width * 0.37, y: size.height * 0.78)
        rightArrowTwoLabel.text = "Road/Edge"
        rightArrowTwoLabel.hidden = true
        addChild(rightArrowTwoLabel)
        
        
        
        spanningTree.size = CGSizeMake(400,200)
        spanningTree.position = CGPoint(x: size.width * 0.32, y: size.height * 0.65)
        spanningTree.zPosition = 1
        spanningTree.hidden = true
        addChild(spanningTree)
        
        spanningTreeSolution.size = CGSizeMake(400,200)
        spanningTreeSolution.position = CGPoint(x: size.width * 0.675, y: size.height * 0.7)
        spanningTreeSolution.zPosition = 1
        spanningTreeSolution.hidden = true
        addChild(spanningTreeSolution)
        
        bubble = SKSpriteNode(imageNamed: "SpeechBubble")
        //bubble.size = CGSizeMake(200, 200)
        
        //CHANGES HERE
        bubble.size = CGSizeMake(220, 140)
        
        bubble.position = CGPoint(x: 575, y: 250)
        bubble.zPosition = 1
        bubble.hidden = false
        addChild(bubble)
        
        text = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        text.fontSize = 15
        text.zPosition = 2
        text.fontColor = SKColor.blackColor()
        text.position = CGPoint(x: -4, y: 15)
        text.text = "Looks like we are going"
        bubble.addChild(text)
        
        text1 = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        text1.fontSize = 15
        text1.zPosition = 2
        text1.fontColor = SKColor.blackColor()
        text1.position = CGPoint(x: -4, y: 0)
        text1.text = "to have to drive our way"
        bubble.addChild(text1)
        
        text2 = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        text2.fontSize = 15
        text2.zPosition = 2
        text2.fontColor = SKColor.blackColor()
        text2.position = CGPoint(x: 2, y: -15)
        text2.text = "out of this one!"
        bubble.addChild(text2)
        
        bubbletwo = SKSpriteNode(imageNamed: "bubble")
        bubbletwo.size = CGSizeMake(260, 260)
        bubbletwo.position = CGPoint(x: 130,y: 100 )
        bubbletwo.zPosition = 1
        bubbletwo.hidden = true
        addChild(bubbletwo)
        
        
        text3 = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        text3.fontSize = 17
        text3.zPosition = 2
        text3.fontColor = SKColor.blackColor()
        text3.position = CGPoint(x: 0, y: 50)
        text3.text = "When driving, think of"
        bubbletwo.addChild(text3)
        
        text4 = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        text4.fontSize = 17
        text4.zPosition = 2
        text4.fontColor = SKColor.blackColor()
        text4.position = CGPoint(x: 0, y: 30)
        text4.text = "the roads as edges of the"
        bubbletwo.addChild(text4)
        
        text5 = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        text5.fontSize = 17
        text5.zPosition = 2
        text5.fontColor = SKColor.blackColor()
        text5.position = CGPoint(x: 2, y: 10)
        text5.text = "graph, and intersections"
        bubbletwo.addChild(text5)
        
        text6 = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        text6.fontSize = 17
        text6.zPosition = 2
        text6.fontColor = SKColor.blackColor()
        text6.position = CGPoint(x: 5, y: -10)
        text6.text = "as nodes."
        bubbletwo.addChild(text6)
        
        let heroAnimatedAtlas = SKTextureAtlas(named: "playerImages")
        var runFrames = [SKTexture]()
        
        let numImages = heroAnimatedAtlas.textureNames.count
        for var i=1; i<=numImages; i++ {
            let heroTextureName = "run\(i)"
            runFrames.append(heroAnimatedAtlas.textureNamed(heroTextureName))
        }
        
        heroRunningFrames = runFrames
        
        //CHANGES HERE
        let firstFrame = heroRunningFrames[0]
        hero = SKSpriteNode(texture: firstFrame)
        hero.position = CGPoint(x: -10, y: 100)
        hero.zPosition = 2
        hero.size = CGSizeMake(120, 120)
        hero.hidden = true
        hero.setScale(1.5)
        addChild(hero)
        
        //Create Villain
        
        
        
        
        
    }
    
    func changetext(string: String, string1: String, string2: String){
        text.text = string
        text1.text = string1
        text2.text = string2
        
        
    }
    
    //CHANGES HERE
    func changeanothertext(string: String, string1: String, string2: String, string3: String){
        text3.text = string
        text4.text = string1
        text5.text = string2
        text6.text = string3
        
        if counter == 5{
            text3.fontSize = 25
            text4.fontSize = 25
            text5.fontSize = 25
        }
    }
    
    
    
    
    
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //let location = touch.locationInNode(self)
        
        if counter == 0{
            changetext("Lets relate this to ", string1: "a minimal spanning tree!", string2: "")
            spanningTree.hidden = false
            
        }
        if counter == 1{
            changetext("A minimal spanning tree ", string1: "is a graph with edges", string2: "and nodes.")
            leftArrow.hidden = false
            leftArrowLabel.hidden = false
            leftArrowTwo.hidden = false
            leftArrowTwoLabel.hidden = false
        }
        if counter == 2{
            bubbletwo.hidden = false
            bubble.hidden = true
            leftArrow.hidden = true
            leftArrowLabel.hidden = true
            leftArrowTwo.hidden = true
            leftArrowTwoLabel.hidden = true
            spanningTree.position = CGPoint(x: size.width * 0.675, y: size.height * 0.7)
            rightArrow.hidden = false
            rightArrowLabel.hidden = false
            rightArrowTwo.hidden = false
            rightArrowTwoLabel.hidden = false
        }
        
        
        
        
        if counter == 3{
            changeanothertext("Finding this", string1: "tree means finding the", string2: "shortest path from the", string3: "start to the finish.")
            rightArrow.hidden = true
            rightArrowLabel.hidden = true
            rightArrowTwo.hidden = true
            rightArrowTwoLabel.hidden = true
            shortest.hidden = false
            spanningTree.hidden = true
            spanningTreeSolution.hidden = false
            
        }
        
        if counter == 4{
            changeanothertext("Try to analyze the", string1: "shortest distance from", string2: "intersection to" , string3: "intersection.")
        }
        
        if counter == 5{
            changeanothertext("Ready?", string1: "", string2: "Let's go!", string3: "")
            spanningTreeSolution.hidden = true
            shortest.hidden = true
        }
        
        if counter == 6{
            bubbletwo.hidden = true
            hero.hidden = false
            multiplierForDirection = -1.0
            let location = CGPoint(x: 500, y: 75)
            
            let heroVelocity = self.frame.size.width/2.5
            let moveDifference = CGPointMake(location.x - hero.position.x, location.y - hero.position.y)
            let  distanceToMove = sqrt(moveDifference.x * moveDifference.x + moveDifference.y * moveDifference.y)
            let moveDuration = distanceToMove / heroVelocity
            hero.xScale = fabs(hero.xScale) * multiplierForDirection
            
            if(hero.actionForKey("heroMoving") != nil){
                //stop just the moving to a new location, but leave the walking legs movemenet running
                hero.removeActionForKey("heroMoving")
            }
            
            if(hero.actionForKey("runningInPlaceHero") == nil){
                //if legs are not moving go ahead and start them
                runningHero()
            }
            
            let moveAction = (SKAction.moveTo(location, duration: (Double(moveDuration))))
            
            let doneAction = (SKAction.runBlock({
                print("Animation Completed")
                self.heroMoveEnded()
            }))
            let transitionAction = (SKAction.runBlock({
                //                let reveal = SKTransition.fadeWithDuration(0.5)
                //                let gameScene = GraphGameScene(size: self.size)
                //                self.view!.presentScene(gameScene, transition: reveal)
                self.viewController.presentChooseCar()
                
            }))
            let moveActionWithDone = (SKAction.sequence([moveAction, doneAction, transitionAction]))
            hero.runAction(moveActionWithDone, withKey: "heroMoving")
            
            
            
        }
        
        
        counter = counter + 1
        
    }
    
    func runningHero(){
        //This is our general runAction to make our hero run
        hero.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(heroRunningFrames, timePerFrame: 0.1, resize: false, restore: true)),
                       withKey: "runningInPlaceHero")
        
    }
    
    func heroMoveEnded(){
        hero.removeAllActions()
    }
    
    
    func transitionToNewScreen(){
        //        let reveal = SKTransition.fadeWithDuration(0.5)
        //        let gameScene = GraphGameScene(size: self.size)
        //        self.view!.presentScene(gameScene, transition: reveal)
        self.viewController.presentGame()
        
    }
    
    
}
