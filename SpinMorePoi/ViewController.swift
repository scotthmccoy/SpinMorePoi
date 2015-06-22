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
        
        //TODO: pass an error pointer to getDoc
        var error:NSError?
        
        if let data = FileSystemHelper.getDocAsDataWithResourceFallback("videoData.json"),
        dict = JSONHelper.parseJSON(data, error: &error) {
            if let posts = dict["posts"] as? Array<Dictionary<String, String>> {
                
                let randomPostIndex = Int(posts.count)
                DebugLog("randomPostIndex = \(randomPostIndex)")
            } else {
                DebugLog("Cast failed")
            }
            
        } else {
            DebugLog("Error parsing JSON: \(error)")
        }

    }
    
    
    
    

    

}

