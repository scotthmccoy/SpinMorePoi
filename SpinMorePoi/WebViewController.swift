//
//  WebViewController.swift
//  SpinMorePoi
//
//  Created by Scott McCoy on 7/7/15.
//  Copyright (c) 2015 ScottSoft. All rights reserved.
//

import UIKit

class WebViewController : UIViewController {
    
    override func viewWillAppear(animated: Bool) {
        //Show Nav Bar
        self.navigationController!.navigationBar.hidden = false
    }
    
}