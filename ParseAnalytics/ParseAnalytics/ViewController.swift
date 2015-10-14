//
//  ViewController.swift
//  ParseAnalytics
//
//  Created by Nick Kibish on 13.10.15.
//  Copyright © 2015 Nick Kibish. All rights reserved.
//

// 7ea6e01f516b0a3ba8e9df75d1f9a6f6
// bf12974d70818a08199d17d5e2bae630
// 8434739
// +19078917986

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addEvent(sender: AnyObject) {
        let dimensions = [
            "category" : "politics",    // What type of news is this?
            "dayType" : "weekday",     // Is it a weekday or the weekend?
            "userType" : "single user"
        ]
        
        // Send the dimensions to Parse along with the 'read' event
        PFAnalytics.trackEvent("write", dimensions: dimensions)
    }
    

}

