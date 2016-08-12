//
//  ScoreViewController.swift
//  Game app
//
//  Created by Abha Vedula on 7/11/16.
//  Copyright © 2016 Abha Vedula. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    
    
    @IBOutlet var mazeLabel: UILabel!

    @IBOutlet var heapLabel: UILabel!
    
    @IBOutlet var graphLabel: UILabel!
    
    @IBOutlet var totalLabel: UILabel!
    
    let maze = MazeViewController()
    let heap = HeapViewController()
    let graph = GraphViewController()
    
    
    @IBAction func homeButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("HomeSegue", sender: nil)
    }
    
    var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    var game: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        mazeLabel.text = "Maze Score: \(defaults.integerForKey("mazePoints"))"
        heapLabel.text = "Heap Score: \(defaults.integerForKey("heapPoints"))"
        graphLabel.text = "Graph Score: \(defaults.integerForKey("graphPoints"))"
        totalLabel.hidden = true
        
        
        if !defaults.boolForKey("justPlayedMaze") {
            mazeLabel.hidden = true
        }
        if !defaults.boolForKey("justPlayedHeap") {
            heapLabel.hidden = true
        }
        if !defaults.boolForKey("justPlayedGraph")  {
            graphLabel.hidden = true
        }
        
        if defaults.boolForKey("justPlayedGraph") && defaults.boolForKey("justPlayedHeap") && defaults.boolForKey("justPlayedMaze") {
            totalLabel.hidden = false
            totalLabel.text = "Total Score: \(defaults.integerForKey("mazePoints") + defaults.integerForKey("heapPoints") + defaults.integerForKey("graphPoints"))"
        }
      
        
        
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

}
