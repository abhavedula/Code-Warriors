//
//  GamesViewController.swift
//  Game app
//
//  Created by Abha Vedula on 7/11/16.
//  Copyright © 2016 Abha Vedula. All rights reserved.
//

import UIKit

class GamesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var pointsLabel: UILabel!
    
    var points: Int = 0
    
    var games: [Game] = []
    
    var game: Game!
    
    let defaults = NSUserDefaults.standardUserDefaults()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        reset everything saved to NSUserDefaults
//        defaults.setInteger(0, forKey: "mazePoints")
//        defaults.setInteger(0, forKey: "mazePointsHigh")
//        defaults.setInteger(0, forKey: "heapPoints")
//        defaults.setInteger(0, forKey: "heapPointsHigh")
//        defaults.setInteger(0, forKey: "graphPoints")
//        defaults.setInteger(0, forKey: "graphPointsHigh")
//        
//        defaults.setBool(false, forKey: "mazeCompleted")
//        defaults.setBool(false, forKey: "heapCompleted")
//        defaults.setBool(false, forKey: "graphCompleted")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.grayColor().colorWithAlphaComponent(0.5)
        shadow.shadowOffset = CGSizeMake(2, 2);
        shadow.shadowBlurRadius = 4;
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 59/255, green: 31/255, blue: 10/255, alpha: 1)
        self.navigationController?.navigationBar.alpha = 1
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSFontAttributeName : UIFont.init(name: "Menlo-Bold", size: 25)!,
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSShadowAttributeName : shadow
        ]
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont.init(name: "Menlo", size: 15)!], forState: UIControlState.Normal)

        
        
        var mazeGame = Game(name: "maze")
        mazeGame.nameToShow = "Maze Madness"
        
        mazeGame.descr = "This game teaches you basic programming concepts such as loops and conditionals. Your taks is to program your way out of a maze. Learn how computers think by using code blocks to write your own program. Let's go!"
        mazeGame.thumbnail = UIImage(named: "mazeThumbnail")
        games.append(mazeGame)
        
        var heapGame = Game(name: "heap")
        heapGame.nameToShow = "Rotation Roulette"
        heapGame.descr = "This game teaches you the basics heap rotations. Your task will be to rotate the heap so that the hero doesn't fall off. Use the buttons near the top to rotate. Let’s go!"
        heapGame.thumbnail = UIImage(named: "heapThumbnail2")
        games.append(heapGame)
        
        var graphGame = Game(name: "graph")
        graphGame.nameToShow = "Daredevil Driver"//
        graphGame.descr = "This game teaches you the basics of a minimal spanning tree. Your task will be to drive the shortest path to the finish spot, with the distance you travel represented by the numbers on the road. You can use the green arrows in the top right corner to navigate your way. Let’s go!"
        graphGame.thumbnail = UIImage(named: "graphThumbnail")
        games.append(graphGame)
        
        getPoints()
        
        pointsLabel.text = "Highscore: \(points)"
        
        defaults.setBool(false, forKey: "justPlayedMaze")
        defaults.setBool(false, forKey: "justPlayedHeap")
        defaults.setBool(false, forKey: "justPlayedGraph")
        defaults.synchronize()

        
        // Do any additional setup after loading the view.
    }
    
    func getPoints() {
        
         points = defaults.integerForKey("mazePointsHigh") + defaults.integerForKey("heapPointsHigh") + defaults.integerForKey("graphPointsHigh")
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GameCell", forIndexPath: indexPath) as! GameCell
        cell.backgroundColor = UIColor.grayColor()
        if indexPath.section * 2 + indexPath.row < games.count {
            let game = games[indexPath.section * 2 + indexPath.row]
            cell.nameLabel.text = game.nameToShow
            cell.imageView.image = game.thumbnail
            cell.imageView.alpha = 0.4
            
        } else {
            cell.hidden = true
        }

        cell.nameLabel.textColor = UIColor.whiteColor()
        return cell
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func startButton(sender: AnyObject) {
       performSegueWithIdentifier("animationSegue", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "DetailSegue" {
        let indexPath = collectionView.indexPathForCell(sender as! UICollectionViewCell)
        
        game = games[indexPath!.section * 2 + indexPath!.row]
        
        let detailViewController = segue.destinationViewController as! DetailViewController
        
        detailViewController.game = self.game
        detailViewController.defaults = self.defaults
            
        } else if segue.identifier == "animationSegue" {
            
            let introViewController = segue.destinationViewController as! IntroAnimationViewController
            
            introViewController.defaults = self.defaults
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .Portrait
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
