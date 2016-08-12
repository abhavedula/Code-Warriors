//
//  DetailViewController.swift
//  Game app
//
//  Created by Abha Vedula on 7/15/16.
//  Copyright © 2016 Abha Vedula. All rights reserved.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController {
    
    var game: Game!
    
    var defaults: NSUserDefaults!
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var playButton: UIButton!
    
    @IBOutlet var descriptionLabel: UILabel!
    
    var gameNames = ["maze", "heap", "graph"]

    @IBOutlet var imageView: UIImageView!
    
    @IBAction func playButtonPressed(sender: AnyObject) {

        performSegueWithIdentifier(game.name! + "Segue", sender: nil)
            
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        nameLabel.text = game.nameToShow
        descriptionLabel.text = game.descr
        imageView.image = game.thumbnail
        imageView.alpha = 0.3
        imageView.image?.drawInRect(CGRect(x: 0, y: 0, width: 375, height: 400))
        
       // self.navigationItem.leftBarButtonItem!.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Menlo-Bold", size: 20)!], forState: .Normal)
        
        

        for name in gameNames {
            if !defaults.boolForKey(name + "Completed") {
                playButton.setTitle("Locked", forState: .Normal)
                playButton.userInteractionEnabled = false
            } else {
                playButton.userInteractionEnabled = true
            }
        }


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "mazeSegue" {
            let vc = segue.destinationViewController as! MazeViewController
            vc.noAnimation = true
        } else if segue.identifier == "heapSegue" {
            let vc = segue.destinationViewController as! HeapViewController
            vc.noAnimation = true
        } else if segue.identifier == "graphSegue" {
            let vc = segue.destinationViewController as! GraphViewController
            vc.noAnimation = true
        }
    }


}
