//
//  Mark.swift
//  Mark Calculator
//
//  Created by Areeb Mustafa on 2020-04-07.
//  Copyright © 2020 Areeb Mustafa. All rights reserved.
//

import Foundation

struct Mark {
    var courseItem: String
    var worth: Float
    var yourMark: Float
    var percentageOfCourseMark : Float
    
    //constructors
    init() {
        self.courseItem = ""
        self.worth = 0.0
        self.yourMark = 0.0
        self.percentageOfCourseMark = 0.0
        
    }
    init(courseItem: String, worth:Float,yourMark:Float, percentageOfCourseMark: Float) {
        self.courseItem = courseItem
        self.worth = worth
        self.yourMark = yourMark
        self.percentageOfCourseMark = percentageOfCourseMark
    }
    
    //setters and getters
    
    func getCourseItem() -> String{
        return self.courseItem
    }
    func getWorth() -> Float{
        return self.worth
    }
    func getYourMark() -> Float {
        return self.yourMark
    }
    func getPercentageOfCourse() -> Float {
        return self.percentageOfCourseMark;
    }
    
    mutating func setCourseItem(itemName:String) -> Void {
        self.courseItem =  itemName
    }
    mutating func setWorth(worth:Float) -> Void {
        self.worth =  worth
    }
    mutating func setYourMark(yourMark:Float) -> Void {
        self.yourMark = yourMark
    }
    mutating func setPercentageOfCourseMark(yourMark:Float) -> Void {
           self.percentageOfCourseMark = yourMark
    }
    // helper functions
    func calculatePercentageOfCourseMark() -> Float {
        let calcPercentage  = (self.worth/100) * self.yourMark
        return calcPercentage
    }
    mutating func updateCourseGradeMark() -> Void {
        self.percentageOfCourseMark = calculatePercentageOfCourseMark()
    }
    // added a commentt
    
}
