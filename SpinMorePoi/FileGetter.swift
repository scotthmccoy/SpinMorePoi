//
//  FileGetter.swift
//  SpinMorePoi
//
//  Created by Scott McCoy on 6/19/15.
//  Copyright (c) 2015 ScottSoft. All rights reserved.
//

import Foundation

class FileGetter {
    
    
    func getDocAsStringWithResourceFallback(filename:String) -> String? {

        //Get the path to where the file will be if it's already in the docs folder
        var pathToDoc = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        pathToDoc.stringByAppendingPathComponent(filename)
        
        //Check to see if it exists
        let fileManager = NSFileManager.defaultManager()
        if !fileManager.fileExistsAtPath(pathToDoc) {

            //It doesn't exist! This is probably the first run of the app. Copy it from the bundle.
            
            //Split the file into name and extension
            let fileNameWithoutExtension = filename.lastPathComponent.stringByDeletingPathExtension
            let fileExtension = filename.pathExtension
            
            //Get the bundle path for the file
            if let pathToResource = NSBundle.mainBundle().pathForResource(fileNameWithoutExtension, ofType: fileExtension) {
            
                //Copy it from the bundle to the docs folder
                var error:NSError?
                fileManager.copyItemAtPath(pathToResource, toPath:pathToDoc, error:&error)
            } else {
                DebugLog("File not in bundle!")
                //TODO: Print Bundle Contents
                return nil
            }
        }
        
        //File should now exist at the doc path.
        if !fileManager.fileExistsAtPath(pathToDoc) {
            DebugLog("File doesn't exist at \(pathToDoc) after copying from bundle.")
            return nil
        }
        
        //TODO: Open the doc and return it as a string.
        return "TEST"
    }
 
    

    
    

    
}