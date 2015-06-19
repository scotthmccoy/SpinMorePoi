//
//  ViewController.swift
//  SpinMorePoi
//
//  Created by Scott McCoy on 6/15/15.
//  Copyright (c) 2015 ScottSoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnWatchRandomVideo: UIButton!
    @IBOutlet weak var btnVisitSpinMorePoi: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    //MARK: IBActions
    
    @IBAction func btnVisitSpinMorePoiClick(sender: UIButton) {
        DebugLogWhereAmI()
        let url = NSURL(string: "http://spinmorepoi.com")!
        UIApplication.sharedApplication().openURL(url)
    }
    
    @IBAction func btnWatchRandomPoiVideo(sender: UIButton) {
        DebugLogWhereAmI()
        
        JSONGetter.downloadAndParseJSON("http://www.spinmorepoi.com/?json=1&count=-1",
            successBlock: { (dict) -> () in
                DebugLog("dict = \(dict)")
            },
            failureBlock: { (error) -> () in
                DebugLog("error = \(error)")
            }
        );
    }
    
    
    
    

    

}

