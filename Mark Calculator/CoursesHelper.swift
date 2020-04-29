//
//  CoursesHelper.swift
//  Mark Calculator
//
//  Created by Areeb Mustafa on 2020-04-29.
//  Copyright © 2020 Areeb Mustafa. All rights reserved.
//

import Foundation
import UIKit
struct CoursesHelper {
    var yCounter: Double
    var yCount: Double
    var flag: Int
    var buttonClickedStr: String!
    var dict: [String: Course]
    var button: UIButton!
    init() {
        self.yCount = 797.0
        self.yCounter  = 120.0
        self.flag = 0
        self.buttonClickedStr = ""
        self.dict = [:]
        
    }
    
    
}
