//
//  ViewController.swift
//  feelAbout
//
//  Created by Jessica Berglund on 2/4/15.
//  Copyright (c) 2015 Jessica Berglund. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate
{
    @IBOutlet weak var feelingView: UIView!
    @IBOutlet weak var talkAboutButton: UIButton!
    @IBOutlet weak var topSpaceTalkButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var aboutCollectionView: UICollectionView!
    @IBOutlet weak var feelingCollectionView: UICollectionView!
    var previousXoffset : CGFloat = 0;
    
    let negativeFeelings = ["","angry","nervous","sad","confused","frustrated", "disappointed","irritated","insecure",""]
    
    let aboutTopics = ["","career","relationship","friends","finances","education", "health","appearance",""]

    
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

    }
    
    //UICollectionView
    
    @IBAction func talkAboutButtonTapped(sender: AnyObject)
    {
        var newConstraint = NSLayoutConstraint(item: self.talkAboutButton, attribute: .Top, relatedBy: .Equal, toItem: self.feelingView, attribute: .Top, multiplier: 1.0, constant: 0)
        
        // 2
        UIView.animateWithDuration(0.25, delay: 0.0, options: .CurveEaseOut , animations: {
            self.view.removeConstraint(self.topSpaceTalkButtonConstraint)
            self.view.addConstraint(newConstraint)
            self.view.layoutIfNeeded()
            }, completion: nil)
        
        // 3
        topSpaceTalkButtonConstraint = newConstraint
    }
    
    //MARK - collectionview
    
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
    

    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        //
    }
    
//    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
//    }
    
    
    //Todo: fix this eventually, it's pretty freaking sucky
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        var collectionView : UICollectionView
        var dataSource : NSArray
        if (self.feelingCollectionView == scrollView) {
            collectionView = self.feelingCollectionView
            dataSource = self.negativeFeelings
        } else {
            collectionView = self.aboutCollectionView
            dataSource = self.negativeFeelings
        }
        
        var point : CGPoint = targetContentOffset.memory;
        println("taget content offset x: \(point.x)")
        var layout : UICollectionViewFlowLayout  = collectionView.collectionViewLayout as UICollectionViewFlowLayout;
        
        
        //we want to find the closest item to the expected scroll stop (point.y)...
        var visibleWidth : CGFloat = collectionView.frame.size.width
        var itemWidth : CGFloat = layout.minimumInteritemSpacing + layout.itemSize.width;
        
        println("collection width: \(visibleWidth) item width: \(itemWidth)")
        
        //get index of nearest item we expect to scroll to
        //expectedLandingPoint / itemWidth
        //todo: ceil or floor might depend on scroll direction
        var expectedIndex = ceil((point.x - (itemWidth/2 - visibleWidth) / 2) / itemWidth)
        if (expectedIndex <= 0) {
            expectedIndex = 1.0
            println("setting index to 1")
        } else if (expectedIndex >= CGFloat(dataSource.count-1)) {
            expectedIndex--
            println("decrementing index")
        }
        println("Expected Index: \(expectedIndex)")
        var newTargetX = (itemWidth * expectedIndex) + (itemWidth - visibleWidth)/2
        println("new target x offset: \(newTargetX)")
        
        
        
        targetContentOffset.memory = CGPointMake(newTargetX, 0);
    }
    
    



}

