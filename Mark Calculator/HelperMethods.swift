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
    
    init(){
        
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
    
    
    
}
