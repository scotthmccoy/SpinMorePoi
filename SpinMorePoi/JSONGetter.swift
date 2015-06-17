//
//  JSONGetter.swift
//  SpinMorePoi
//
//  Created by Scott McCoy on 6/17/15.
//  Copyright (c) 2015 ScottSoft. All rights reserved.
//

import Foundation


class JSONGetter {
    
    class func downloadAndParseJSON(urlString: String, successBlock:(Dictionary<String,AnyObject>)->(), failureBlock:(NSError?)->()) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            if let jsonData = JSONGetter.getJSON(urlString) {
                if let dict = JSONGetter.parseJSON(jsonData) {
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        successBlock(dict)
                    }
                }
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                failureBlock(nil)
            }
        }
    }

    private class func getJSON(urlString: String) -> NSData? {
        if let url = NSURL(string: urlString){
            var error: NSError?
            if let ret = NSData(contentsOfURL: url, options: NSDataReadingOptions.DataReadingUncached, error: &error) {
                return ret
            }
            DebugLog("ERROR \(error)")
        }
        
        return nil
    }

    private class func parseJSON(inputData: NSData) -> Dictionary<String,AnyObject>? {
        var error: NSError?
        if let ret = NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers, error: &error) as? Dictionary<String,AnyObject> {
            return ret
        }
        DebugLog("ERROR \(error)")
        return nil
    }
}

