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
        
        themeButton(btnWatchRandomVideo)
        themeButton(btnVisitSpinMorePoi)
    }
    
    override func viewWillAppear(animated: Bool) {
        //Hide Nav Bar
        self.navigationController!.navigationBar.hidden = true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    
    //MARK: Button Theme
    
    func themeButton(btn:UIButton) {
        btn.layer.cornerRadius = 6
        btn.layer.borderWidth = 4
        btn.layer.borderColor = UIColor.whiteColor().CGColor
    }


    
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        var urlStr:String? = nil
        
        if let button = sender as? UIButton {
            
            if button == btnWatchRandomVideo {
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
                            urlStr = videoURLArray[randomVideoURLArrayIndex]

                        } else {
                            DebugLog("Cast failed")
                        }
                        
                } else {
                    DebugLog("Error parsing JSON: \(error)")
                }
            } else if button == btnVisitSpinMorePoi {
                urlStr = "http://spinmorepoi.com"
            }
        }

        
        if urlStr != nil {
        
            let url = NSURL(string:urlStr!)!
            let request = NSURLRequest(URL: url)
            
            if let webView = segue.destinationViewController.view as? UIWebView {
                webView.loadRequest(request)
            }
        } else {
            DebugLog("Didn't get urlStr")
        }
        
        
        
    }
    
}


