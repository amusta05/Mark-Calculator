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
    var yCounter  = 220.0
    
    @IBOutlet weak var courseNameText: UITextField!
    
    @IBOutlet weak var courseItemText: UITextField!
    @IBOutlet weak var yourMarkTextField: UITextField!
    @IBOutlet weak var worthTextField: UITextField!
    var flag = 0
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
    
    @IBOutlet weak var calculateButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //print(courseItemText.text!)
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
            createAlert(title: "Error", message: "You must enter a course name")
        }
        else{
            course.setCourseName(courseName: courseNameText.text!)
            var weight = Float(weightTextField.text!)
            if weight == nil{
                weight = 0.5
            }
            course.setWeight(weight: weight!)
            //weightTextField.text = myPickerData[row]
            let allTextField = getTextfield(view: self.view)
            //print("length is \(allTextField.count)")
            let len = allTextField.count-1
            
            var i = 2
            while i < len{
                //print("comes here")
                var mark = Mark()
                mark.setCourseItem(itemName: allTextField[i].text!)
                i = i+1
                var worth = Float(allTextField[i].text!)
                if  worth == nil{
                    worth = 0.0
                }
                mark.setWorth(worth: worth!)
                i = i+1
                //print("i is \(i)")
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
            for mark in course.marks {
                print(mark.getCourseItem())
                print(mark.getWorth())
                print(mark.getYourMark())
            }
            print(weight!)
            
        }
        
        
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! CalculateGradeViewController
        vc.array = course.marks
        vc.course = course
    }
    func createAlert(title: String,message: String) -> Void{
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        
        }))
        self.present(alert,animated: true,completion: nil)
    }
    
  
    
}



