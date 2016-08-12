//
//  GameScene.swift
//  Maze 3
//
//  Created by Abha Vedula on 7/5/16.
//  Copyright © 2016 Abha Vedula. All rights reserved.
//

import UIKit
import SpriteKit

private let block = "movable"


extension SKNode {
    
    func getIsInBox(box: SKShapeNode) -> Bool {
        return box.containsPoint(self.position)
    }
}


class MazeGameScene: SKScene, SKPhysicsContactDelegate {
    
    var width: CGFloat!
    var height: CGFloat!
    
    var firstRepeat: Bool = true
    var firstIf: Bool = true
    var firstElse: Bool = true
    
    var monsterCollide: SKSpriteNode!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var player: SKSpriteNode!
    
    var viewController: MazeViewController!
    
    var arr: [String] = []
    
    var index: Int = 0
    
    var monster: SKSpriteNode!
    
    var portalEnter: SKSpriteNode!
    
    var portalEnd: SKSpriteNode!
    
    var isPortal: Bool!
    var ignoreCollision: Bool = false
    
    var hole: SKSpriteNode!
    var ignoreHole: Bool = false
    
    var numBlocksinBox = 0
    
    var timer: SKLabelNode!
    
    var ifStarted = false
    var elseStarted = false
    
    var timeSecond = 0
    var timeMin = 0
    
    var points = 0
    var pointsHigh = 0
    
    var moveSequence = SKAction.waitForDuration(1)
    
    var go: SKNode!
    var reset: SKNode!
    var clear: SKNode!
    
    var box: SKShapeNode!
    
    var bool: Bool = false
    
    let oneMove: CGFloat = 14.4
    let jumpMove: CGFloat = 14.4 * 2
    
    var moves: [String] = []
    var movesBeforeReset: [String] = []
    var movesBlocks: [SKNode] = []
    
    var numTimes: [Int] = []
    var numTimesBeforeReset: [Int] = []
    
    var instr: [SKNode] = []
    
    var rep: SKNode!
    
    var trash: SKSpriteNode!
    
    var selectedNode = SKSpriteNode()
    
    var helpBox: SKShapeNode!
    
    var dir: Int!
    
    var playerStart = CGPoint(x: 338.4, y: 338.4)
    //var playerStart = CGPoint(x: 28.8, y: 28.8)
    // var playerStart = CGPoint(x: 65.3, y: 65.3)
    //var playerStart = CGPoint(x: 309.6, y: 324)
    
    let move: SKAction = SKAction.moveToX(6.7, duration: 1)
    let moveBack: SKAction = SKAction.moveToX(21.1, duration: 1)
    let wait: SKAction = SKAction.waitForDuration(5)
    let wait2: SKAction = SKAction.waitForDuration(7)
    var sequence: SKAction!
    
    let imageNames = ["down", "up", "left", "right", "repeat", "end", "2", "3", "4", "5", "if", "else", "is ghost", "wait", "is portal", "jump"]
    
    let playerCategory : UInt32 = 0x1 << 0
    let wallCategory : UInt32 = 0x1 << 1
    let ghostCategory: UInt32 = 0x1 << 2
    let portalCategory: UInt32 = 0x1 << 3
    let exitCategory: UInt32 = 0x1 << 4
    let portalEndCategory: UInt32 = 0x1 << 6
    
    init(size: CGSize, viewController: MazeViewController) {
        super.init(size: size)
        
        self.viewController = viewController
        
        if viewController.noAnimation {
            width = size.width
            height = size.height
            
            
        } else {
            width = size.height
            height = size.width
            
        }
   
        
        sequence = SKAction.sequence([move, wait2, moveBack, wait])
        
        
        go = SKSpriteNode(imageNamed: "run")
        go.position = CGPoint(x: 110, y: height * 0.53 + 2)
        go.setScale(0.6)
        go.name = "run"
        
        
        reset = SKSpriteNode(imageNamed: "reset")
        reset.position = CGPoint(x: 160, y: (height * 0.53 + 2))
        reset.setScale(0.6)
        reset.name = "reset"
        reset.hidden = true
        
        clear = SKSpriteNode(imageNamed: "clear")
        clear.position = CGPoint(x: 210, y: (height * 0.53 + 3))
        clear.setScale(0.8)
        clear.zPosition = 10
        clear.name = "clear"
        self.addChild(clear)
        
        
        print(size.width)
        print(size.height)
        
        for i in 0..<imageNames.count {
            let imageName = imageNames[i]
            
            
            let label = SKLabelNode(text: imageName)
            label.fontSize = 25
            label.zPosition = 3
            label.position = CGPoint(x: 0, y: -5)
            label.fontName = "ChalkboardSE-Bold"
            
            let sprite = SKSpriteNode(imageNamed: "redBox")
            sprite.yScale = 0.6
            sprite.xScale = 0.7
            sprite.name = block
            sprite.zPosition = 2
            
            instr.append(sprite)
            
            sprite.position = CGPoint(x: width - 54, y: (height - 25) - 23 * CGFloat(i))
            
            if i > 5 && i < 10 {
                sprite.position = CGPoint(x: width - 84 + (20 * (CGFloat(i) - 6)), y: (height - 25) - 23 * 6)
                sprite.yScale = 0.6
                sprite.xScale = 0.2
                label.xScale = 3
            }
            
            if i > 9 {
                sprite.position = CGPoint(x: width - 54, y: (height - 25) - 23 * CGFloat(i - 3))
            }
            self.addChild(sprite)
            sprite.addChild(label)
            
        }
        
        
        addChild(go)
        addChild(reset)
    }
    
    func addBlocks(i: Int) {
        
        let imageName = imageNames[i]
        
        let label = SKLabelNode(text: imageName)
        label.fontSize = 25
        label.zPosition = 3
        label.position = CGPoint(x: 0, y: -5)
        label.fontName = "ChalkboardSE-Bold"
        
        let sprite = SKSpriteNode(imageNamed: "redBox")
        sprite.yScale = 0.6
        sprite.xScale = 0.7
        sprite.name = block
        sprite.zPosition = 2
        
        instr[i] = sprite
        sprite.position = CGPoint(x: 0, y: 0)
        
        sprite.position = CGPoint(x: width - 54, y: (height - 25) - 23 * CGFloat(i))
        
        if i > 5 && i < 10 {
            sprite.position = CGPoint(x: width - 84 + (20 * (CGFloat(i) - 6)), y: (height - 25) - 23 * 6)
            sprite.yScale = 0.6
            sprite.xScale = 0.2
            label.xScale = 3
        }
        
        if i > 9 {
            sprite.position = CGPoint(x: width - 54, y: (height - 25) - 23 * CGFloat(i - 3))
        }
        
        self.addChild(sprite)
        sprite.addChild(label)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            let positionInScene = touch.locationInNode(self)
            for sprite in instr {
                if sprite.containsPoint(positionInScene) {
                    selectNodeForTouch(positionInScene)
                }
            }
            for sprite in movesBlocks {
                if sprite.containsPoint(positionInScene) {
                    selectNodeForTouch(positionInScene)
                }
            }
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMoveToView(view: SKView) {
        print("maze game")
        backgroundColor = UIColor.blackColor()
        physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
        
        loadMaze()
        
        player = SKSpriteNode(imageNamed: "mazePlayer")
        player.size = CGSizeMake(12, 12)
        
        player.position = playerStart
        player.zPosition = 4
        
        player.name = "player"
        
        player.physicsBody = SKPhysicsBody(rectangleOfSize: player.size)
        player.physicsBody?.dynamic = true
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.categoryBitMask = playerCategory
        player.physicsBody?.contactTestBitMask = wallCategory | ghostCategory | portalCategory
        player.physicsBody?.collisionBitMask = wallCategory | ghostCategory | portalCategory
        player.physicsBody?.usesPreciseCollisionDetection = true
        
        
        addChild(player)
        
        box = SKShapeNode(rect: CGRect(x: 10, y: 368, width: 250, height: 283))
        box.fillColor = UIColor.blackColor()
        
        self.addChild(box)
        
        helpBox = SKShapeNode(rect: CGRect(x: 2, y: 285, width: size.width - 3, height: 100))
        helpBox.fillColor = UIColor.blackColor()
        helpBox.zPosition = 10
        
        startTimer()
        
        
        monster.runAction(SKAction.repeatActionForever(sequence))
        
        hole = SKSpriteNode(imageNamed: "hole")
        hole.position = portalEnter.position
        hole.setScale(0.6)
        
        
        let changeToHole = SKAction.runBlock({
            
            self.portalEnter.removeFromParent()
            self.portalEnd.removeFromParent()
            self.addChild(self.hole)
            self.isPortal = false
            
        })
        
        let changeToPortal = SKAction.runBlock({
            
            self.hole.removeFromParent()
            self.addChild(self.portalEnd)
            self.addChild(self.portalEnter)
            self.isPortal = true
            
            
        })
        
        let wait3 = SKAction.waitForDuration(10)
        let wait4 = SKAction.waitForDuration(2)
        
        let sequence2: SKAction = SKAction.sequence([wait4, changeToHole, wait3, changeToPortal, wait4])
        timer.runAction(SKAction.repeatActionForever(sequence2))
        
        trash = SKSpriteNode(imageNamed: "trash2")
        trash.position = CGPoint(x: 247, y: (height * 0.53 + 35))
        trash.setScale(0.02)
        trash.zPosition = 10
        addChild(trash)
        
    }
    
    func startTimer() {
        timer = SKLabelNode(text: "time")
        timer.fontSize = 18
        timer.fontName = "ChalkboardSE-Bold"
        timer.position = CGPoint(x: 33, y: height * 0.53 - 3)
        
        self.addChild(timer)
        
        let actionwait = SKAction.waitForDuration(1)
        
        let actionrun = SKAction.runBlock({
            self.timeSecond += 1
            if self.timeSecond == 60 {
                self.timeSecond = 0
                self.timeMin += 1
            }
            self.timer.text = "\(self.timeMin):\(self.timeSecond)"
            if self.timeSecond < 10 {
                self.timer.text = "\(self.timeMin):0\(self.timeSecond)"
            }
            if self.timeMin < 10 {
                self.timer.text = "0\(self.timeMin):\(self.timeSecond)"
            }
            if self.timeSecond < 10 && self.timeMin < 10 {
                self.timer.text = "0\(self.timeMin):0\(self.timeSecond)"
            }
        })
        timer.runAction(SKAction.repeatActionForever(SKAction.sequence([actionwait,actionrun])), withKey: "timer")
    }
    
    
    func help(arr: [String], xPos: Int) {
        for i in 0..<arr.count {
            let label = SKLabelNode(text: arr[i])
            label.zPosition = helpBox.zPosition + 1
            label.fontColor = UIColor.whiteColor()
            label.fontName = "ChalkboardSE-Bold"
            label.fontSize = 18
            label.position = CGPoint(x: 190, y: CGFloat(xPos - 20 * i))
            helpBox.addChild(label)
            
        }
        self.addChild(helpBox)
        
        
    }
    
    var blank = -1
    
    func blockTouched(name: String, num: Int, position: Int, location: CGPoint) {
        //let node = nodeAtPoint(location)
        
        var node = nodeAtPoint(location)
        for n in instr {
            if n.containsPoint(location) {
                node = n as! SKSpriteNode
            }
            
        }
        for n in movesBlocks {
            if n.containsPoint(location) {
                node = n as! SKSpriteNode
            }
        }
        
        if box.containsPoint(location) {
            var x: CGFloat
            var y: CGFloat
            if position > 27 {
                x = 185
                y = CGFloat(position) - 28
            } else {
                x = 65
                y = CGFloat(position)
            }
            if ifStarted {
                let count = moves.count
                print(count)
                print(moves)
                moves[count - 1] = moves[count - 1] + "," + name
                //numTimes.append(1)
                movesBlocks.append(node)
                instr[num].yScale = 0.4
                instr[num].position = CGPoint(x: x, y: size.height - 22 - 10 * CGFloat(y))
                numBlocksinBox += 1
                addBlocks(num)
                blank += 1
            }
            else if elseStarted {
                let count = moves.count
                moves[count - 1] = moves[count - 1] + "," + name
                //numTimes.append(1)
                movesBlocks.append(node)
                instr[num].yScale = 0.4
                instr[num].position = CGPoint(x: x, y: size.height - 22 - 10 * CGFloat(y))
                numBlocksinBox += 1
                addBlocks(num)
                blank += 1
            }
            else {
                moves.append(name)
                movesBlocks.append(node)
                print(moves)
                print(node.getIsInBox(box))
                numTimes.append(1)
                instr[num].yScale = 0.4
                instr[num].position = CGPoint(x: x, y: size.height - 22 - 10 * CGFloat(y))
                numBlocksinBox += 1
                addBlocks(num)
            }
        } else {
            numBlocksinBox -= 1
        }
        
        
    }
    
    func checkCondition(bool: Bool) {
        if moves[index - 1] == "if" && !bool {
            print("there is no ghost")
            
            // go to else
            
            //            while index < moves.count {
            //                if moves[index] == "else" {
            //                    index -= 1
            //                    break
            //                }
            //                else {
            //                    index += 1
            //                }
            //            }
            //            arr = moves[index + 1].componentsSeparatedByString(",")
            //            print(moves[index + 1])
            //            //moves.removeAtIndex(index + 1)
            //            for i in 2..<arr.count {
            //                //moves.insert(arr[i], atIndex: index + i - 1)
            //                moves[index + i - 1] = arr[i]
            //            }
            
            //arr = []
            
            print(moves)
            
        } else if moves[index - 1] == "if" && bool {
            // do if
            print("there is ghost/portal")
            //            for i in 3..<arr.count {
            //                moves.insert(arr[i], atIndex: index + i)
            //            }
            //arr = []
            print(arr)
            
            for i in 3..<arr.count {
                moves.insert(arr[i], atIndex: index + i - 2)
                numTimes.insert(1, atIndex: index + i - 2)
                //moves[index + i - 2] = arr[i]
                //numTimes[index + i - 2] = 1
            }
            
        }
        
    }
    
    func blockTouchedAgain(location: CGPoint) {
        let node = nodeAtPoint(location)
        print("in box: \(node.getIsInBox(box))")
        
    }
    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //print("touches ended")
        let t = touches.first
        let location = t!.locationInNode(self)
        print(location)
        
        for touch: UITouch in touches {
            // Get the location of the touch in this scene
            let location = touch.locationInNode(self)
            
            blockTouchedAgain(location)
            
            // Check if the location of the touch is within the button's bounds
            if instr[0].containsPoint(location) {
                blockTouched("d", num: 0, position: numBlocksinBox, location: location)
                
            } else if instr[1].containsPoint(location) {
                blockTouched("u", num: 1, position: numBlocksinBox, location: location)
                
            } else if instr[2].containsPoint(location) {
                blockTouched("l", num: 2, position: numBlocksinBox, location: location)
                
            } else if instr[3].containsPoint(location) {
                blockTouched("r", num: 3, position: numBlocksinBox, location: location)
                
            } else if instr[4].containsPoint(location) {
                blockTouched("repeat", num: 4, position: numBlocksinBox, location: location)
                if firstRepeat {
                    help(["If you want to repeat certain", "actions, place the 'repeat' block", "followed by the number of times", "to repeat, the actions to be", "repeated, and finally the 'end' block"], xPos: 370)
                    firstRepeat = false
                }
                
            } else if instr[5].containsPoint(location) {
                ifStarted = false
                elseStarted = false
                //                while blank > 0 {
                //                    moves.append("x")
                //                    blank -= 1
                //                }
                blockTouched("end", num: 5, position: numBlocksinBox, location: location)
                
                
                
            } else if instr[6].containsPoint(location) {
                blockTouched("2", num: 6, position: numBlocksinBox, location: location)
                
            } else if instr[7].containsPoint(location) {
                blockTouched("3", num: 7, position: numBlocksinBox, location: location)
                
            } else if instr[8].containsPoint(location) {
                blockTouched("4", num: 8, position: numBlocksinBox, location: location)
                
            } else if instr[9].containsPoint(location) {
                blockTouched("5", num: 9, position: numBlocksinBox, location: location)
                
            } else if instr[10].containsPoint(location) {
                if firstIf {
                    help(["If you want some actions to only be", "executed when something is true, add the", "'if' block, followed by what actions", "should be executed and the 'end' block"], xPos: 360)
                    firstIf = false
                }
                let name = "if"
                let num = 10
                let position = numBlocksinBox
                var node = nodeAtPoint(location)
                for n in instr {
                    if n.containsPoint(location) {
                        node = n as! SKSpriteNode
                    }
                    
                }
                for n in movesBlocks {
                    if n.containsPoint(location) {
                        node = n as! SKSpriteNode
                    }
                }
                
                if box.containsPoint(location) {
                    print("hereee")
                    numTimes.append(1)
                    var x: CGFloat
                    var y: CGFloat
                    if position > 27 {
                        x = 185
                        y = CGFloat(position) - 28
                    } else {
                        x = 65
                        y = CGFloat(position)
                    }
                    
                    
                    if ifStarted {
                        let count = moves.count
                        moves[count - 1] = moves[count - 1] + name + ","
                        numTimes[count - 1] = 1
                        print(numTimes)
                        movesBlocks.append(node)
                        instr[num].yScale = 0.4
                        instr[num].position = CGPoint(x: x, y: size.height - 22 - 10 * CGFloat(y))
                        numBlocksinBox += 1
                        addBlocks(num)
                    }
                        
                    else {
                        print("now Here")
                        moves.append(name)
                        moves.append(",")
                        numTimes.append(1)
                        print(numTimes)
                        movesBlocks.append(node)
                        instr[num].yScale = 0.4
                        instr[num].position = CGPoint(x: x, y: size.height - 22 - 10 * CGFloat(y))
                        numBlocksinBox += 1
                        addBlocks(num)
                    }
                } else {
                    numBlocksinBox -= 1
                }
                ifStarted = true
                blank = -1
                
                
                
            } else if instr[11].containsPoint(location) {
                if moves.last != "end" {
                    
                    help(["Make sure you add the 'end' block", "once you've added all", "the actions that should be executed", "if the condition is met."], xPos: 350)
                }
                numTimes.append(1)
                
                if firstElse {
                 
                    help(["If you want some actions to only be", "executed if something is not true, add", "the 'else' block after,", "similar to how you used the 'if' block"], xPos: 360)
                    firstElse = false
                }
                
                let name = "else"
                let num = 11
                let position = numBlocksinBox
                var node = nodeAtPoint(location)
                for n in instr {
                    if n.containsPoint(location) {
                        node = n as! SKSpriteNode
                    }
                    
                }
                for n in movesBlocks {
                    if n.containsPoint(location) {
                        node = n as! SKSpriteNode
                    }
                }
                
                if box.containsPoint(location) {
                    var x: CGFloat
                    var y: CGFloat
                    if position > 27 {
                        x = 185
                        y = CGFloat(position) - 28
                    } else {
                        x = 65
                        y = CGFloat(position)
                    }
                    
                    
                    if elseStarted {
                        let count = moves.count
                        moves[count - 1] = moves[count - 1] + name + ","
                        numTimes[count - 1] = 1
                        //inBox[num] = true
                        movesBlocks.append(node)
                        instr[num].yScale = 0.4
                        instr[num].position = CGPoint(x: x, y: size.height - 22 - 10 * CGFloat(y))
                        numBlocksinBox += 1
                        addBlocks(num)
                    }
                    else {
                        moves.append(name)
                        moves.append(",")
                        numTimes.append(1)
                        movesBlocks.append(node)
                        //inBox[num] = true
                        instr[num].yScale = 0.4
                        instr[num].position = CGPoint(x: x, y: size.height - 22 - 10 * CGFloat(y))
                        numBlocksinBox += 1
                        addBlocks(num)
                    }
                } else {
                    //inBox[num] = false
                    numBlocksinBox -= 1
                }
                
                elseStarted = true
                blank = -1
                
            } else if instr[12].containsPoint(location) {
                blockTouched("isghost", num: 12, position: numBlocksinBox, location: location)
                
            } else if instr[13].containsPoint(location) {
                blockTouched("wait", num: 13, position: numBlocksinBox, location: location)
                
            } else if instr[14].containsPoint(location) {
                blockTouched("isportal", num: 14, position: numBlocksinBox, location: location)
                
            } else if instr[15].containsPoint(location) {
                blockTouched("jump", num: 15, position: numBlocksinBox, location: location)
                
                
            } else if go.containsPoint(location) {
                movesBeforeReset = moves
                numTimesBeforeReset = numTimes
                print(moves)
                print(numTimes)
                for m in movesBlocks {
                    print(m.getIsInBox(box))
                }
                //print(inBox)
                //print(numTimes)
                player.paused = false
                
                var count: NSTimeInterval = 0
                
                index = 0
                var posY = player.position.y
                var posX = player.position.x
                var posYM = monster.position.y
                var posXM = monster.position.x
                while index < moves.count {
                    print(moves)
                    print(moves.count)
                    print(numTimes)
                    print(numTimes.count)
                    
                    print(index)
                    let m = moves[index]
                    
                    let num = numTimes[index]
                    
                    let node = movesBlocks[index]
                    
                    if node.getIsInBox(box) {
                        
                        switch m {
                            
                        case "u":
                            if index < moves.count - 1 {
                                if moves[index + 1] != "jump" {
                                    posY += (oneMove * CGFloat(num))
                                    let moveUp: SKAction = SKAction.moveToY(posY, duration: 0.5)
                                    let wait: SKAction = SKAction.waitForDuration(count)
                                    moveSequence = SKAction.sequence([wait, moveUp])
                                    player.runAction(moveSequence)
                                    count+=1
                                }
                            } else {
                                posY += (oneMove * CGFloat(num))
                                let moveUp: SKAction = SKAction.moveToY(posY, duration: 0.5)
                                let wait: SKAction = SKAction.waitForDuration(count)
                                moveSequence = SKAction.sequence([wait, moveUp])
                                player.runAction(moveSequence)
                                count+=1
                            }
                            
                            
                            
                            
                        case "d":
                            if index < moves.count - 1 {
                                if moves[index + 1] != "jump" {
                                    posY -= (oneMove * CGFloat(num))
                                    let moveDown: SKAction = SKAction.moveToY(posY, duration: 0.5)
                                    let wait: SKAction = SKAction.waitForDuration(count)
                                    moveSequence = SKAction.sequence([wait, moveDown])
                                    player.runAction(moveSequence)
                                    count+=1
                                }
                            } else {
                                posY -= (oneMove * CGFloat(num))
                                let moveDown: SKAction = SKAction.moveToY(posY, duration: 0.5)
                                let wait: SKAction = SKAction.waitForDuration(count)
                                moveSequence = SKAction.sequence([wait, moveDown])
                                player.runAction(moveSequence)
                                count+=1
                            }
                            
                            
                        case "l":
                            if index < moves.count - 1 {
                                if moves[index + 1] != "jump" {
                                    posX -= (oneMove * CGFloat(num))
                                    let moveLeft: SKAction = SKAction.moveToX(posX, duration: 0.5)
                                    let wait: SKAction = SKAction.waitForDuration(count)
                                    moveSequence = SKAction.sequence([wait, moveLeft])
                                    player.runAction(moveSequence)
                                    count+=1
                                }
                            }else {
                                posX -= (oneMove * CGFloat(num))
                                let moveLeft: SKAction = SKAction.moveToX(posX, duration: 0.5)
                                let wait: SKAction = SKAction.waitForDuration(count)
                                moveSequence = SKAction.sequence([wait, moveLeft])
                                player.runAction(moveSequence)
                                count+=1
                                
                            }
                            
                        case "r":
                            if index < moves.count - 1 {
                                if moves[index + 1] != "jump" {
                                    posX += (oneMove * CGFloat(num))
                                    let moveRight: SKAction = SKAction.moveToX(posX, duration: 0.5)
                                    let wait: SKAction = SKAction.waitForDuration(count)
                                    moveSequence = SKAction.sequence([wait, moveRight])
                                    player.runAction(moveSequence)
                                    count+=1
                                }
                            } else {
                                posX += (oneMove * CGFloat(num))
                                let moveRight: SKAction = SKAction.moveToX(posX, duration: 0.5)
                                let wait: SKAction = SKAction.waitForDuration(count)
                                moveSequence = SKAction.sequence([wait, moveRight])
                                player.runAction(moveSequence)
                                count+=1
                            }
                            
                            
                            
                        case "repeat":
                            let repeatNum = moves[index + 1]
                            var i = index + 2
                            if i >= moves.count {
                                help(["If you want to repeat certain", "actions, place the 'repeat' block", "followed by the number of times", "to repeat, the actions to be", "repeated, and finally the 'end' block"], xPos: 370)
                                
                                
                            } else {
                                while moves[i] != "end" {
                                    numTimes[i] = Int(repeatNum)!
                                    i += 1
                                    
                                }
                            }
                            
                        case "if":
                            print("hi")
                            arr = moves[index + 1].componentsSeparatedByString(",")
                            moves.insert(arr[2], atIndex: index + 1)
                            moves.removeAtIndex(index + 2)
                            //numTimes.removeAtIndex(index + 2)
                            print(arr)
                            
                            //                            arr = moves[index + 1].componentsSeparatedByString(",")
                            //                            for i in 2..<arr.count {
                            //                                //moves.insert(arr[i], atIndex: index + i)
                            //                                moves[index + i - 1] = arr[i]
                            //                            }
                            //moves.removeAtIndex(index + 1)
                            //print(arr)
                            
                            
                            
                            
                            print(moves)
                            
                        case "else":
                            arr = moves[index + 1].componentsSeparatedByString(",")
                            print(moves[index + 1])
                            moves.removeAtIndex(index + 1)
                            numTimes.removeAtIndex(index + 2)
                            for i in 2..<arr.count {
                                moves.insert(arr[i], atIndex: index + i - 1)
                                numTimes.insert(1, atIndex: index + i - 1)
                                
                                //moves[index + i - 1] = arr[i]
                            }
                            
                            //arr = []
                            
                            print(moves)
                            
                            
                        case "isghost":
                            print(posX)
                            print(posY)
                            print(posXM)
                            
                            // monster.removeAllActions()
                            
                            //let a = posXM > 15
                            let a = monsterCollide.containsPoint(CGPoint(x: posXM, y: posYM))
                            let b = posY < 79.7 - 6.6
                            let c = posY > 79.7 - 21.2
                            let d = posY > 79.7 + 6.6
                            let e = posY < 79.7 + 21.2
                            let f = posX > 21.1 - 6.7
                            let g = posX < 20.1 + 6.7
                            print(a)
                            print(b)
                            print(c)
                            print(d)
                            print(e)
                            print(f)
                            print(g)
                            bool = a && f && g && ((b && c) || (d && e))
                            
                            checkCondition(bool)
                            
                        case "wait":
                            let wait: SKAction = SKAction.waitForDuration(count)
                            let wait2: SKAction = SKAction.waitForDuration(6)
                            moveSequence = SKAction.sequence([wait, wait2])
                            player.runAction(moveSequence)
                            
                            
                        case "isportal":
                            bool = isPortal
                            checkCondition(bool)
                            
                            //case "end":
                            //monster.runAction(SKAction.repeatActionForever(sequence))
                            
                        case "jump":
                            ignoreHole = true
                            switch moves[index - 1] {
                            case "u":
                                posY += (jumpMove * CGFloat(num))
                                let moveUp: SKAction = SKAction.moveToY(posY, duration: 1)
                                let wait: SKAction = SKAction.waitForDuration(count)
                                moveSequence = SKAction.sequence([wait, moveUp])
                                player.runAction(moveSequence)
                                count+=1
                                
                            case "d":
                                posY -= (jumpMove * CGFloat(num))
                                let moveUp: SKAction = SKAction.moveToY(posY, duration: 1)
                                let wait: SKAction = SKAction.waitForDuration(count)
                                moveSequence = SKAction.sequence([wait, moveUp])
                                player.runAction(moveSequence)
                                //player.position = CGPoint(x: player.position.x, y: posY)
                                
                                count+=1
                                
                                
                            case "l":
                                posX -= (jumpMove * CGFloat(num))
                                let moveLeft: SKAction = SKAction.moveToX(posX, duration: 0.5)
                                let wait: SKAction = SKAction.waitForDuration(count)
                                moveSequence = SKAction.sequence([wait, moveLeft])
                                player.runAction(moveSequence)
                                count+=1
                                
                            case "r":
                                posX += (jumpMove * CGFloat(num))
                                let moveLeft: SKAction = SKAction.moveToX(posX, duration: 0.5)
                                let wait: SKAction = SKAction.waitForDuration(count)
                                moveSequence = SKAction.sequence([wait, moveLeft])
                                player.runAction(moveSequence)
                                count+=1
                                
                            default: break
                                
                            }
                            ignoreHole = false
                            
                        default: break
                            
                        }
                        
                        
                    }
                    
                    index += 1
                    
                    
                }
                //moves = []
                print(player.position)
                go.hidden = true
                reset.hidden = false
                moves = movesBeforeReset
                numTimes = numTimesBeforeReset
                
                
                if hole.containsPoint(CGPoint(x: posX, y: posY)) && self.children.contains(hole) {
                    if !ignoreHole {
                        print("hole!")
                        let wait1 = SKAction.waitForDuration(count)
                        let hole = SKAction.runBlock({
                            let label = SKLabelNode(text: "You fell into the hole!")
                            label.fontName = "ChalkboardSE-Bold"
                            label.position = CGPoint(x: self.width/2, y: self.height/2)
                            label.zPosition = 10
                            self.removeActionForKey("timer")
                            self.addChild(label)
                        })
                        
                        
                        let wait: SKAction = SKAction.waitForDuration(3)
                        let refresh = SKAction.runBlock({
                            self.refreshView()
                        })
                        let sequence = SKAction.sequence([wait1, hole, wait, refresh])
                        player.runAction(sequence)
                        
                        
                    }
                    
                }
                if portalEnter.containsPoint(CGPoint(x: posX, y: posY)) && self.children.contains(portalEnter) {
                    if !ignoreHole {
                        print("portal")
                        ignoreCollision = true
                        let wait = SKAction.waitForDuration(2)
                        let move: SKAction = SKAction.moveTo(portalEnd.position, duration: 0.5)
                        let sequence = SKAction.sequence([wait, move, wait])
                        player.runAction(sequence)
                        player.zPosition = 4
                        
                    }
                    ignoreHole = false
                    
                }
                
                //ignoreCollision = false
                
                
            } else if reset.containsPoint(location) {
                player.position = playerStart
                reset.hidden = true
                go.hidden = false
                
                
                
            } else if trash.containsPoint(location) {
                selectedNode.removeFromParent()
                selectedNode.position = CGPoint(x: 0, y: 0)
                print("trash")
                print(movesBlocks.count)
                numBlocksinBox -= 1
                ifStarted = false
                elseStarted = false
                if movesBlocks.count > 1 {
                    for j in 0...(movesBlocks.count - 1) {
                        
                        
                        
                        
                        if movesBlocks[j] == selectedNode {
                            //
                            //                            if moves[j] == "end" {
                            //                                var k = j
                            //                                while k > -1 {
                            //                                    if moves[k] == "if" {
                            //                                        ifStarted = true
                            //                                    } else if moves[k] == "else" {
                            //                                        elseStarted = true
                            //                                    }
                            //                                    k -= 1
                            //                                }
                            //                            }
                            //
                            //
                            //
                            //
                            //                            print("j: \(j)")
                            //                            print(moves)
                            //                            print(numTimes)
                            //                            print("---")
                            movesBlocks.removeAtIndex(j)
                            moves.removeAtIndex(j)
                            numTimes.removeAtIndex(j)
                            //                            print("j: \(j)")
                            //                            print(moves)
                            //                            print(numTimes)
                            //
                            //
                            
                            break
                        }
                    }
                    for j in 0...(movesBlocks.count - 1) {
                        var x: CGFloat
                        var y: CGFloat
                        if j > 27 {
                            x = 185
                            y = CGFloat(j) - 28
                        } else {
                            x = 65
                            y = CGFloat(j)
                        }
                        movesBlocks[j].position = CGPoint(x: x, y: size.height - 22 - 10 * CGFloat(y))
                    }
                } else {
                    movesBlocks = []
                    moves = []
                    numTimes = []
                }
                
            } else if helpBox.containsPoint(location) {
                helpBox.removeAllChildren()
                helpBox.removeFromParent()
            }
            if clear.containsPoint(location) {
                print("clear")
                for m in movesBlocks {
                    m.removeFromParent()
                }
                movesBlocks = []
                moves = []
                numTimes = []
                player.position = playerStart
                numBlocksinBox = 0
                
            }
            
        }
        
    }
    
    
    func repeatInput() {
        let textField: UITextField = UITextField(frame: CGRectMake(self.size.width / 2, self.size.height / 2 + 20, 100, 40))
        textField.text = "1"
        textField.center = self.view!.center
        textField.borderStyle = .RoundedRect
        textField.textColor = UIColor.blackColor()
        textField.font = UIFont.systemFontOfSize(17.0)
        textField.backgroundColor = UIColor.whiteColor()
        textField.autocorrectionType = .Yes
        textField.keyboardType = .Default
        textField.clearButtonMode = .WhileEditing
        self.view!.addSubview(textField)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        firstBody = contact.bodyA
        secondBody = contact.bodyB
        
        if (firstBody.categoryBitMask == playerCategory && secondBody.categoryBitMask == wallCategory) || (firstBody.categoryBitMask == wallCategory && secondBody.categoryBitMask == playerCategory)  {
            if !ignoreCollision && !portalEnd.containsPoint(player.position){
                print("collision!!")
                //player.paused = true
                ignoreCollision = true
            }
            
            
            
        }
            //        else if (firstBody.categoryBitMask == portalCategory && secondBody.categoryBitMask == playerCategory) || (firstBody.categoryBitMask == playerCategory && secondBody.categoryBitMask == portalCategory) {
            //            if !ignoreHole {
            //                print("portal")
            //                ignoreCollision = true
            //                let wait = SKAction.waitForDuration(2)
            //                let move: SKAction = SKAction.moveTo(portalEnd.position, duration: 0.2)
            //                let sequence = SKAction.sequence([wait, move])
            //                player.runAction(sequence)
            //                player.zPosition = 4
            //            }
            //            ignoreHole = false
            //
            //
            //        }
        else if (firstBody.categoryBitMask == playerCategory && secondBody.categoryBitMask == ghostCategory) || (firstBody.categoryBitMask == ghostCategory && secondBody.categoryBitMask == playerCategory) {
            print("ghost!")
            let label = SKLabelNode(text: "You ran into the ghost!")
            label.fontName = "ChalkboardSE-Bold"
            label.position = CGPoint(x: size.width/2, y: size.height/2)
            removeActionForKey("timer")
            addChild(label)
            
            let wait: SKAction = SKAction.waitForDuration(3)
            let refresh = SKAction.runBlock({
                self.refreshView()
            })
            let sequence = SKAction.sequence([wait, refresh])
            player.runAction(sequence)
            
        } else if (firstBody.categoryBitMask == exitCategory && secondBody.categoryBitMask == playerCategory) || (firstBody.categoryBitMask == playerCategory && secondBody.categoryBitMask == exitCategory ) {
            print("you win!")
            justPlayed()
            let label = SKLabelNode(text: "You made it!")
            label.fontName = "ChalkboardSE-Bold"
            label.zPosition = 10
            label.position = CGPoint(x: size.width/2, y: size.height/2)
            removeActionForKey("timer")
            addChild(label)
            calculatePoints()
            
            let wait: SKAction = SKAction.waitForDuration(3)
            let next = SKAction.runBlock({
                if !self.viewController.noAnimation {
                    self.viewController.nextGame()
                } else {
                    self.viewController.score()
                }
                
            })
            
            let sequence = SKAction.sequence([wait, next])
            player.runAction(sequence)
            
            
            
        }
        //        else if (firstBody.categoryBitMask == playerCategory && secondBody.categoryBitMask == holeCategory) || (firstBody.categoryBitMask == holeCategory && secondBody.categoryBitMask == playerCategory) {
        //            print("holee")
        //            if !ignoreHole {
        //                print("hole!")
        //                let label = SKLabelNode(text: "You fell into the hole!")
        //                removeActionForKey("timer")
        //                addChild(label)
        //
        //                let wait: SKAction = SKAction.waitForDuration(3)
        //                let refresh = SKAction.runBlock({
        //                    self.refreshView()
        //                })
        //                let sequence = SKAction.sequence([wait, refresh])
        //                player.runAction(sequence)
        //
        //
        //            }
        //        }
        //        else if (firstBody.categoryBitMask == playerCategory && secondBody.categoryBitMask == portalEndCategory) || (firstBody.categoryBitMask == portalEndCategory && secondBody.categoryBitMask == playerCategory) {
        //            ignoreCollision = false
        //            print("don't ignore")
        //        }
        
        
        
    }
    
    func refreshView() {
        viewController!.viewDidLoad()
        
    }
    
    func calculatePoints() {
        let points1: Double = 1 / (Double(timeMin) * 60 + Double(timeSecond))
        points = Int(points1 * 500)
        print(points)
        
        
        pointsHigh = defaults.integerForKey("mazePointsHigh")
        
        if points > pointsHigh {
            pointsHigh = points
        }
        
        defaults.setInteger(points, forKey: "mazePoints")
        defaults.setInteger(pointsHigh, forKey:  "mazePointsHigh")
        defaults.synchronize()
        
        print("saved \(defaults.integerForKey("mazePoints"))")
        defaults.setBool(true, forKey: "mazeCompleted")
        
    }
    
    func justPlayed() {
        defaults.setBool(true, forKey: "justPlayedMaze")
        defaults.synchronize()
    }
    
    func loadMaze() {
        var r = 0
        
        let rand = Int(arc4random_uniform(3) + 1)
        
        if let levelPath = NSBundle.mainBundle().pathForResource("maze\(rand)", ofType: "txt") {
            
            let levelString: NSString?
            do {
                levelString = try NSString(contentsOfFile: levelPath, usedEncoding: nil)
                levelString!.enumerateLinesUsingBlock({ (line, stop) -> () in
                    let arr = Array(line.characters)
                    for (i, c) in arr.enumerate() {
                        let position = CGPoint(x: (14.4 * Double(i)) + 7.2, y: (14.4 * Double(r)) + 7.2)
                        if c == "x" {
                            let wall = SKSpriteNode(imageNamed: "block2")
                            wall.position = position
                            wall.zPosition = 2
                            wall.size = CGSizeMake(14.4, 14.4)
                            
                            wall.physicsBody = SKPhysicsBody(rectangleOfSize: wall.size)
                            wall.physicsBody?.dynamic = false
                            wall.physicsBody?.affectedByGravity = false
                            wall.physicsBody?.categoryBitMask = self.wallCategory
                            wall.physicsBody?.contactTestBitMask = self.playerCategory
                            wall.physicsBody?.collisionBitMask = self.playerCategory
                            wall.physicsBody?.usesPreciseCollisionDetection = true
                            
                            self.addChild(wall)
                            
                        } else if c == "m" {
                            self.monster = SKSpriteNode(imageNamed: "theghost")
                            self.monster.size = CGSizeMake(13.4, 13.4)
                            self.monster.position = CGPoint(x: 21.1, y: 79.7)
                            self.monster.zPosition = 1
                            self.monsterCollide = SKSpriteNode(imageNamed: "ghostcollide")
                            self.monsterCollide.size = CGSizeMake(14.4, 14.4)
                            self.monsterCollide.position = CGPoint(x: 21.6, y: 79.7)
                            
                            
                            self.monster.physicsBody = SKPhysicsBody(rectangleOfSize: self.monster.size)
                            self.monster.physicsBody?.dynamic = true
                            self.monster.physicsBody?.affectedByGravity = false
                            self.monster.physicsBody?.categoryBitMask = self.ghostCategory
                            self.monster.physicsBody?.contactTestBitMask = self.playerCategory
                            self.monster.physicsBody?.collisionBitMask = self.playerCategory
                            self.monster.physicsBody?.usesPreciseCollisionDetection = true
                            
                            
                            self.addChild(self.monster)
                        } else if c == "p" {
                            self.portalEnter = SKSpriteNode(imageNamed: "portal")
                            self.portalEnter.position = position
                            
                            self.portalEnter.physicsBody = SKPhysicsBody(rectangleOfSize: self.portalEnter.size)
                            self.portalEnter.physicsBody?.dynamic = false
                            self.portalEnter.physicsBody?.affectedByGravity = false
                            self.portalEnter.physicsBody?.categoryBitMask = self.portalCategory
                            self.portalEnter.physicsBody?.contactTestBitMask = self.playerCategory
                            self.portalEnter.physicsBody?.collisionBitMask = self.playerCategory
                            self.portalEnter.physicsBody?.usesPreciseCollisionDetection = true
                            
                            self.addChild(self.portalEnter)
                        } else if c == "e" {
                            self.portalEnd = SKSpriteNode(imageNamed: "portal")
                            self.portalEnd.position = position
                            
                            self.portalEnd.physicsBody = SKPhysicsBody(rectangleOfSize: self.portalEnd.size)
                            self.portalEnd.physicsBody?.dynamic = false
                            self.portalEnd.physicsBody?.affectedByGravity = false
                            self.portalEnd.physicsBody?.categoryBitMask = self.portalEndCategory
                            self.portalEnd.physicsBody?.contactTestBitMask = self.playerCategory
                            self.portalEnd.physicsBody?.collisionBitMask = self.playerCategory
                            self.portalEnd.physicsBody?.usesPreciseCollisionDetection = true
                            
                            self.addChild(self.portalEnd)
                        } else if c == "w" {
                            let exit = SKSpriteNode(imageNamed: "exit")
                            exit.position = position
                            exit.xScale = 1.8
                            exit.yScale = 0.9
                            
                            exit.physicsBody = SKPhysicsBody(rectangleOfSize: exit.size)
                            exit.physicsBody?.dynamic = false
                            exit.physicsBody?.affectedByGravity = false
                            exit.physicsBody?.categoryBitMask = self.exitCategory
                            exit.physicsBody?.contactTestBitMask = self.playerCategory
                            exit.physicsBody?.collisionBitMask = self.playerCategory
                            exit.physicsBody?.usesPreciseCollisionDetection = true
                            
                            
                            self.addChild(exit)
                            
                        }
                        
                    }
                    r += 1
                })
            } catch _ {
                levelString = nil
                print("no")
            }
            
            
        }
        
    }
    
    func degToRad(degree: Double) -> CGFloat {
        return CGFloat(Double(degree) / 180.0 * M_PI)
    }
    
    func selectNodeForTouch(touchLocation: CGPoint) {
        //var touchedNode = self.nodeAtPoint(touchLocation)
        
        var touchedNode: SKNode = self.nodeAtPoint(touchLocation)
        for node in instr {
            if node.containsPoint(touchLocation) {
                touchedNode = node as! SKSpriteNode
            }
            
        }
        for node in movesBlocks {
            if node.containsPoint(touchLocation) {
                touchedNode = node as! SKSpriteNode
            }
        }
        
        if touchedNode is SKSpriteNode {
            if !selectedNode.isEqual(touchedNode) {
                selectedNode.removeAllActions()
                selectedNode.runAction(SKAction.rotateToAngle(0.0, duration: 0.1))
                selectedNode = touchedNode as! SKSpriteNode
                
                if touchedNode.name! == block {
                    let sequence = SKAction.sequence([SKAction.rotateByAngle(degToRad(-4.0), duration: 0.1),
                        SKAction.rotateByAngle(0.0, duration: 0.1),
                        SKAction.rotateByAngle(degToRad(4.0), duration: 0.1)])
                    selectedNode.runAction(SKAction.repeatActionForever(sequence))
                }
                
            }
        }
    }
    
    func boundLayerPos(aNewPosition: CGPoint) -> CGPoint {
        let winSize = self.size
        var retval = aNewPosition
        retval.x = CGFloat(min(retval.x, 0))
        retval.x = CGFloat(max(retval.x, -(view!.frame.size.width) + winSize.width))
        retval.y = self.position.y
        
        return retval
    }
    
    func panForTranslation(translation: CGPoint) {
        
        
        let position = selectedNode.position
        
        if selectedNode.name! == block {
            selectedNode.position = CGPoint(x: position.x + translation.x, y: position.y + translation.y)
            
        }
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            let positionInScene = touch.locationInNode(self)
            let previousPosition = touch.previousLocationInNode(self)
            let translation = CGPoint(x: positionInScene.x - previousPosition.x, y: positionInScene.y - previousPosition.y)
            
            panForTranslation(translation)
        }
    }
    
        
    
}
