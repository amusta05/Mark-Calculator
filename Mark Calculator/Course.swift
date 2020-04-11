//
//  Course.swift
//  Mark Calculator
//
//  Created by Areeb Mustafa on 2020-04-07.
//  Copyright © 2020 Areeb Mustafa. All rights reserved.
//

import Foundation

struct Course {
    var courseName: String
    var weight: Float
    var marks: [Mark]
    var currentMark: Float
    var finalExamWorth: Float
    var totalPercentageOfCourse: Float
    
    // constructors
    init(){
        self.courseName = ""
        self.weight = 0.0
        self.marks = []
        self.currentMark = 0.0
        self.finalExamWorth = 100.0
        self.totalPercentageOfCourse = 0.0
        
    }
    init(courseName: String,weight:Float,currentMark:Float,finalExamWorth:Float,totalPer:Float) {
        self.courseName = courseName
        self.weight = weight
        self.currentMark = currentMark
        self.finalExamWorth = finalExamWorth
        self.marks = []
        self.totalPercentageOfCourse = totalPer
        
    }
    // setters and getters
    func getCourseName() -> String {
        return self.courseName
    }
    func getWeight() -> Float {
        return self.weight
    }
    func getCurrentMark() -> Float {
        return self.currentMark
    }
    
    func getFinalExamWorth() -> Float {
        return self.finalExamWorth
    }
    func getMarks() -> [Mark] {
        return self.marks
    }
    func getTotalPercentOfCourse() -> Float {
        return self.totalPercentageOfCourse
    }
    
    mutating func setCourseName(courseName: String) -> Void {
        self.courseName = courseName
    }
    mutating func setWeight(weight: Float) -> Void {
        self.weight = weight
    }
    mutating func setCurrentMark(finalExamWorth: Float) -> Void {
        self.finalExamWorth = finalExamWorth
    }
    mutating  func setTotalPercentageOfCourse(totalPercentageOfCourse: Float) -> Void {
        self.totalPercentageOfCourse = totalPercentageOfCourse
    }
    
}
