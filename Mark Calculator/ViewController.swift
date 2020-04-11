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
    var counter = 0

    @IBOutlet weak var scrollView: UIScrollView!
    
    
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
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 5000)
       
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
            mark.setCourseItem(itemName: courseItemText.text!)
            var yourMark = Float(yourMarkTextField.text!)
            if yourMark == nil{
                yourMark = 0.0
                yourMarkTextField.text = "0.0"
                mark.setYourMark(yourMark: yourMark!)
            }
            else{
                 mark.setYourMark(yourMark: yourMark!)
            }
            
            var markWorth = Float(worthTextField.text!)
            if markWorth == nil {
                markWorth = 0.0
                worthTextField.text = "0.0"
                mark.setWorth(worth: markWorth!)
            
            }
            else{
                 mark.setWorth(worth: markWorth!)
            }
           
            let totalPercent = mark.calculatePercentageOfCourseMark()
            mark.setPercentageOfCourseMark(yourMark: totalPercent)
            course.marks.append(mark)
            
            

            let firstTextField = helper.createTextField(x: 20, y: 220 , width: 157, height: 27, viewController: self)
            
            firstTextField.delegate = self
            //self.scrollView.addSubview(firstTextField)
            self.scrollView.addSubview(firstTextField)
            //firstTextField.e
            let secondTextField = helper.createTextField(x: 186, y: 220, width: 89, height: 27, viewController: self)
            secondTextField.delegate = self
            self.scrollView.addSubview(secondTextField)
            
            let thirdTextField = helper.createTextField(x:280 , y: 220, width: 90, height: 27, viewController: self)
            thirdTextField.delegate = self
            self.scrollView.addSubview(thirdTextField)
            
            
            yCount += 35
            flag = 1
        }
        else{
            let firstTextField = helper.createTextField(x: 20, y: yCounter , width: 157, height: 27, viewController: self)
                      
            firstTextField.delegate = self
            self.scrollView.addSubview(firstTextField)
            let secondTextField = helper.createTextField(x: 186, y: yCounter, width: 89, height: 27, viewController: self)
            self.scrollView.addSubview(secondTextField)
            secondTextField.delegate = self
            let thirdTextField = helper.createTextField(x:280 , y: yCounter, width: 90, height: 27, viewController: self)
            thirdTextField.delegate = self
            sender.frame = CGRect(x: 20 , y:yCount , width: 121, height: 36)
             self.scrollView.addSubview(thirdTextField)
            yCount += 35
            yCounter += 36
           
            
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
        courseNameText.endEditing(true)
        courseItemText.endEditing(true)
        yourMarkTextField.endEditing(true)
        worthTextField.endEditing(true)
        return true
        
    }
    
    
    
}



