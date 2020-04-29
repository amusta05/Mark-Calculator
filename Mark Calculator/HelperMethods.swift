//
//  HelperMethods.swift
//  Mark Calculator
//
//  Created by Areeb Mustafa on 2020-04-10.
//  Copyright © 2020 Areeb Mustafa. All rights reserved.
//

import Foundation
import UIKit
class HelperMethods {
    
    var myPickerData = [String](arrayLiteral: "0.25", "0.5", "0.75", "1.0")
    var yCounter: Double
    var yCount: Double
    var yCountForCalc: Int
    var flag: Int
    var checkFlag: Int
    var counter: Int
    var course: Course!
    var allTextField: [UITextField]!
    var firstTextField: UITextField!
    var secondTextField: UITextField!
    var thirdTextField: UITextField!
    var db: DatabaseManager!
    var allUIText: [UITextField]!
    var courseName: UITextField!
    var courseWeight: UITextField!
    var first: UITextField!
    var second: UITextField!
    var third: UITextField!
    var addItemButton: UIButton!
    var calcButton: UIButton!
    init(){
        self.yCounter = 220.0
        self.yCount = 265.0
        self.yCountForCalc = 732
        self.flag = 0
        self.checkFlag = 0
        self.counter = 1
        self.allTextField = []
    }
    
    
    func createTextField(x: Double, y:Double,width:Double,height:Double,viewController:UIViewController) -> UITextField {
        
        let sampleTextField =  UITextField(frame: CGRect(x: x, y: y, width: width, height: height))
        sampleTextField.placeholder = ""
        sampleTextField.font = UIFont(name: "System", size: 12.0)
        sampleTextField.borderStyle = UITextField.BorderStyle.line
        sampleTextField.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField.keyboardType = UIKeyboardType.default
        sampleTextField.returnKeyType = UIReturnKeyType.default
        sampleTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        sampleTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        sampleTextField.backgroundColor = UIColor.systemGray5
        // sampleTextField.delegate = viewController.self as? UITextFieldDelegate
        viewController.view.addSubview(sampleTextField)
        return sampleTextField
        
    }
    func getTotalPercentOfCourse(marks: [Mark]) -> Float {
        var total: Float = 0.0
        for mark in marks{
            total = total + mark.getPercentageOfCourse()
        }
        return total
    }
    func getTotalWorth(marks: [Mark]) -> Float {
        var total: Float = 0.0
        for mark in marks{
            total = total + mark.getWorth()
        }
        return total
    }
    func getCurrentMark(marks: [Mark]) ->Float{
        var totalMark:  Float = 0
        let check = self.getTotalWorth(marks: marks)
        if check == 0{
            return 0.0
        }
        totalMark = self.getTotalPercentOfCourse(marks: marks) / self.getTotalWorth(marks: marks)
        //print("total Mark is \ (totalMark)" )
        totalMark = totalMark  * 100
        return totalMark
    }
    func getFinalExamWorth(marks:[Mark]) -> Float {
        var total: Float = 0
        total = 100 - self.getTotalWorth(marks: marks)
        return total
    }
    func getTextfield(view: UIView) -> [UITextField] {
        var results = [UITextField]()
        for subview in view.subviews as [UIView] {
            if let textField = subview as? UITextField {
                results += [textField]
            } else {
                results += getTextfield(view: subview)
            }
        }
        return results
    }
    func createAlert(title: String,message: String) -> UIAlertController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            
        }))
        
        return alert
    }
    
    func addMarks(allTextField: [UITextField], len: Int, course: inout Course) -> Void {
        var i = 2
        while i < len{
            
            var mark = Mark()
            mark.setCourseItem(itemName: allTextField[i].text!)
            i = i+1
            var worth = Float(allTextField[i].text!)
            if  worth == nil{
                worth = 0.0
            }
            mark.setWorth(worth: worth!)
            i = i+1
            var yourMark = Float(allTextField[i].text!)
            if yourMark  == nil{
                yourMark = 0.0
            }
            mark.setYourMark(yourMark: yourMark!)
            let total = mark.calculatePercentageOfCourseMark()
            mark.updateCourseGradeMark(total: total)
            course.marks.append(mark)
            i = i+1
        }
    }
    
    func setTextField(string: inout String){
        string = ""
        
    }
    func calculateToGetNMark(n: Int,array:[Mark]) -> Float {
         
         let totalPercent  = self.getTotalPercentOfCourse(marks: array)
         
        let finalExamWorth = self.getFinalExamWorth(marks: array)
         var total = Float(n) - totalPercent
         total = total / (finalExamWorth/100)
         return total
    }

  
    func checkIfCourseeExists(courses: [String: Course],courseName:String, flag: inout Int ){
        
        for (key,_) in courses{
            
            if key == courseName{
                flag = 1
            }
        }
        
    }
    
    func removeTextFields(len: Int, textFields: inout [UITextField]!){
        var i = 5
        while i <= len{
            
            textFields[i].removeFromSuperview()
            i = i + 1
            
        }
        
    }
    func calculateDiff(yCount: inout Double, yCounter: inout Double){
        
        if yCount - yCounter != 44{
            var totalDif = 44
            let  diff = yCount - yCounter
            totalDif = totalDif - Int(diff)
            yCount = yCount + Double(totalDif)
            
        }
    }
    func getButtons(view: UIView) -> [UIButton] {
        var results = [UIButton]()
        for subview in view.subviews as [UIView] {
            if let textField = subview as? UIButton {
                results += [textField]
            } else {
                results += getButtons(view: subview)
            }
        }
        return results
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
}
