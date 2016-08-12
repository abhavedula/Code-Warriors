//
//  ScoreViewController.swift
//  Game app
//
//  Created by Abha Vedula on 7/11/16.
//  Copyright © 2016 Abha Vedula. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {

    @IBOutlet var scoreLabel: UILabel!
    
    let player = NSUserDefaults.standardUserDefaults()
    
    var game: Game?
    var gameName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        scoreLabel.text = "Score: \(player.integerForKey(gameName))"
        
        game!.completed = true
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
