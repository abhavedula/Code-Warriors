//
//  CongratulationsScene.swift
//  CarGame
//
//  Created by John Kriston on 7/13/16.
//  Copyright © 2016 John Kriston. All rights reserved.
//

import SpriteKit

class CongratulationsScene: SKScene {
    var viewController: GraphViewController!
    var hero: SKSpriteNode!
    var heroRunningFrames : [SKTexture]!
    var multiplierForDirection: CGFloat = 1.0
    var villainDirection: CGFloat = 1.0
    var bubble: SKSpriteNode = SKSpriteNode(imageNamed: "SpeechBubble")
    var text: SKLabelNode = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    var text1: SKLabelNode = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    var text2: SKLabelNode = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    var villain : SKSpriteNode!
    var villainWalkingFrames : [SKTexture]!
    var time = 0
    var bubbletwo: SKSpriteNode = SKSpriteNode(imageNamed: "SpeechBubble")
    var text3: SKLabelNode = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    var badWalkingFrames : [SKTexture]!
    var bad : SKSpriteNode!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    

    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(size: CGSize, viewController: GraphViewController) {
        super.init(size: size)
        self.viewController = viewController

        backgroundColor = SKColor.blackColor()
        
        let background = SKSpriteNode(imageNamed: "sky")
        background.size = CGSizeMake(size.width, size.height)
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.zPosition = 0
        addChild(background)
        
        let dungeon = SKSpriteNode(imageNamed: "outside")
        dungeon.size = CGSizeMake(800, 800)
        dungeon.position = CGPoint(x: 300, y: -20)
        dungeon.zPosition = 5
        addChild(dungeon)
        
        let heroAnimatedAtlas = SKTextureAtlas(named: "playerImages2")
        var runFrames = [SKTexture]()
        
        let numImages = heroAnimatedAtlas.textureNames.count
        for var i=1; i<=numImages; i++ {
            let heroTextureName = "run\(i)"
            runFrames.append(heroAnimatedAtlas.textureNamed(heroTextureName))
        }
        
        heroRunningFrames = runFrames
        
        let firstFrame = heroRunningFrames[0]
        hero = SKSpriteNode(texture: firstFrame)
        hero.position = CGPoint(x: 100, y: 120)
        hero.zPosition = 1
        hero.size = CGSizeMake(120, 120)
        addChild(hero)
        
        
        bubble.size = CGSizeMake(120,120)
        bubble.position = CGPoint(x: -20, y: 75)
        bubble.zPosition = 1
        hero.addChild(bubble)
        
        text.fontSize = 13
        text.zPosition = 2
        text.fontColor = SKColor.blackColor()
        text.position = CGPoint(x: 0, y: 15)
        text.text = "Yes!"
        bubble.addChild(text)
        
        text1.fontSize = 13
        text1.zPosition = 2
        text1.fontColor = SKColor.blackColor()
        text1.position = CGPoint(x: 0, y: 0)
        text1.text = "We made it"
        bubble.addChild(text1)
        
        text2.fontSize = 13
        text2.zPosition = 2
        text2.fontColor = SKColor.blackColor()
        text2.position = CGPoint(x: 0, y: -15)
        text2.text = "out!"
        bubble.addChild(text2)
        
        //create villain walking
        let villainAnimatedAtlas = SKTextureAtlas(named: "villainThrowing2")
        var walkFrames = [SKTexture]()
        
        let num = 1
        //let num = villainAnimatedAtlas.textureNames.count
        for var j=1; j<=num; j++ {
            let villainTextureName = "villain\(j)"
            walkFrames.append(villainAnimatedAtlas.textureNamed(villainTextureName))
        }
        
        villainWalkingFrames = walkFrames
        
        let Frame = villainWalkingFrames[0]
        villain = SKSpriteNode(texture: Frame)
        villain.position = CGPoint(x: 150, y: 90)
        villain.zPosition = 1
        villain.size = CGSizeMake(120, 120)
        addChild(villain)
        
        bubbletwo.size = CGSizeMake(120,120)
        bubbletwo.position = CGPoint(x: -60, y: 105)
        bubbletwo.zPosition = 1
        villain.addChild(bubbletwo)
        
        text3.fontSize = 13
        text3.zPosition = 2
        text3.fontColor = SKColor.blackColor()
        text3.position = CGPoint(x: 0, y: 5)
        text3.text = "NOOOOOOO!"
        bubbletwo.addChild(text3)
        
        //create villain falling
        let badAnimatedAtlas = SKTextureAtlas(named: "villainFalling")
        var badFrames = [SKTexture]()
        
        let images = badAnimatedAtlas.textureNames.count
        for var k=1; k<=images; k++ {
            let badTextureName = "falls\(k)"
            badFrames.append(badAnimatedAtlas.textureNamed(badTextureName))
        }
        
        badWalkingFrames = badFrames
        
        let yes = villainWalkingFrames[0]
        
        
        
        
        multiplierForDirection = 1.0
        villainDirection = 1.0
        
        let location = CGPoint(x: 625, y: 120)
        let villainLocation = CGPoint(x: 400, y: 90)
        
        let heroVelocity = self.frame.size.width / 3.0
        let villainVelocity = self.frame.size.width / 6.0
        
        
        let moveDifference = CGPointMake(location.x - hero.position.x, location.y - hero.position.y)
        let villainDifference = CGPointMake(villainLocation.x - villain.position.x, villainLocation.y - villain.position.y)
        let distanceToMove = sqrt(moveDifference.x * moveDifference.x + moveDifference.y * moveDifference.y)
        let villainDistance = sqrt(villainDifference.x * villainDifference.x + villainDifference.y * villainDifference.y)
        
        
        let moveDuration = distanceToMove / heroVelocity
        let villainDuration = villainDistance / villainVelocity
        
        hero.xScale = fabs(hero.xScale) * multiplierForDirection
        villain.xScale = fabs(villain.xScale) * villainDirection
        
        if (hero.actionForKey("heroMoving") != nil) {
            //stop just the moving to a new location, but leave the walking legs movement running
            hero.removeActionForKey("heroMoving")
        }
        
        if(hero.actionForKey("runningInPlaceHero") == nil) {
            //if legs are not moving go ahead and start them
            runningHero()
        }
        
        if(villain.actionForKey("villainMoving") != nil) {
            //stop just the moving to a new location, but leave the walking legs movement running
            villain.removeActionForKey("villainMoving")
        }
        
        if(villain.actionForKey("walkingInPlaceVillain") == nil) {
            //if legs are not moving go ahead and start them
            walkingVillain()
        }
        
        
        let moveAction = (SKAction.moveTo(location, duration: (Double(moveDuration))))
        
        let villainAction = (SKAction.moveTo(villainLocation, duration: (Double(villainDuration))))
        
        let doneAction = (SKAction.runBlock({
            self.heroMoveEnded()
            self.time = 1
        }))
        let doneVillain = (SKAction.runBlock({
            self.villainMoveEnded()
        }))
        let waitAction = (SKAction.waitForDuration(2))
        
        let fallAction = (SKAction.runBlock({
            self.fallingVillain()
        }))
        
        let scoreAction = (SKAction.runBlock({
            self.showScore()
        }))
        
        let wait = SKAction.waitForDuration(2)
        

        let moveActionWithDone = (SKAction.sequence([moveAction, doneAction]))
        hero.runAction(moveActionWithDone, withKey: "heroMoving")
        
        let action = (SKAction.sequence([waitAction, villainAction, doneVillain, wait, scoreAction]))
        villain.runAction(action)
        
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func heroMoveEnded(){
        hero.removeAllActions()
    }
    
    func villainMoveEnded(){
        villain.removeAllActions()
    }
    
    func walkingVillain(){
        //This is our runAction method for villain
        villain.runAction(SKAction.repeatActionForever(
            SKAction.animateWithTextures(villainWalkingFrames,
                timePerFrame: 0.3,
                resize: false,
                restore: true)),
                          withKey: "walkingInPlaceVillain")
    }
    
    func fallingVillain(){
        bad.runAction(SKAction.repeatAction(SKAction.animateWithTextures(badWalkingFrames, timePerFrame: 0.05), count: 1))
    }
    
    
    
    func runningHero(){
        //general runAction for hero
        hero.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(heroRunningFrames, timePerFrame: 0.1, resize: false, restore: true)), withKey: "runningInPlaceHero")
    }
    
    //CHANGES HERE
    func showScore() {
        defaults.setBool(true, forKey: "justPlayedGraph")
        print(defaults.boolForKey("justPlayedGraph"))
        self.viewController.score()
    }
    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?){
        //get location of last touch
        //let loc = touches[touches.endIndex].locationInNode(self)
        //if go.containsPoint(loc)
        
        for touch: AnyObject in touches{
            //Get the location of the touch in this scene
            
            showScore()
        }
    
    
    }


}
