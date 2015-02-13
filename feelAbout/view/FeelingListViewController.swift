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
    var feelingsListArray = ["I am feeling ok about my app", "I am feeling iffy about stuffss"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feelingsListArray.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:FeelingsTableViewCell = self.feelingTableView.dequeueReusableCellWithIdentifier("FeelingListCell") as FeelingsTableViewCell
        
        cell.feelingLabel.text = self.feelingsListArray[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
    }
}
