//
//  HeapAnimationScene2.swift
//  EducationGame
//
//  Created by John Kriston on 7/27/16.
//  Copyright © 2016 Abha Vedula. All rights reserved.
//

import SpriteKit

class HeapAnimationScene2: SKScene {
    
    var viewController: HeapViewController!
    
    
    // Layered Nodes
    
    var player: SKSpriteNode = SKSpriteNode(imageNamed: "player")
    var bubble: SKSpriteNode = SKSpriteNode(imageNamed: " SpeechBubble")
    var text: SKLabelNode = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    var text1: SKLabelNode = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    var text2: SKLabelNode = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    var bubbletwo: SKSpriteNode = SKSpriteNode(imageNamed: " SpeechBubble")
    var text3: SKLabelNode = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    var text4: SKLabelNode = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    var text5: SKLabelNode = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    var counter: Int = 0
    var tree: SKSpriteNode = SKSpriteNode(imageNamed: "tree")
    var leftArrow: SKSpriteNode = SKSpriteNode(imageNamed: "leftArrow")
    var leftArrowTwo: SKSpriteNode = SKSpriteNode(imageNamed: "leftArrow")
    var leftArrowLabel = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    var leftArrowTwoLabel =  SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    var rightArrow: SKSpriteNode = SKSpriteNode(imageNamed: "RightArrow")
    var rightArrowTwo: SKSpriteNode = SKSpriteNode(imageNamed: "RightArrow")
    var rightArrowLabel = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    var rightArrowTwoLabel =  SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    var rightText = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    var text6 = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    var leftText = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    
    var Levels = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    var zero =  SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    var one = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    var two = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    var three = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    var four = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    var five = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    var villain = SKSpriteNode(imageNamed: "villainStanding")
    
    var width: CGFloat!
    var height: CGFloat!
    
    var tree2: SKSpriteNode!
    
    // To Accommodate iPhone 6
    var scaleFactor: CGFloat!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(size: CGSize, viewController: HeapViewController) {
        super.init(size: size)
        self.viewController = viewController
        
        width = size.height
        height = size.width
        
        let background = SKSpriteNode(imageNamed: "stairs")
        background.size = CGSizeMake(width, height)
        background.position = CGPoint(x: width/2, y: height/2)
        background.zPosition = 0
        addChild(background)
        
        player = SKSpriteNode(imageNamed: "player")
        player.zPosition = 1
        player.size = CGSizeMake(150, 150)
        player.position = CGPoint(x: width * 0.51, y:height * 0.29)
        addChild(player)
        
        //CHANGES HERE
        bubble = SKSpriteNode(imageNamed: "SpeechBubble")
        bubble.size = CGSizeMake(180, 135.6)
        bubble.position = CGPoint(x: -110, y: 80)
        bubble.zPosition = 2
        bubble.hidden = false
        player.addChild(bubble)
        
        text = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        text.fontSize = 17
        text.zPosition = 3
        text.fontColor = SKColor.blackColor()
        text.position = CGPoint(x: -3, y: 15)
        text.text = "This kind of"
        bubble.addChild(text)
        
        text1 = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        text1.fontSize = 17
        text1.zPosition = 3
        text1.fontColor = SKColor.blackColor()
        text1.position = CGPoint(x: -3, y: -5)
        text1.text = "looks like a heap!"
        bubble.addChild(text1)
        
        text2 = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        text2.fontSize = 13
        text2.zPosition = 3
        text2.fontColor = SKColor.blackColor()
        text2.position = CGPoint(x: 5, y: -15)
        text2.text = ""
        bubble.addChild(text2)
        
        bubbletwo = SKSpriteNode(imageNamed: "bubble")
        bubbletwo.size = CGSizeMake(200, 200)
        bubbletwo.position = CGPoint(x: 87, y: 120 )
        bubbletwo.zPosition = 1
        bubbletwo.hidden = true
        player.addChild(bubbletwo)
        
        
        text3 = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        text3.fontSize = 15
        text3.zPosition = 2
        text3.fontColor = SKColor.blackColor()
        text3.position = CGPoint(x: 0, y: 30)
        text3.text = "Nodes that comes from other"
        bubbletwo.addChild(text3)
        
        text4 = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        text4.fontSize = 15
        text4.zPosition = 2
        text4.fontColor = SKColor.blackColor()
        text4.position = CGPoint(x: 0, y: 15)
        text4.text = "nodes are child nodes. The"
        bubbletwo.addChild(text4)
        
        text5 = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        text5.fontSize = 15
        text5.zPosition = 2
        text5.fontColor = SKColor.blackColor()
        text5.position = CGPoint(x: 5, y: 0)
        text5.text = "parent is the top node."
        bubbletwo.addChild(text5)
        
        text6.fontSize = 15
        text6.zPosition = 2
        text6.fontColor = SKColor.blackColor()
        text6.position = CGPoint(x: 5, y: -30)
        text6.hidden = true
        text6.text = "more than two levels."
        bubble.addChild(text6)
        
        tree = SKSpriteNode(imageNamed: "tree14")
        tree.size = CGSizeMake(220,220)
        tree.position = CGPoint(x: width * 0.75, y: height * 0.35)
        tree.zPosition = 1
        tree.hidden = true
        addChild(tree)
        
        leftArrow = SKSpriteNode(imageNamed: "leftArrow")
        leftArrow.size = CGSizeMake(25, 20)
        leftArrow.position = CGPoint(x: width * 0.8, y: height * 0.625)
        leftArrow.zPosition = 1
        leftArrow.hidden = true
        addChild(leftArrow)
        
        leftArrowTwo = SKSpriteNode(imageNamed: "leftArrow")
        leftArrowTwo.size = CGSizeMake(25, 20)
        leftArrowTwo.position = CGPoint(x: width * 0.85, y: height * 0.525)
        leftArrowTwo.zPosition = 1
        leftArrowTwo.hidden = true
        addChild(leftArrowTwo)
        
        leftArrowLabel = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        leftArrowLabel.fontSize = 12
        leftArrowLabel.zPosition = 1
        leftArrowLabel.fontColor = SKColor.whiteColor()
        leftArrowLabel.position = CGPoint(x: width * 0.855, y: height * 0.625)
        leftArrowLabel.text = "Node"
        leftArrowLabel.hidden = true
        addChild(leftArrowLabel)
        
        
        leftArrowTwoLabel = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        leftArrowTwoLabel.fontSize = 12
        leftArrowTwoLabel.zPosition = 1
        leftArrowTwoLabel.fontColor = SKColor.whiteColor()
        leftArrowTwoLabel.position = CGPoint(x: width * 0.9, y: height * 0.525)
        leftArrowTwoLabel.text = "Node"
        leftArrowTwoLabel.hidden = true
        addChild(leftArrowTwoLabel)
        
        rightArrow.size = CGSizeMake(25, 20)
        rightArrow.position = CGPoint(x: width * 0.665, y: height * 0.54)
        rightArrow.zPosition = 1
        rightArrow.hidden = true
        addChild(rightArrow)
        
        rightArrowTwo.size = CGSizeMake(25, 20)
        rightArrowTwo.position = CGPoint(x: width * 0.625, y: height * 0.42)
        rightArrowTwo.zPosition = 1
        rightArrowTwo.hidden = true
        addChild(rightArrowTwo)
        
        rightArrowLabel = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        rightArrowLabel.fontSize = 12
        rightArrowLabel.zPosition = 1
        rightArrowLabel.fontColor = SKColor.whiteColor()
        rightArrowLabel.position = CGPoint(x: width * 0.575, y: height * 0.54)
        rightArrowLabel.text = "Parent Node"
        rightArrowLabel.hidden = true
        addChild(rightArrowLabel)
        
        
        rightArrowTwoLabel = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        rightArrowTwoLabel.fontSize = 12
        rightArrowTwoLabel.zPosition = 1
        rightArrowTwoLabel.fontColor = SKColor.whiteColor()
        rightArrowTwoLabel.position = CGPoint(x: width * 0.55, y: height * 0.42)
        rightArrowTwoLabel.text = "Child Node"
        rightArrowTwoLabel.hidden = true
        addChild(rightArrowTwoLabel)
        
        leftText = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        leftText.fontSize = 12
        leftText.zPosition = 1
        leftText.fontColor = SKColor.whiteColor()
        leftText.position = CGPoint(x: width * 0.975, y: height * 0.36)
        leftText.text = ""
        leftText.hidden = true
        addChild(leftText)
        
        Levels.fontSize = 20
        Levels.zPosition = 1
        Levels.fontColor = SKColor.orangeColor()
        Levels.position = CGPoint(x: width * 0.925, y: height * 0.7)
        Levels.text = "Levels"
        Levels.hidden = true
        addChild(Levels)
        
        zero.fontSize = 20
        zero.zPosition = 1
        zero.fontColor = SKColor.greenColor()
        zero.position = CGPoint(x: width * 0.95, y: height * 0.595)
        zero.text = "0"
        zero.hidden = true
        addChild(zero)
        
        one.fontSize = 20
        one.zPosition = 1
        one.fontColor = SKColor.yellowColor()
        one.position = CGPoint(x: width * 0.95, y: height * 0.51)
        one.text = "1"
        one.hidden = true
        addChild(one)
        
        two.fontSize = 20
        two.zPosition = 1
        two.fontColor = SKColor.redColor()
        two.position = CGPoint(x: width * 0.95, y: height * 0.4)
        two.text = "2"
        two.hidden = true
        addChild(two)
        
        three.fontSize = 20
        three.zPosition = 1
        three.fontColor = SKColor.greenColor()
        three.position = CGPoint(x: width * 0.95, y: height * 0.285)
        three.text = "3"
        three.hidden = true
        addChild(three)
        
        four.fontSize = 20
        four.zPosition = 1
        four.fontColor = SKColor.yellowColor()
        four.position = CGPoint(x: width * 0.95, y: height * 0.17)
        four.text = "4"
        four.hidden = true
        addChild(four)
        
        five.fontSize = 20
        five.zPosition = 1
        five.fontColor = SKColor.redColor()
        five.position = CGPoint(x: width * 0.95, y: height * 0.0805)
        five.text = "5"
        five.hidden = true
        addChild(five)
        
        //CHANGES HERE
        villain.position = CGPoint(x: width * 0.05, y: height * 0.1)
        villain.zPosition = 1
        villain.setScale(2)
        villain.hidden = true
        addChild(villain)
    }
    
    
    func changetext(string: String, string1: String, string2: String){
        text.text = string
        text1.text = string1
        text2.text = string2
    }
    
    func changeanothertext(string: String, string1: String, string2: String){
        text3.text = string
        text4.text = string1
        text5.text = string2
    }
    
    //CHANGES HERE
    func createSpeechBubble(arr: [String], xPos: Int, font: CGFloat) {
        bubble.removeFromParent()
        bubble = SKSpriteNode(imageNamed: "SpeechBubble")
        bubble.size = CGSizeMake(220, 140)
        bubble.position = CGPoint(x: -140, y: 90)
        bubble.zPosition = 2
        bubble.hidden = false
        player.addChild(bubble)
        
        
        for i in 0..<arr.count {
            let label = SKLabelNode(text: arr[i])
            label.zPosition = bubble.zPosition + 1
            label.fontColor = UIColor.blackColor()
            label.fontName = "ChalkboardSE-Bold"
            label.fontSize = font
            label.position = CGPoint(x: -4, y: CGFloat(xPos - Int(font) * i))
            bubble.addChild(label)
            
        }
    }
    
    
    //CHANGES HERE
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //let location = touch.locationInNode(self)
        
        if counter == 0{
            changetext("A heap is a ", string1: "a type of tree.", string2: "")
            
        }
        if counter == 1{
            //bubble.size = CGSizeMake(230, 230)
            //bubble.position = CGPoint(x: -140, y: 130)
            //changetext("Trees, in computer science,", string1: "have nodes. Here, nodes are", string2: "represented by numbers.")
            text.hidden = true
            text1.hidden = true
            text2.hidden = true
            createSpeechBubble(["A tree is a", "collection of nodes.", "Nodes have values. Here,", "they're numbers."], xPos: 30, font: 15)
            
            tree.hidden = false
            leftArrow.hidden = false
            leftArrowTwo.hidden = false
            leftArrowLabel.hidden = false
            leftArrowTwoLabel.hidden = false
            
        }
        if counter == 2{
            //changetext("The root node is the node", string1: "at the very top of the", string2: "tree.")
            leftArrowTwo.hidden = true
            leftArrowTwoLabel.hidden = true
            leftArrowLabel.text = "Root Node"
            leftArrowLabel.position = CGPoint(x: width * 0.890, y: height * 0.6)
            
            createSpeechBubble(["The root is the", "node at the very", "top of the", "tree."], xPos: 20, font: 15)
            
        }
        if counter == 3{
            //changetext("Nodes that come from other", string1: "nodes are child nodes. The", string2: "parent is the top node.")
            leftArrow.hidden = true
            leftArrowLabel.hidden = true
            rightArrow.hidden = false
            rightArrowLabel.hidden = false
            rightArrowTwo.hidden = false
            rightArrowTwoLabel.hidden = false
            
            createSpeechBubble(["Nodes that come", "from other nodes are", "child nodes. The parent", "is the top node."], xPos: 20, font: 15)
            
        }
        if counter == 4{
            //changetext("Each side of this tree is", string1: "called a subtree.", string2: "")
            createSpeechBubble(["Each side of this tree", "is called a subtree."], xPos: 10, font: 15)
            rightArrowTwo.hidden = true
            rightArrowTwoLabel.hidden = true
            rightArrowLabel.text = "Left Subtree"
            leftArrow.hidden = false
            leftArrow.position = CGPoint(x: width * 0.84, y: height * 0.54)
            leftArrowLabel.hidden = false
            leftArrowLabel.text = "Right Subtree"
            leftArrowLabel.position = CGPoint(x: width * 0.94, y: height * 0.54)
        }
        if counter == 5{
            //changetext("Your job? To make sure", string1: "the left subtree and right", string2: "subtree don't differ by")
            createSpeechBubble(["Your job? To make", "sure the left and right", "subtrees don't differ by", "more than two levels."], xPos: 30, font: 15)
            rightArrow.hidden = true
            rightArrowLabel.hidden = true
            leftArrow.hidden = true
            leftArrowLabel.hidden = true
            //text6.hidden = false
            Levels.hidden = false
            zero.hidden = false
            one.hidden = false
            two.hidden = false
            three.hidden = false
            four.hidden = false
            five.hidden = false
        }
        if counter == 6{
            //text6.hidden = true
            //changetext("In other words, the heights", string1: "(amount of levels on each", string2: "side), are relatively similar.")
            createSpeechBubble(["If they do, I will fall", "off the top of the tree", "and never make it up." ], xPos: 15, font: 15)
        }
        if counter == 7{
            //changetext("If not, I will fall off", string1: "the top of the tree", string2: "and never make it up.")
            createSpeechBubble(["You can use buttons to", "rotate the tree."], xPos: 10, font: 15)
        }
        if counter == 8{
            createSpeechBubble(["A right rotation (R)", "should be used when a", "node is inserted in the", "left subtree of", "a left subtree."], xPos: 30, font: 15)
            tree2 = SKSpriteNode(imageNamed: "r")
            tree2.position = CGPoint(x: 180, y: 135)
            tree2.setScale(0.6)
            addChild(tree2)
        }
        if counter == 9{
            createSpeechBubble(["A left rotation (L)", "should be used when a", "node is inserted in the", "right subtree of", "a right subtree."], xPos: 30, font: 15)
            tree2.removeFromParent()
            tree2 = SKSpriteNode(imageNamed: "l")
            tree2.position = CGPoint(x: 180, y: 135)
            tree2.setScale(0.6)
            addChild(tree2) // fine
        }
        if counter == 10{
            createSpeechBubble(["A left-right rotation", "(LR) is a left rotation", "followed by a right", "rotation."], xPos: 25, font: 15)
            tree2.removeFromParent()
        }
        if counter == 11{
            createSpeechBubble(["It should be used", "when a node is inserted", "in the left subtree of", "a right subtree."], xPos: 20, font: 15)
            
            tree2 = SKSpriteNode(imageNamed: "lr")
            tree2.position = CGPoint(x: 180, y: 135)
            tree2.setScale(0.6)
            addChild(tree2) // fine
        }
        if counter == 12{
            createSpeechBubble(["And as you may have", "already guessed, a right-", "left rotation (RL) is", "used in the opposite", "case."], xPos: 25, font: 15)
            tree2.removeFromParent()
            tree2 = SKSpriteNode(imageNamed: "rl")
            tree2.position = CGPoint(x: 180, y: 135)
            tree2.setScale(0.6)
            addChild(tree2)
        }
        if counter == 13{
            tree2.removeFromParent()
            //changetext("Here he comes!", string1: "Let's do this!", string2: "")
            createSpeechBubble(["Here he comes!", "Let's do this!" ], xPos: 10, font: 20)
            
            Levels.hidden = true
            zero.hidden = true
            one.hidden = true
            two.hidden = true
            three.hidden = true
            four.hidden = true
            five.hidden = true
            villain.hidden = false
            
            
            //CHANGES HERE
            
            let villainLocation = CGPoint(x: width * 0.35, y:height * 0.1)
            let villainAction = (SKAction.moveTo(villainLocation, duration: (Double(1.8))))
            let transitionAction = SKAction.runBlock({
                self.viewController.currScene = self.viewController.heapScene
                self.viewController.unrotate()
                self.viewController.presentGame()
            })
            let wait = SKAction.waitForDuration(2)
            
            let action = (SKAction.sequence([villainAction, wait, transitionAction]))
            villain.runAction(action)
            
        }
        counter = counter + 1
    }
}
