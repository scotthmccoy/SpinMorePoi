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
        
        //Read and parse the json file
        var error:NSError?
        if let data = FileSystemHelper.getDocAsDataWithResourceFallback("videoData.json"),
        dict = JSONHelper.parseJSON(data, error: &error) {

            //Pull the posts out
            if let posts = dict["posts"] as? Array<Dictionary<String, AnyObject>> {
                
                //Reduce the posts array to an array containing non-blank video urls
                let videoURLArray = posts.reduce([String](), combine: {
                
                    if let fields = $1["custom_fields"] as? Dictionary<String, AnyObject>,
                    dp_video_url = fields["dp_video_url"] as? Array<String>,
                    url = dp_video_url.first as String? where count(url) > 0 {
                        //Return the reduce-to array with url added to the end
                        return $0 + [url]
                    }
                    
                    //Unable to extract the video url!
                    //Return the reduce-to array
                    return $0
                })
                
                //Pick a random url
                let randomVideoURLArrayIndex = Int(roll: videoURLArray.count) - 1
                let randomURLStr = videoURLArray[randomVideoURLArrayIndex]
                
                //Open the URL
                if let url = NSURL(string:randomURLStr) {
                    UIApplication.sharedApplication().openURL(url)
                } else {
                    DebugLog("Couldn't create url from string \(randomURLStr)")
                }
                
            } else {
                DebugLog("Cast failed")
            }
            
        } else {
            DebugLog("Error parsing JSON: \(error)")
        }
    }
}

