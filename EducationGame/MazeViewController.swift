//
//  AnimationExplanationViewController.swift
//  Maze 3
//
//  Created by Abha Vedula on 7/11/16.
//  Copyright © 2016 Abha Vedula. All rights reserved.
//

import UIKit
import SpriteKit

class MazeViewController: UIViewController {
    
    var noAnimation: Bool = false
    
    var currScene: SKScene?
    
    var animationView: SKView!
    
    var animationScene: MazeAnimationScene1!
    
    var animationScene2: MazeAnimationScene2!
    
    var mazeScene: MazeGameScene!
    
    var defaults: NSUserDefaults!
    
    var justPlayed: Bool!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaults = NSUserDefaults.standardUserDefaults()
        justPlayed = false
        defaults.setBool(justPlayed, forKey: "justPlayedMaze")
        defaults.synchronize()
        
        animationView = view as! SKView
        
        animationScene = MazeAnimationScene1(size: view.bounds.size, viewController: self)
        
        animationScene2 = MazeAnimationScene2(size: view.bounds.size, viewController: self)
        
        mazeScene = MazeGameScene(size: view.bounds.size, viewController: self)
        
        
        animationScene2.viewController = self

        animationView.ignoresSiblingOrder = false
        animationScene.scaleMode = .ResizeFill
        animationScene2.scaleMode = .ResizeFill
        mazeScene.scaleMode = .ResizeFill
        
    
        
        if noAnimation {
            shouldAutorotate()
            supportedInterfaceOrientations()
            
           
            
            print(mazeScene.width)

            animationView.presentScene(mazeScene)
            currScene = mazeScene
            
            
        } else {
            shouldAutorotate()
            supportedInterfaceOrientations()
            

            animationView.presentScene(animationScene)
            currScene = animationScene
            
            
        }
        
    }
    
    func nextGame() {
        performSegueWithIdentifier("MazeToHeapSegue", sender: nil)
    }

    func nextScene() {
        currScene = animationScene2
        shouldAutorotate()
        supportedInterfaceOrientations()
        animationView.presentScene(animationScene2)
    }
    
    func mazeGame() {
        currScene = mazeScene
        shouldAutorotate()
        supportedInterfaceOrientations()
        animationView.presentScene(mazeScene)
    }
    
    func score() {
        performSegueWithIdentifier("MazeToScoreSegue", sender: nil)
    }
   
    
//    override func shouldAutorotate() -> Bool {
//        return true
//    }
//    
//    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
//        return UIInterfaceOrientationMask.LandscapeLeft
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if currScene == mazeScene {
            return .Portrait
        }
        return .Landscape
    
        /*if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
         return .AllButUpsideDown
         } else {
         return .All
         }*/
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "MazeToHeapSegue" {
            let heapViewController = segue.destinationViewController as! HeapViewController
        
            heapViewController.defaults = self.defaults
        }
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */



}
