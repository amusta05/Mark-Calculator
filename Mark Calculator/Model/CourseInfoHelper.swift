//
//  CourseInfoHelper.swift
//  Mark Calculator
//
//  Created by Areeb Mustafa on 2020-04-29.
//  Copyright © 2020 Areeb Mustafa. All rights reserved.
//

import Foundation
import UIKit

struct CourseInfoHelper {
    
    var yCounter: Double
    var deleteButton: UIButton!
    var map: [String: Course]
    init() {
        self.yCounter = 367.0
        self.map = [:]
    }
}
