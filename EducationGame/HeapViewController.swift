//
//  GameViewController.swift
//  helloSpriteKit
//
//  Created by Prachi Bodas on 7/5/16.
//  Copyright (c) 2016 Prachi Bodas. All rights reserved.
//

import UIKit
import SpriteKit

class HeapViewController: UIViewController {
    
    var noAnimation: Bool = false
    
    var justPlayed: Bool!
    
    var currScene: SKScene?
    
    var defaults: NSUserDefaults!
    
    var heapScene: HeapGameScene!
    
    var heapSceneAnimation1: HeapAnimationScene1!
    
    var heapSceneAnimation2: HeapAnimationScene2!
    
    var skView: SKView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaults = NSUserDefaults.standardUserDefaults()
        justPlayed = false
        defaults.setBool(justPlayed, forKey: "justPlayedHeap")
        defaults.synchronize()

    
        skView = self.view as! SKView
        

        skView.showsFPS = false
        skView.showsNodeCount = false
            
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
            
        /* Set the scale mode to scale to fit the window */
            
       
        heapSceneAnimation1 = HeapAnimationScene1(size: skView.bounds.size, viewController: self)
        heapSceneAnimation1.scaleMode = .ResizeFill
        
        heapSceneAnimation2 = HeapAnimationScene2(size: skView.bounds.size, viewController: self)
        heapSceneAnimation2.scaleMode = .ResizeFill
        
        heapScene = HeapGameScene(size: skView.bounds.size, viewController: self)
        heapScene.scaleMode = .ResizeFill


        if noAnimation {
            currScene = heapScene
            unrotate()
            skView.presentScene(heapScene)
        } else {
            currScene = heapSceneAnimation1
            
            shouldAutorotate()
            supportedInterfaceOrientations()

            skView.presentScene(heapSceneAnimation1)
        }

    }
    
    func nextGame() {
        performSegueWithIdentifier("HeapToGraphSegue", sender: nil)
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if currScene == heapSceneAnimation1 || currScene == heapSceneAnimation2 {
            return .Portrait
        }
        return .Portrait
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "HeapToGraphSegue" {
            let graphViewController = segue.destinationViewController as! GraphViewController
        
            graphViewController.defaults = self.defaults
        }
        
    }
    
    func score() {
        performSegueWithIdentifier("HeapToScoreSegue", sender: nil)
    }
    
    func nextScene() {
        currScene = heapSceneAnimation2
        shouldAutorotate()
        supportedInterfaceOrientations()
        skView.presentScene(heapSceneAnimation2)
    }
    
    func presentGame() {
        currScene = heapScene
        supportedInterfaceOrientations()
        shouldAutorotate()
        print(currScene)
        print(supportedInterfaceOrientations())
        skView.presentScene(heapScene)
      
    }
    
    //CHANGES HERE
    
    func rotate() {
        UIApplication.sharedApplication().setStatusBarOrientation(.LandscapeLeft, animated: false)
        // rotate main view, in this sample the view of navigation controller is the root view in main window
        self.view!.transform = CGAffineTransformMakeRotation(CGFloat(M_PI / 2))
        // set size of view
        self.view!.frame = CGRectMake(0, 0, 667, 375)
        
    }
    
    //CHANGES HERE
    
    func unrotate() {
        UIApplication.sharedApplication().setStatusBarOrientation(.Portrait, animated: false)
        // rotate main view, in this sample the view of navigation controller is the root view in main window
        self.view!.transform = CGAffineTransformMakeRotation(CGFloat(2 * M_PI))
        // set size of view
        self.view!.frame = CGRectMake(0, 0, 375, 667)
        
    }
    

  
    
}
