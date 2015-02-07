//
//  ViewController.swift
//  feelAbout
//
//  Created by Jessica Berglund on 2/4/15.
//  Copyright (c) 2015 Jessica Berglund. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate
{
    @IBOutlet weak var aboutCollectionView: UICollectionView!
    @IBOutlet weak var feelingCollectionView: UICollectionView!
    
    let negativeFeelings = ["","angry","nervous","sad","confused","frustrated", "disappointed","irritated","insecure"]
    
    let aboutTopics = ["","career","relationship","friends","finances","education", "health","appearance"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO - signin using device ID as unique token/username?
        if (PFUser.currentUser() == nil) {
            
            PFAnonymousUtils.logInWithBlock {
                (user: PFUser!, error: NSError!) -> Void in
                if error != nil {
                    NSLog("Anonymous login failed.")
                } else {
                    NSLog("Anonymous user logged in.")
                }
                
                self.startLoad()

            }
        } else {
             NSLog("User already logged in.")
            
            self.startLoad()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func startLoad() {
//        var feelingAboutTest = FeelingAbout(feeling: "excited", about: "coding", byUser : PFUser.currentUser())
//        feelingAboutTest.feeling = "elated"
//        feelingAboutTest.saveInBackgroundWithBlock { (succeed: Bool, error : NSError!) -> Void in
//            NSLog("COOL");
//        }
        
        
//        var testObject = PFObject(className:"TestObject")
//        testObject["foo"] = "bar"
//        testObject.saveInBackgroundWithBlock { (succeed: Bool, error : NSError!) -> Void in
//            NSLog("COOL");
//        }
    }
    
    //UICollectionView
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.feelingCollectionView) {
            return self.negativeFeelings.count
        } else {
            return self.aboutTopics.count
        }
        
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let reuseId = collectionView == self.feelingCollectionView ? "feelingCell" : "aboutCell";
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseId, forIndexPath: indexPath) as FeelingAboutCell
        
        if (collectionView == self.feelingCollectionView) {
            cell.feelingTopicLabel.text = self.negativeFeelings[indexPath.row]
        } else {
            cell.feelingTopicLabel.text = self.aboutTopics[indexPath.row]
        }
        
        return cell
    }

}

