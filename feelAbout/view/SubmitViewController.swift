//
//  SubmitViewController.swift
//  feelAbout
//
//  Created by Jessica Berglund on 2/11/15.
//  Copyright (c) 2015 Jessica Berglund. All rights reserved.
//

import UIKit

public class SubmitViewController: UIViewController {

    public var feelingAbout : FeelingAbout?
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBAction func submitButtonTapped(sender: AnyObject) {
        println("YESH!!!!!")
        if let theFeeling = self.feelingAbout {
            theFeeling.longDescription = self.descriptionTextView.text
            
            theFeeling.saveInBackgroundWithBlock({ (success: Bool, error: NSError!) -> Void in
                println("BOOYAHHHHH")
            })
        }
    }
}
