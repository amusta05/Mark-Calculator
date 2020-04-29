//
//  CoursesViewController.swift
//  Mark Calculator
//
//  Created by Areeb Mustafa on 2020-04-07.
//  Copyright © 2020 Areeb Mustafa. All rights reserved.
//

import UIKit

class CoursesViewController: UIViewController {
    
    var courseHelper: CoursesHelper = CoursesHelper()
    @IBOutlet weak var calcAverageButton: UIButton!
    var helper: HelperMethods = HelperMethods()
    override func viewDidLoad() {
        super.viewDidLoad()
        courseHelper.flag = 1
    }
    override func viewDidAppear(_ animated: Bool) {

        if courseHelper.flag == 1{
           
            let  buttons = helper.getButtons(view: self.view)
            var i = 1
            while i < buttons.count{
                
                buttons[i].removeFromSuperview()
                i += 1
            }
            i = 0
            courseHelper.yCounter = 120.0
            for (key,_) in courseHelper.dict {
                courseHelper.button = UIButton(type:.system)
                
                courseHelper.button.frame = CGRect(x: 30, y: courseHelper.yCounter, width: 357, height: 47)
                courseHelper.button.backgroundColor = UIColor.systemGray6
                courseHelper.button.setTitle(key, for:.normal )
                courseHelper.button.setTitleColor(helper.UIColorFromRGB(rgbValue: 0x137EFF), for: .normal)
                courseHelper.button.tintColor = .blue
                
                courseHelper.button.titleLabel?.font = UIFont(name: "Helvetica Bold", size: 17.0)
                courseHelper.button.addTarget(self, action: #selector(self.buttonClicked), for: UIControl.Event.touchUpInside)
                self.view.addSubview(courseHelper.button)
                courseHelper.yCounter += 60
                
                i += 1
                if i >= 10{
                    //calcSemAvgButton.frame = CGRect(x: 34, y: yCount, width: 346, height: 62)
                    courseHelper.yCount += 80
                    
                }
            }
            let firstTab = (self.tabBarController?.viewControllers?[0])! as!  ViewController
            firstTab.courses = courseHelper.dict
            
        }
        
    }
    @objc func buttonClicked(sender: UIButton){
    
       courseHelper.buttonClickedStr = courseHelper.button.titleLabel?.text
       self.performSegue(withIdentifier:"courseInfo" , sender: self)
    }
    
    @IBAction func calcAvgButtonPressed(_ sender: Any) {
        
        if courseHelper.dict.count == 0{
            let alert = helper.createAlert(title: "Error", message: "No courses available to calculate semester average")
            self.present(alert,animated: true,completion: nil)
        }
        else{
            self.performSegue(withIdentifier: "calculateSemAvg", sender:self)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "calculateSemAvg"{
            let vc = segue.destination as! SemesterAverageViewController
            vc.map = courseHelper.dict
        }
        else{
            let vc  = segue.destination as!  CourseInfoViewController
            vc.map = courseHelper.dict
            vc.buttonClicked = courseHelper.buttonClickedStr
        }
       
    }
    

    @IBAction func unwindToCourse(_ unwindSegue: UIStoryboardSegue) {
        // Use data from the view controller which initiated the unwind segue
    }
}
