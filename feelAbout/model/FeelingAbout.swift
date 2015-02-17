//
//  FeelingAbout.swift
//  feelAbout
//
//  Created by Jessica Berglund on 2/4/15.
//  Copyright (c) 2015 Jessica Berglund. All rights reserved.
//

import Foundation

public class FeelingAbout : PFObject, PFSubclassing {
    
    override public class func load() {
        self.registerSubclass()
    }
    
    public class func parseClassName() -> String! {
        return "FeelingAbout"
    }
    
    override init() {
        super.init();
    }
    
    init(feeling : String, about : String, byUser : PFUser) {
        super.init()
        self.feeling = feeling
        self.about = about
        self.byUser = byUser
    }
    
    @NSManaged public var feeling : NSString
    @NSManaged public var about : NSString
    @NSManaged public var longDescription : NSString
    @NSManaged public var byUser : PFUser
}