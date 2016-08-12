//
//  AnimationViewController.swift
//  Game app
//
//  Created by Abha Vedula on 7/11/16.
//  Copyright © 2016 Abha Vedula. All rights reserved.
//

import UIKit
import SpriteKit

class IntroAnimationViewController: UIViewController {
    
    var defaults: NSUserDefaults!

    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = IntroAnimationScene0(size: view.bounds.size, viewController: self)
        let skView = view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.ignoresSiblingOrder = false
        scene.scaleMode = .ResizeFill
        skView.presentScene(scene)
        let value = UIInterfaceOrientation.LandscapeLeft.rawValue
        // let value = UIInterfaceOrientation.Portrait.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")

        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func nextGame() {
        performSegueWithIdentifier("IntroToMazeSegue", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let mazeViewController = segue.destinationViewController as! MazeViewController
        
        mazeViewController.defaults = self.defaults

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
