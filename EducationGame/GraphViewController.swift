//
//  GameViewController.swift
//  CarGame
//
//  Created by John Kriston on 7/7/16.
//  Copyright (c) 2016 John Kriston. All rights reserved.
//

import UIKit
import SpriteKit

class GraphViewController: UIViewController {
    
    var noAnimation: Bool = false
    
     var justPlayed: Bool!
    
    var defaults: NSUserDefaults!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaults = NSUserDefaults.standardUserDefaults()
        
        justPlayed = false
        defaults.setBool(justPlayed, forKey: "justPlayedGraph")
        defaults.synchronize()

        let skView = self.view as! SKView
        
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.ignoresSiblingOrder = true
        
        let animationScene = GraphAnimationScene1(size: skView.bounds.size, viewController: self)
        animationScene.scaleMode = .ResizeFill
        
        let graphScene = GraphGameScene2(size: skView.bounds.size, viewController: self)
        graphScene.scaleMode = .ResizeFill
        
        let chooseCar = ChooseCarScene(size: skView.bounds.size, viewController: self)
        chooseCar.scaleMode = .ResizeFill


        
        
        if noAnimation {
            shouldAutorotate()
            supportedInterfaceOrientations()
            skView.presentScene(chooseCar)
        } else {
            shouldAutorotate()
            supportedInterfaceOrientations()
            skView.presentScene(animationScene)
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .Landscape
    }

    
    func presentAnimation2() {
        let skView = self.view as! SKView
        let animationScene = GraphAnimationScene2(size: skView.bounds.size, viewController: self)
        skView.presentScene(animationScene)
        
    }
    
    func presentGame() {
        let skView = self.view as! SKView
        let gameScene = GraphGameScene(size: skView.bounds.size, viewController: self)
        skView.presentScene(gameScene)
    }
    
    func presentGame1(){
        let skView = self.view as! SKView
        let gameScene = GraphGameScene1(size: skView.bounds.size, viewController: self)
        skView.presentScene(gameScene)
        
    }
    
    func presentGame2(){
        let skView = self.view as! SKView
        let gameScene = GraphGameScene2(size: skView.bounds.size, viewController: self)
        skView.presentScene(gameScene)
        
    }
    
    func presentChooseCar(){
        let skView = self.view as! SKView
        let gameScene = ChooseCarScene(size: skView.bounds.size, viewController: self)
        skView.presentScene(gameScene)
    }
    
    func presentChooseLevel(){
        let skView = self.view as! SKView
        let gameScene = ChooseLevelScene(size: skView.bounds.size, viewController: self)
        skView.presentScene(gameScene)
        
    }

    
    func endGame() {
        let skView = self.view as! SKView
        let endScene = EndGameScene(size: skView.bounds.size, viewController: self)
        skView.presentScene(endScene)

        
    }
    
    func congrats() {
        let skView = self.view as! SKView
        let congratsScene = CongratulationsScene(size: skView.bounds.size, viewController: self)
        skView.presentScene(congratsScene)

        
    }
    
    func score() {
        performSegueWithIdentifier("GraphToScoreSegue", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let scoreViewController = segue.destinationViewController as! ScoreViewController
        
        scoreViewController.defaults = self.defaults
        
    }
    
    
}
