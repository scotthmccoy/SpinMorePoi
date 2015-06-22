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

    let fileName = "initialData.json"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_getDocAsStringWithResourceFallback_basic() {
        XCTAssert(FileSystemHelper.getDocAsStringWithResourceFallback(fileName) != nil, "File contents nil!")
    }
    
    func test_getDocAsStringWithResourceFallback_delete_before() {
        FileSystemHelper.deleteDoc(fileName)
        XCTAssert(FileSystemHelper.getDocAsStringWithResourceFallback(fileName) != nil, "File contents nil!")
    }
    


}
