//
//  ViewController.swift
//  Mark Calculator
//
//  Created by Areeb Mustafa on 2020-04-06.
//  Copyright © 2020 Areeb Mustafa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate {
    
    @IBOutlet weak var weightTextField: UITextField!
    let myPickerData = [String](arrayLiteral: "0.25", "0.5", "0.75", "1.0")
    var xCounter = 0.0
    var yCounter  = 256.0
    
    @IBOutlet weak var courseNameText: UITextField!
    
    @IBOutlet weak var courseItemText: UITextField!
    @IBOutlet weak var yourMarkTextField: UITextField!
    @IBOutlet weak var worthTextField: UITextField!
    var flag = 0
    var course: Course!
    var mark: Mark!
    var courses: [String:Course] = [:]
    var yCount: Double = 265.0
    var helper = HelperMethods()
    var counter = 1
    var stealer: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    var globalVar: Float = 0
    var globalVar2:Float = 0
    var globalVar3: Float = 0
    var globalVar4:Float = 0
    
    var firstTextField: UITextField!
    var secondTextField: UITextField!
    var thirdTextField: UITextField!
    var yCountForCalc: Int = 732
    
    @IBOutlet weak var calculateButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let thePicker = UIPickerView()
        thePicker.delegate = self
        weightTextField.inputView = thePicker
        courseNameText.delegate = self
        courseItemText.delegate = self
        yourMarkTextField.delegate = self
        worthTextField.delegate = self
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 3000) 
        
        firstTextField = courseItemText
        secondTextField = yourMarkTextField
        thirdTextField = worthTextField
    }
    
    
    @IBAction func addItemButtonPressed(_ sender: UIButton) {
        
        
        //scrollView.contentSize = CGSize(width: self.view.frame.width, height: 1000)
        if flag == 0{
            sender.frame = CGRect(x: 20 , y: 265 , width: 121, height: 36)
            course = Course()
            course.setCourseName(courseName: courseNameText.text!)
            
            var weight = Float(weightTextField.text!)
            if weight == nil{
                weight = 0.5;
                course.setWeight(weight: weight!)
                weightTextField.text = myPickerData[1]
            }
            else{
                course.setWeight(weight: weight!)
            }
            
            mark = Mark()
            // course item gets set
            mark.setCourseItem(itemName: courseItemText.text!)
            
            mark.setWorth(worth: globalVar)
            mark.setYourMark(yourMark: globalVar2)
            
            
            
            
            let totalPercent = mark.calculatePercentageOfCourseMark()
            mark.setPercentageOfCourseMark(yourMark: totalPercent)
            course.marks.append(mark)
            
            mark = Mark()
            
            firstTextField = helper.createTextField(x: 20, y: 220 , width: 157, height: 27, viewController: self)
            
            firstTextField.delegate = self
            
            self.scrollView.addSubview(firstTextField)
            secondTextField = helper.createTextField(x: 186, y: 220, width: 89, height: 27, viewController: self)
            secondTextField.delegate = self
            self.scrollView.addSubview(secondTextField)
            
            mark.setWorth(worth: globalVar3)
            
            thirdTextField = helper.createTextField(x:280 , y: 220, width: 90, height: 27, viewController: self)
            thirdTextField.delegate = self
            self.scrollView.addSubview(thirdTextField)
            mark.setYourMark(yourMark: globalVar4)
            
            
            course.marks.append(mark)
            
            yCount += 35
            flag = 1
        }
        else{
            mark = Mark()
            firstTextField = helper.createTextField(x: 20, y: yCounter , width: 157, height: 27, viewController: self)
            
            firstTextField.delegate = self
            self.scrollView.addSubview(firstTextField)
            secondTextField = helper.createTextField(x: 186, y: yCounter, width: 89, height: 27, viewController: self)
            self.scrollView.addSubview(secondTextField)
            secondTextField.delegate = self
            mark.setWorth(worth: globalVar3)
            
            thirdTextField = helper.createTextField(x:280 , y: yCounter, width: 90, height: 27, viewController: self)
            thirdTextField.delegate = self
            sender.frame = CGRect(x: 20 , y:yCount , width: 121, height: 36)
            self.scrollView.addSubview(thirdTextField)
            mark.setYourMark(yourMark: globalVar4)
            course.marks.append(mark)
            
            
            yCount += 35
            yCounter += 36
            print(mark.yourMark)
            
            
        }
        if yCount-yCounter != 44{
            var totalDif = 44
            let  diff = yCount-yCounter
            totalDif = totalDif - Int(diff)
            yCount = yCount + Double(totalDif)
            
        }
        counter += 1
        if counter >= 12{
            calculateButton.frame = CGRect(x: 61, y: yCountForCalc, width: 270, height: 51)
            yCountForCalc += 40
        }
        
        
    }
    
    
    @IBAction func calculateGradePressed(_ sender: UIButton) {
        // update couree name and weight
        self.performSegue(withIdentifier: "calculateGrade", sender:self)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPickerData.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myPickerData[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        weightTextField.text = myPickerData[row]
        self.view.endEditing(true)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var markWorth = Float(worthTextField.text!)
        if markWorth == nil{
            worthTextField.text = "0.0"
            markWorth = 0.0
            globalVar = markWorth!
        }
        else{
            globalVar =  markWorth!
        }
        var yourMark = Float(yourMarkTextField.text!)
        if yourMark == nil{
            yourMarkTextField.text = "0.0"
            yourMark = 0.0
            globalVar2 =  yourMark!
        }
        else{
            globalVar2 = yourMark!
        }
        var markWorth2 = Float(secondTextField.text!)
        if markWorth2 == nil{
            secondTextField.text = "0.0"
            markWorth2 = 0.0
            globalVar3 = markWorth2!
        }
        else{
            globalVar3 = markWorth2!
        }
        var yourMark2 = Float(thirdTextField.text!)
        if yourMark2 == nil{
            thirdTextField.text = "0.0"
            yourMark2 = 0.0
            globalVar4 =  yourMark2!
        }
        else{
            globalVar4  = yourMark2!
        }
       
        
        
        
        courseNameText.endEditing(true)
        courseItemText.endEditing(true)
        yourMarkTextField.endEditing(true)
        worthTextField.endEditing(true)
        firstTextField.endEditing(true)
        secondTextField.endEditing(true)
        thirdTextField.endEditing(true)
        return true
        
    }
    // make this a helper function later
    
    
    
}



