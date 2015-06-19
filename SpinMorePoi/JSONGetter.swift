//
//  JSONGetter.swift
//  SpinMorePoi
//
//  Created by Scott McCoy on 6/17/15.
//  Copyright (c) 2015 ScottSoft. All rights reserved.
//

import Foundation


class JSONGetter {
    
    class func downloadAndParseJSON(urlString: String, successBlock:(dict: Dictionary<String,AnyObject>)->(), failureBlock:(error: NSError?)->()) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            var error:NSError?
            
            //Get and parse the JSON. If both are successful, run the successBlock and bail.
            if let jsonData = JSONGetter.getJSON(urlString, error:&error) {
                if let dict = JSONGetter.parseJSON(jsonData, error:&error) {
                    dispatch_async(dispatch_get_main_queue()) {
                        successBlock(dict: dict)
                    }
                    return
                }
            }
            
            //If either getting or parsing the JSON failed, run the failureBlock
            dispatch_async(dispatch_get_main_queue()) {
                failureBlock(error: error)
            }
        }
    }

    //MARK: Private Methods
    private class func getJSON(urlString: String, error:NSErrorPointer) -> NSData? {
        if let url = NSURL(string: urlString){
            if let ret = NSData(contentsOfURL: url, options: NSDataReadingOptions.DataReadingUncached, error:error) {
                return ret
            }
            DebugLog("ERROR \(error)")
        }
        
        return nil
    }

    private class func parseJSON(inputData: NSData, error:NSErrorPointer) -> Dictionary<String,AnyObject>? {
        if let ret = NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers, error:error) as? Dictionary<String,AnyObject> {
            return ret
        }
        DebugLog("ERROR \(error)")
        return nil
    }
}

