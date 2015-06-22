//
//  FileGetter.swift
//  SpinMorePoi
//
//  Created by Scott McCoy on 6/19/15.
//  Copyright (c) 2015 ScottSoft. All rights reserved.
//

import Foundation

class FileSystemHelper {
    
    //MARK: Doc & Resource Paths
    class func docPathForFile(filename:String) -> String {
        var pathToDoc = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        pathToDoc = pathToDoc.stringByAppendingPathComponent(filename)
        return pathToDoc
    }
    
    class func resourcePathForFile(filename:String) -> String? {
        let fileNameWithoutExtension = filename.lastPathComponent.stringByDeletingPathExtension
        let fileExtension = filename.pathExtension
        return NSBundle.mainBundle().pathForResource(fileNameWithoutExtension, ofType: fileExtension)
    }
    
    //MARK: File Manipulation
    class func getDocAsStringWithResourceFallback(filename:String) -> String? {

        //Get the path to where the file will be if it's already in the docs folder
        let pathToDoc = FileSystemHelper.docPathForFile(filename)
        
        //Check to see if it exists
        let fileManager = NSFileManager.defaultManager()
        if !fileManager.fileExistsAtPath(pathToDoc) {

            //It doesn't exist! This is probably the first run of the app. Copy it from the bundle.
            
            //Get the bundle path for the file
            if let pathToResource = resourcePathForFile(filename) {
            
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
        var error:NSError?
        let ret = String(contentsOfFile: pathToDoc, encoding: NSUTF8StringEncoding, error: &error)
        
        if let error = error {
            DebugLog("Error getting file! \(error)")
        }
        
        return ret
    }

    class func deleteDoc(filename:String) {
        
        //Get the path to where the file will be if it's already in the docs folder
        var pathToDoc = FileSystemHelper.docPathForFile(filename)
        
        //Delete the file
        let fileManager = NSFileManager.defaultManager()
        var error:NSError?
        if !fileManager.removeItemAtPath(pathToDoc, error: &error) {
            DebugLog("Remove failed: \(error)")
        }
    }
    
    
    class func writeToDoc(filename:String, contents:String) {
        let pathToDoc = FileSystemHelper.docPathForFile(filename)
        contents.writeToFile(pathToDoc, atomically: false, encoding: NSUTF8StringEncoding, error: nil);
    }
}