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
    @IBOutlet weak var courseNameText: UITextField!
    @IBOutlet weak var courseItemText: UITextField!
    @IBOutlet weak var yourMarkTextField: UITextField!
    @IBOutlet weak var worthTextField: UITextField!
    var courses: [String:Course] = [:]
    var helper = HelperMethods()
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var addItemOutlet: UIButton!
    @IBOutlet weak var calculateButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        
        helper.db = DatabaseManager()
      
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        weightTextField.text = helper.myPickerData[1]
        let thePicker = UIPickerView()
        thePicker.delegate = self
        weightTextField.inputView = thePicker
        courseNameText.delegate = self
        courseItemText.delegate = self
        yourMarkTextField.delegate = self
        worthTextField.delegate = self
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 3000)
        helper.firstTextField = courseItemText
        helper.secondTextField = yourMarkTextField
        helper.thirdTextField = worthTextField
        helper.secondTextField.delegate = self
        helper.thirdTextField.delegate = self
    }
    
    @IBAction func addItemButtonPressed(_ sender: UIButton) {
        
        helper.firstTextField = helper.createTextField(x: 20, y: helper.yCounter , width: 157, height: 27, viewController: self)
        
        helper.firstTextField.delegate = self
        self.scrollView.addSubview(helper.firstTextField)
        helper.secondTextField = helper.createTextField(x: 186, y: helper.yCounter, width: 89, height: 27, viewController: self)
        self.scrollView.addSubview(helper.secondTextField)
        helper.secondTextField.delegate = self
        let worth = Float(helper.secondTextField.text!)
        if  worth == nil{
            helper.secondTextField.text = "0.0"
        }
        helper.thirdTextField = helper.createTextField(x:280 , y: helper.yCounter, width: 90, height: 27, viewController: self)
        helper.thirdTextField.delegate = self
        sender.frame = CGRect(x: 20 , y:helper.yCount , width: 121, height: 36)
        self.scrollView.addSubview(helper.thirdTextField)
        let yourMark = Float(helper.thirdTextField.text!)
        if yourMark  == nil{
            helper.thirdTextField.text = "0.0"
        }
        
        helper.yCount += 35
        helper.yCounter += 36
        helper.calculateDiff(yCount: &helper.yCount, yCounter: &helper.yCounter)
        helper.counter += 1
        if helper.counter >= 12{
            calculateButton.frame = CGRect(x: 61, y: helper.yCountForCalc, width: 270, height: 51)
            helper.yCountForCalc += 40
        }
        
        
    }
    
    
    @IBAction func calculateGradePressed(_ sender: UIButton) {
        
        helper.course = Course()
        if courseNameText.text == nil || courseNameText.text?.count == 0{
            let  alert =  helper.createAlert(title: "Error", message: "You must enter a course name")
            self.present(alert,animated: true,completion: nil)
        }
        else{
            
            helper.checkIfCourseeExists(courses: courses, courseName: courseNameText.text!, flag: &helper.checkFlag)
            if helper.checkFlag == 1{
                let alert = helper.createAlert(title: "Error", message: "The course name you are adding already exists")
                self.present(alert,animated: true,completion: nil)
                helper.checkFlag =  0
            }
            else{
                helper.course.setCourseName(courseName: courseNameText.text!)
                var weight = Float(weightTextField.text!)
                if weight == nil{
                    weight = 0.5
                }
                helper.course.setWeight(weight: weight!)
                helper.allTextField = helper.getTextfield(view: self.view)
                
                let len = helper.allTextField.count-1
                
                helper.addMarks(allTextField: helper.allTextField, len: len, course: &helper.course)
                let tot = helper.getTotalPercentOfCourse(marks: helper.course.marks)
                helper.course.setTotalPercentageOfCourse(totalPercentageOfCourse: tot)
                
                let currMark = helper.getCurrentMark(marks: helper.course.marks)
                helper.course.setCurrentMark(currentMark: currMark)
                
                let finalExam = helper.getFinalExamWorth(marks: helper.course.marks)
                helper.course.setFinalExamWorth(finalExamWorth: finalExam)
                                
            }
        }
        helper.yCount = 265.0
        helper.yCounter = 220.0
        self.performSegue(withIdentifier: "calculateGrade", sender:self)
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return helper.myPickerData.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return helper.myPickerData[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        weightTextField.text = helper.myPickerData[row]
        self.view.endEditing(true)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        courseNameText.endEditing(true)
        
        yourMarkTextField.endEditing(true)
        let yourMark = Float(yourMarkTextField.text!)
        if  yourMark == nil{
            yourMarkTextField.text = "0.0"
        }
        worthTextField.endEditing(true)
        let worth = Float(worthTextField.text!)
        if  worth == nil{
            worthTextField.text = "0.0"
        }
        helper.firstTextField.endEditing(true)
        
        helper.secondTextField.endEditing(true)
        let worth2 = Float(helper.secondTextField.text!)
        if  worth2 == nil{
            helper.secondTextField.text = "0.0"
        }
        helper.thirdTextField.endEditing(true)
        let yourMark2 = Float(helper.thirdTextField.text!)
        if  yourMark2 == nil{
            helper.thirdTextField.text = "0.0"
        }
        return true
        
    }
    
    
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! CalculateGradeViewController
        vc.array = helper.course.marks
        vc.course = helper.course
        vc.map = courses
        vc.helper.courseName = courseNameText
        vc.helper.courseWeight = weightTextField
        vc.helper.first = helper.firstTextField
        vc.helper.second = helper.secondTextField
        vc.helper.third = helper.thirdTextField
        vc.helper.allUIText = helper.allTextField
        vc.addItemButton = addItemOutlet
        vc.calcButton = calculateButton
        vc.map = courses
        vc.course  = helper.course
    }

    @IBAction func unwindToView(_ sender: UIStoryboardSegue) {
        guard let calc = sender.source as? CalculateGradeViewController else {return}
        print(calc.course!)
        courses[calc.course.courseName] = calc.course!
        
        courseNameText.text = ""
        weightTextField.text = "0.5"
        courseItemText.text = ""
        worthTextField.text = ""
        yourMarkTextField.text = ""
        helper.firstTextField.text = ""
        helper.secondTextField.text = ""
        helper.thirdTextField.text = ""
        let len = helper.allTextField.count-1
 
        helper.removeTextFields(len: len, textFields: &helper.allTextField)
        addItemOutlet.frame = CGRect(x: 20, y: 230, width: 121, height: 36)
        calculateButton.frame = CGRect(x: 61, y: 662, width: 270, height: 51)
        let secondTab = (self.tabBarController?.viewControllers?[1])! as!  CoursesViewController
        secondTab.dict = courses
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == helper.secondTextField{
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 5
        }
        else if textField == helper.thirdTextField{
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 5
            
        }
        else if textField == worthTextField{
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 5
        }
        else if textField == yourMarkTextField{
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 5
            
        }
        return true
    }
    
    @objc func appMovedToBackground() {
        
        helper.db.deleteTables()
        for (key,value) in courses{

            helper.db.insertCourse(courseName: key, weight: value.getWeight(), currentMark:value.getCurrentMark(), finalExamWorth: value.getFinalExamWorth(), totalPercentOfCourse: value.getTotalPercentOfCourse())
            for mark in value.marks{
                helper.db.insertMark(courseName: key,courseItem: mark.getCourseItem(), worth: mark.getWorth(), yourMark: mark.getYourMark(), percentageOfMark: mark.getPercentageOfCourse())
            }

        }
        helper.db.close()
    }
}
