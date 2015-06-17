//
//  JSONGetter.swift
//  SpinMorePoi
//
//  Created by Scott McCoy on 6/17/15.
//  Copyright (c) 2015 ScottSoft. All rights reserved.
//

import Foundation

func getJSON(urlToRequest: String) -> NSData? {
    if let url = NSURL(string: urlToRequest){
        var error: NSError?
        if let ret = NSData(contentsOfURL: url, options: NSDataReadingOptions.DataReadingUncached, error: &error) {
            return ret
        }
        DebugLog("ERROR \(error)")
    }
    
    return nil
}

func parseJSON(inputData: NSData) -> Dictionary<String,AnyObject>? {
    var error: NSError?
    if let ret = NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers, error: &error) as? Dictionary<String,AnyObject> {
        return ret
    }
    DebugLog("ERROR \(error)")
    return nil
}