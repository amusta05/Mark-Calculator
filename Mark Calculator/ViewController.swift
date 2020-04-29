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
    var myPickerData = [String](arrayLiteral: "0.25", "0.5", "0.75", "1.0")
    var xCounter = 0.0
    var yCounter  = 220.0
    
    @IBOutlet weak var courseNameText: UITextField!
    
    @IBOutlet weak var courseItemText: UITextField!
    @IBOutlet weak var yourMarkTextField: UITextField!
    @IBOutlet weak var worthTextField: UITextField!
    var flag = 0
    var checkFlag = 0
    var course: Course!
    var courses: [String:Course] = [:]
    var yCount: Double = 265.0
    var helper = HelperMethods()
    var counter = 1
    var stealer: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    var globalString:String = ""
    
    var firstTextField: UITextField!
    var secondTextField: UITextField!
    var thirdTextField: UITextField!
    var yCountForCalc: Int = 732
    var allTextField: [UITextField]!
    
    @IBOutlet weak var addItemOutlet: UIButton!
    @IBOutlet weak var calculateButton: UIButton!
    var db: DatabaseManager!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        db = DatabaseManager()
      
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)

        
        weightTextField.text = myPickerData[1]
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
        secondTextField.delegate = self
        thirdTextField.delegate = self
    }
    
    @IBAction func addItemButtonPressed(_ sender: UIButton) {
        
        firstTextField = helper.createTextField(x: 20, y: yCounter , width: 157, height: 27, viewController: self)
        
        firstTextField.delegate = self
        self.scrollView.addSubview(firstTextField)
        secondTextField = helper.createTextField(x: 186, y: yCounter, width: 89, height: 27, viewController: self)
        self.scrollView.addSubview(secondTextField)
        secondTextField.delegate = self
        let worth = Float(secondTextField.text!)
        if  worth == nil{
            secondTextField.text = "0.0"
        }
        thirdTextField = helper.createTextField(x:280 , y: yCounter, width: 90, height: 27, viewController: self)
        thirdTextField.delegate = self
        sender.frame = CGRect(x: 20 , y:yCount , width: 121, height: 36)
        self.scrollView.addSubview(thirdTextField)
        let yourMark = Float(thirdTextField.text!)
        if yourMark  == nil{
            thirdTextField.text = "0.0"
        }
        
        yCount += 35
        yCounter += 36
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
        
        course = Course()
        if courseNameText.text == nil || courseNameText.text?.count == 0{
            let  alert =  helper.createAlert(title: "Error", message: "You must enter a course name")
           self.present(alert,animated: true,completion: nil)
        }
        else{
            
            for (key,_) in courses{
                
                if key == courseNameText.text{
                    checkFlag = 1
                }
            }
            if checkFlag == 1{
                let alert = helper.createAlert(title: "Error", message: "The course name you are adding already exists")
                self.present(alert,animated: true,completion: nil)
                checkFlag =  0
            }
            else{
                course.setCourseName(courseName: courseNameText.text!)
                var weight = Float(weightTextField.text!)
                if weight == nil{
                    weight = 0.5
                }
                course.setWeight(weight: weight!)
                allTextField = helper.getTextfield(view: self.view)
                
                let len = allTextField.count-1
                
                helper.addMarks(allTextField: allTextField, len: len, course: &course)
                let tot = helper.getTotalPercentOfCourse(marks: course.marks)
                course.setTotalPercentageOfCourse(totalPercentageOfCourse: tot)
                
                let currMark = helper.getCurrentMark(marks: course.marks)
                course.setCurrentMark(currentMark: currMark)
                
                let finalExam = helper.getFinalExamWorth(marks: course.marks)
                course.setFinalExamWorth(finalExamWorth: finalExam)
                                
            }
            
            
        }
        yCount = 265.0
        yCounter = 220.0
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
        firstTextField.endEditing(true)
        
        secondTextField.endEditing(true)
        let worth2 = Float(secondTextField.text!)
        if  worth2 == nil{
            secondTextField.text = "0.0"
        }
        thirdTextField.endEditing(true)
        let yourMark2 = Float(thirdTextField.text!)
        if  yourMark2 == nil{
            thirdTextField.text = "0.0"
        }
        return true
        
    }
    
    
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! CalculateGradeViewController
        vc.array = course.marks
        vc.course = course
        vc.map = courses
        vc.courseName = courseNameText
        vc.courseWeight = weightTextField
        vc.first = firstTextField
        vc.second = secondTextField
        vc.third = thirdTextField
        vc.allUIText = allTextField
        vc.addItemButton = addItemOutlet
        vc.calcButton = calculateButton
        vc.map = courses
        vc.course  = course
        
        //vc.wrapperViewDidLoad() = self.wrapper()
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
        firstTextField.text = ""
        secondTextField.text = ""
        thirdTextField.text = ""
        let len = allTextField.count-1
        var i = 5
        while i <= len{
            
            allTextField[i].removeFromSuperview()
            i = i + 1
            
        }
        addItemOutlet.frame = CGRect(x: 20, y: 230, width: 121, height: 36)
        calculateButton.frame = CGRect(x: 61, y: 662, width: 270, height: 51)
        let secondTab = (self.tabBarController?.viewControllers?[1])! as!  CoursesViewController
        secondTab.dict = courses
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == secondTextField{
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 5
        }
        else if textField == thirdTextField{
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
        
        db.deleteTables()
        for (key,value) in courses{

            db.insertCourse(courseName: key, weight: value.getWeight(), currentMark:value.getCurrentMark(), finalExamWorth: value.getFinalExamWorth(), totalPercentOfCourse: value.getTotalPercentOfCourse())
            for mark in value.marks{
                db.insertMark(courseName: key,courseItem: mark.getCourseItem(), worth: mark.getWorth(), yourMark: mark.getYourMark(), percentageOfMark: mark.getPercentageOfCourse())
            }

        }
        db.close()
    }
  

}



