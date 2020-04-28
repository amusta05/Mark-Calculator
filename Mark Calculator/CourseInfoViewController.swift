//
//  CourseInfoViewController.swift
//  Mark Calculator
//
//  Created by Areeb Mustafa on 2020-04-16.
//  Copyright © 2020 Areeb Mustafa. All rights reserved.
//

import UIKit

class CourseInfoViewController: UIViewController {
    
    @IBOutlet weak var courseNameLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    
    @IBOutlet weak var currentMarkLabel: UILabel!
    
    
    @IBOutlet weak var completedLabel: UILabel!
    
    
    @IBOutlet weak var finalExamWorthLabel: UILabel!
    
    @objc var buttonClicked: String!
    
    var helper:HelperMethods = HelperMethods()
    
    var map: [String: Course] = [:]
    
    var deleteButton: UIButton!
    @IBOutlet weak var scrollView: UIView!
    
    var segues : UIStoryboardSegue!
    var yCounter = 367.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //segues.identifier = "courseInfo"
        let course = map[buttonClicked]
        courseNameLabel.text = course?.getCourseName()
        
        if course?.getWeight() == 0.25{
            weightLabel.text = "0.25"
        }
        if course?.getWeight() == 0.5{
            weightLabel.text = "0.5"
        }
        if course?.getWeight() == 0.75{
            weightLabel.text = "0.75"
        }
        if course?.getWeight() == 1.00{
            weightLabel.text = "1.0"
        }
        
        let currentMark = String(format: "%.1f %%",getCurrentMark(marks: course!.marks))
        currentMarkLabel.text = currentMark
        
        let completed = String(format: "%.1f %%",helper.getTotalWorth(marks: course!.marks))
        completedLabel.text = completed
        
        let finalExam = String(format: "%.1f %%", getFinalExamWorth(marks: course!.marks))
        finalExamWorthLabel.text = finalExam
        
        
        for mark in course!.marks{
            
            let courseItem = UILabel()
            courseItem.frame = CGRect(x: 52, y: yCounter, width: 100, height: 21)
            courseItem.text = mark.getCourseItem()
            courseItem.font = UIFont(name: "Helvetica", size: 16.5)
            courseItem.textColor = .black
            scrollView.addSubview(courseItem)
            //self.view.addSubview(self.view.addSubview(courseItem))
            
            let worth = UILabel()
            worth.frame = CGRect(x: 186, y: yCounter, width: 85, height: 21)
            worth.text = String(format: "%.1f %%",mark.getWorth())
            worth.textColor = .black
            scrollView.addSubview(worth)
            //self.view.view.addSubview(worth)
            
            let yourMark = UILabel()
            yourMark.frame = CGRect(x: 327, y: yCounter, width: 85, height: 21)
            yourMark.text = String(format: "%.1f %%",mark.getYourMark())
            yourMark.textColor = .black
            scrollView.addSubview(yourMark)
            
            yCounter += 37
            
            
        }
        yCounter += 20
        let requiredOnFinalText = UILabel()
        requiredOnFinalText.frame = CGRect(x: 215, y: yCounter, width: 174, height: 21)
        requiredOnFinalText.font  = UIFont(name: "Helvetica Bold", size: 17.0)
        requiredOnFinalText.textColor = UIColorFromRGB(rgbValue: 0x7D121C)
        requiredOnFinalText.text = "Required % on Final"
        scrollView.addSubview(requiredOnFinalText)
        
        yCounter += 55
        
        
        
        let toGet50 = UILabel()
        toGet50.frame = CGRect(x: 29, y: yCounter, width: 137, height: 21)
        toGet50.font  = UIFont(name: "Helvetica", size: 17.0)
        toGet50.textColor =  .black
        toGet50.text = "To finish with 50%"
        scrollView.addSubview(toGet50)
        
        var percent = UILabel()
        percent.frame = CGRect(x: 322, y: yCounter, width: 137, height: 21)
        percent.font  = UIFont(name: "Helvetica Bold", size: 17.0)
        percent.textColor =  UIColorFromRGB(rgbValue: 0x7D121C )
        if getFinalExamWorth(marks: course!.marks) == 0{
            percent.text = "0.0 %"
        }
        else{
            percent.text = String(format: "%.1f %%",calculateToGetNMark(n: 50, array: course!.marks))
        }
        
        scrollView.addSubview(percent)
        
        yCounter += 44
        let toGet60 = UILabel()
        toGet60.frame = CGRect(x: 29, y: yCounter, width: 137, height: 21)
        toGet60.font  = UIFont(name: "Helvetica", size: 17.0)
        toGet60.textColor =  .black
        toGet60.text = "To finish with 60%"
        scrollView.addSubview(toGet60)
        
        percent = UILabel()
        percent.frame = CGRect(x: 322, y: yCounter, width: 137, height: 21)
        percent.font  = UIFont(name: "Helvetica Bold", size: 17.0)
        percent.textColor =  UIColorFromRGB(rgbValue: 0x7D121C )
        if getFinalExamWorth(marks: course!.marks) == 0{
            percent.text = "0.0 %"
        }
        else{
            percent.text = String(format: "%.1f %%",calculateToGetNMark(n: 60, array: course!.marks))
        }
        //percent.text = String(format: "%.1f %%",calculateToGetNMark(n: 60, array: course!.marks))
        scrollView.addSubview(percent)
        
        yCounter += 44
        let toGet70 = UILabel()
        toGet70.frame = CGRect(x: 29, y: yCounter, width: 137, height: 21)
        toGet70.font  = UIFont(name: "Helvetica", size: 17.0)
        toGet70.textColor =  .black
        toGet70.text = "To finish with 70%"
        scrollView.addSubview(toGet70)
        
        percent = UILabel()
        percent.frame = CGRect(x: 322, y: yCounter, width: 137, height: 21)
        percent.font  = UIFont(name: "Helvetica Bold", size: 17.0)
        percent.textColor =  UIColorFromRGB(rgbValue: 0x7D121C )
        if getFinalExamWorth(marks: course!.marks) == 0{
            percent.text = "0.0 %"
        }
        else{
            percent.text = String(format: "%.1f %%",calculateToGetNMark(n: 70, array: course!.marks))
        }
        scrollView.addSubview(percent)
        
        yCounter += 44
        let toGet80 = UILabel()
        toGet80.frame = CGRect(x: 29, y: yCounter, width: 137, height: 21)
        toGet80.font  = UIFont(name: "Helvetica", size: 17.0)
        toGet80.textColor =  .black
        toGet80.text = "To finish with 80%"
        scrollView.addSubview(toGet80)
        
        percent = UILabel()
        percent.frame = CGRect(x: 322, y: yCounter, width: 137, height: 21)
        percent.font  = UIFont(name: "Helvetica Bold", size: 17.0)
        percent.textColor =  UIColorFromRGB(rgbValue: 0x7D121C )
        
        if getFinalExamWorth(marks: course!.marks) == 0{
            percent.text = "0.0 %"
        }
        else{
            percent.text = String(format: "%.1f %%",calculateToGetNMark(n: 80, array: course!.marks))
        }
        scrollView.addSubview(percent)
        
        yCounter += 44
        let toGet90 = UILabel()
        toGet90.frame = CGRect(x: 29, y: yCounter, width: 137, height: 21)
        toGet90.font  = UIFont(name: "Helvetica", size: 17.0)
        toGet90.textColor =  .black
        toGet90.text = "To finish with 90%"
        scrollView.addSubview(toGet90)
        
        percent = UILabel()
        percent.frame = CGRect(x: 322, y: yCounter, width: 137, height: 21)
        percent.font  = UIFont(name: "Helvetica Bold", size: 17.0)
        percent.textColor =  UIColorFromRGB(rgbValue: 0x7D121C )
        if getFinalExamWorth(marks: course!.marks) == 0{
            percent.text = "0.0 %"
        }
        else{
            percent.text = String(format: "%.1f %%",calculateToGetNMark(n:90, array: course!.marks))
        }
        scrollView.addSubview(percent)
        
        
        yCounter += 44
        let toGet100 = UILabel()
        toGet100.frame = CGRect(x: 29, y: yCounter, width: 150, height: 21)
        toGet100.font  = UIFont(name: "Helvetica", size: 17.0)
        toGet100.textColor =  .black
        toGet100.text = "To finish with 100%"
        scrollView.addSubview(toGet100)
        
        percent = UILabel()
        percent.frame = CGRect(x: 322, y: yCounter, width: 137, height: 21)
        percent.font  = UIFont(name: "Helvetica Bold", size: 17.0)
        percent.textColor =  UIColorFromRGB(rgbValue: 0x7D121C )
        if getFinalExamWorth(marks: course!.marks) == 0{
            percent.text = "0.0 %"
        }
        else{
            percent.text = String(format: "%.1f %%",calculateToGetNMark(n: 100, array: course!.marks))
        }
        scrollView.addSubview(percent)
        
        
        
        yCounter += 100
        deleteButton = UIButton()
        deleteButton.frame  = CGRect(x: 72, y: yCounter, width: 250, height: 57)
        deleteButton.setTitle("Delete Course", for: .normal)
        deleteButton.addTarget(self, action: #selector(self.buttonClick), for: UIControl.Event.touchUpInside)
        deleteButton.backgroundColor = .systemGray6
        deleteButton.setTitleColor(.systemBlue, for: .normal)
        deleteButton.tintColor = .systemBlue
        deleteButton.titleLabel?.font = UIFont(name: "Helvetica Bold" , size: 17.0)
        
        
        scrollView.addSubview(deleteButton)
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @objc func buttonClick(sender: UIButton){
        
        let alert = UIAlertController(title: "Are you sure?", message: "If you delete the course,then you won't able to retreive it again", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { (action) in
                 
            alert.dismiss(animated: true, completion: nil)
            let courseDeletedAlert = UIAlertController(title: "Course deleted", message: "Course has been successfuly deleted", preferredStyle: UIAlertController.Style.alert)
            courseDeletedAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
                    self.map.removeValue(forKey: self.buttonClicked)
                               
                    self.performSegue(withIdentifier: "unwindCourse", sender: self)
                    courseDeletedAlert.dismiss(animated: true, completion: nil)
            }))
          
            self.present(courseDeletedAlert,animated: true,completion: nil)
            
        }))
        self.present(alert,animated: true,completion: nil)
     
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! CoursesViewController
        vc.dict = map
    }
    

   
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getCurrentMark(marks: [Mark]) ->Float{
        var totalMark:  Float = 0
        let check = helper.getTotalWorth(marks: marks)
        if check == 0{
            return 0.0
        }
        totalMark = helper.getTotalPercentOfCourse(marks: marks) / helper.getTotalWorth(marks: marks)
        //print("total Mark is \ (totalMark)" )
        totalMark = totalMark  * 100
        return totalMark
    }
    
    func getFinalExamWorth(marks:[Mark]) -> Float {
        var total: Float = 0
        total = 100 - helper.getTotalWorth(marks: marks)
        return total
    }
    func calculateToGetNMark(n: Int,array:[Mark]) -> Float {
        
        let totalPercent  = helper.getTotalPercentOfCourse(marks: array)
        
        let finalExamWorth = getFinalExamWorth(marks: array)
        var total = Float(n) - totalPercent
        total = total / (finalExamWorth/100)
        //total = total / (
        
        return total
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


