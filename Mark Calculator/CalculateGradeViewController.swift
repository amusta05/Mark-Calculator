//
//  CalculateGradeViewController.swift
//  Mark Calculator
//
//  Created by Areeb Mustafa on 2020-04-06.
//  Copyright © 2020 Areeb Mustafa. All rights reserved.
//

import UIKit

class CalculateGradeViewController: UIViewController {
    
    var viewController: ViewController = ViewController()
    var array: [Mark] = []
    var helper: HelperMethods = HelperMethods()
    var course: Course!
    var map: [String: Course]!
    @IBOutlet weak var courseNameLabel: UILabel!
    
    @IBOutlet weak var currentMarkLabel: UILabel!
    
    
    @IBOutlet weak var courseCompletedLabel: UILabel!
    
    
    @IBOutlet weak var finalExamWorthLabel: UILabel!
    
    @IBOutlet weak var toGet50Label: UILabel!
    
    
    @IBOutlet weak var toGet60Label: UILabel!
    
    
    @IBOutlet weak var toget70Label: UILabel!
    
    @IBOutlet weak var toGet80Label: UILabel!
    
    @IBOutlet weak var toGet90Label: UILabel!
    
    
    @IBOutlet weak var toGet100Label: UILabel!
    var courseName: UITextField!
    var courseWeight: UITextField!
    var first: UITextField!
    var second: UITextField!
    var third: UITextField!
    var allUIText: [UITextField]!
    let myPicker = [String](arrayLiteral: "0.25", "0.5", "0.75", "1.0")
    
    var addItemButton: UIButton!
    var calcButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        courseNameLabel.text = course.getCourseName()
        
        let currentMark = String(format: "%.1f%%",getCurrentMark(marks: array))
        
        currentMarkLabel.text = currentMark
        courseCompletedLabel.text = ""
        let completed = String(format: "%.1f %%",helper.getTotalWorth(marks: array))
        courseCompletedLabel.text = completed
        
        let finalExam = String(format: "%.1f %%",getFinalExamWorth(marks: array))
        finalExamWorthLabel.text = finalExam
        
        if getFinalExamWorth(marks: array) == 0{
            toGet50Label.text = "0.0 %"
            toGet60Label.text = "0.0 %"
            toget70Label.text = "0.0 %"
            toGet80Label.text = "0.0 %"
            toGet90Label.text = "0.0 %"
            toGet100Label.text = "0.0 %"
        }
        else{
            let toGet50 = String(format: "%.1f %%",calculateToGetNMark(n: 50, array: array))
            toGet50Label.text = toGet50
            
            let toGet60 = String(format: "%.1f %%",calculateToGetNMark(n: 60, array: array))
            toGet60Label.text = toGet60
            
            let toGet70 = String(format: "%.1f %%",calculateToGetNMark(n: 70, array: array))
            toget70Label.text = toGet70
            
            let toGet80 = String(format: "%.1f %%",calculateToGetNMark(n: 80, array: array))
            toGet80Label.text = toGet80
            
            let toGet90 = String(format: "%.1f %%",calculateToGetNMark(n: 90, array: array))
            toGet90Label.text = toGet90
            
            let toGet100 = String(format: "%.1f %%",calculateToGetNMark(n: 100, array: array))
            toGet100Label.text = toGet100
        }
        
        
    }
    
    
    @IBAction func backButtonCalcPressed(_ sender: UIButton) {
        array.removeAll()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
//    @IBAction func addCourseButtonPressed(_ sender: UIButton) {
//
//
//
///     map[course.getCourseName()] = course
///        for (key, value) in map {
///            print("\(key) : \(value)")
////        }
//
//        self.dismiss(animated: true, completion: nil)
//        courseName.text = ""
//        courseWeight.text = "0.5"
//        first.text = ""
//        second.text = ""
//        third.text = ""
//        let len = allUIText.count-1
//        var i = 5
//        while i <= len{
//
//            allUIText[i].removeFromSuperview()
//            i = i + 1
//
//        }
//        addItemButton.frame = CGRect(x: 20, y: 230, width: 121, height: 36)
//        calcButton.frame = CGRect(x: 61, y: 662, width: 270, height: 51)
////        print("the map count is \(map.count)")
//
//    }
    
    func getFinalExamWorth(marks:[Mark]) -> Float {
        var total: Float = 0
        total = 100 - helper.getTotalWorth(marks: marks)
        return total
    }
    func getCurrentMark(marks: [Mark]) ->Float{
        var totalMark:  Float = 0
        let check = helper.getTotalWorth(marks: array)
        if check == 0{
            return 0.0
        }
        totalMark = helper.getTotalPercentOfCourse(marks: marks) / helper.getTotalWorth(marks: marks)
        //print("total Mark is \ (totalMark)" )
        totalMark = totalMark  * 100
        return totalMark
    }
    func calculateToGetNMark(n: Int,array:[Mark]) -> Float {
        
        let totalPercent  = helper.getTotalPercentOfCourse(marks: array)
        
        let finalExamWorth = getFinalExamWorth(marks: array)
        var total = Float(n) - totalPercent
        total = total / (finalExamWorth/100)
        //total = total / (
        
        return total
    }
    
    func wrapperViewDidLoad(){
        viewController.viewDidLoad()
    }
   
}
