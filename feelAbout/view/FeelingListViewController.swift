//
//  FeelingListViewController.swift
//  feelAbout
//
//  Created by Jessica Berglund on 2/12/15.
//  Copyright (c) 2015 Jessica Berglund. All rights reserved.
//

import UIKit

class FeelingListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var feelingTableView: UITableView!
    var feelingsListArray : [FeelingAbout] = []
    var userSubmittedFeelingAbout : FeelingAbout?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let theFeeling = self.userSubmittedFeelingAbout {
            theFeeling.saveInBackgroundWithBlock({ (success: Bool, error: NSError!) -> Void in
                println("BOOYAHHHHH")
                self.loadFeelings()
            })
        }

    }
    
    func loadFeelings() {
        var query = PFQuery(className:"FeelingAbout")
//        query.whereKey("playerName", equalTo:"Sean Plott")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) feelings.")
                // Do something with the found objects
//                for object in objects {
//                    NSLog("%@", object.objectId)
//                }
                self.feelingsListArray = objects as [FeelingAbout]
                self.feelingTableView.reloadData()
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }
    
    //UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feelingsListArray.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:FeelingsTableViewCell = self.feelingTableView.dequeueReusableCellWithIdentifier("FeelingListCell") as FeelingsTableViewCell
        
        var feeling = self.feelingsListArray[indexPath.row].feeling
        var about = self.feelingsListArray[indexPath.row].about
        cell.feelingLabel.text = "I am feeling \(feeling) about \(about)."
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
    }
}
