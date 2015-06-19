//
//  FileGetterTests.swift
//  SpinMorePoi
//
//  Created by Scott McCoy on 6/19/15.
//  Copyright (c) 2015 ScottSoft. All rights reserved.
//

import UIKit
import XCTest


class FileSystemHelperTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_getDocAsStringWithResourceFallback_basic() {
        let contents:String? = FileSystemHelper.getDocAsStringWithResourceFallback("initialData.json")
        
        if (contents == nil) {
            XCTFail("File Contents nil!")
        }
    }
    
    func test_getDocAsStringWithResourceFallback_delete_before() {
        if filemgr.removeItemAtPath(filepath1, error: &error) {
            println("Remove successful")
        } else {
            println("Remove failed: \(error!.localizedDescription)")
        }
        
        let contents:String? = FileSystemHelper.getDocAsStringWithResourceFallback("initialData.json")
        
        if (contents == nil) {
            XCTFail("File Contents nil!")
        }
    }
    


}
