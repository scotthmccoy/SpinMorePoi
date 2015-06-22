//
//  Int.swift
//  SpinMorePoi
//
//  Created by Scott McCoy on 6/22/15.
//  Copyright (c) 2015 ScottSoft. All rights reserved.
//

import Foundation

extension Int {
    
    init(minForRandom:Int, maxForRandom:Int) {
        var rangeSize = maxForRandom - minForRandom + 1
        self = Int(arc4random_uniform(UInt32(rangeSize))) + minForRandom
    }
    
    init (roll:Int) {
        self = Int(minForRandom: 1, maxForRandom:roll)
    }
}
