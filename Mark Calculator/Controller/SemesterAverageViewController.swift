//
//  SemesterAverageViewController.swift
//  Mark Calculator
//
//  Created by Areeb Mustafa on 2020-04-07.
//  Copyright © 2020 Areeb Mustafa. All rights reserved.
//

import UIKit

class SemesterAverageViewController: UIViewController {

    var map: [String: Course] = [:]
    var yCounter = 156.0
    var helper : HelperMethods = HelperMethods()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        
        let labels = helper.getLabels(view: self.view)
        let len = labels.count
        var i = 4
        while i < len{
            labels[i].removeFromSuperview()
            i += 1
        }
        yCounter = 156.0
        for (key,value) in map{
            let courseName = UILabel()
            courseName.frame = CGRect(x: 35, y: yCounter, width: 125, height: 21)
            courseName.text = key
            courseName.font = UIFont(name: "Helvetica", size:16.5 )
            courseName.textColor = .black
            self.view.addSubview(courseName)
            
          
            let mark = UILabel()
            mark.frame = CGRect(x: 185, y: yCounter, width: 82, height: 21)
           
            mark.text = String(format: "%.1f %%",helper.getCurrentMark(marks: value.marks) )
            mark.font = UIFont(name: "Helvetica", size:16.5 )
            mark.textColor = .black
            self.view.addSubview(mark)
            
            let weight = UILabel()
            weight.frame = CGRect(x: 341, y: yCounter, width: 60, height: 21)
            
            if value.weight == 0.25{
                weight.text = "0.25"
            }
            else if value.weight == 0.5{
                weight.text = "0.5"
            }
            else if value.weight == 0.75{
                weight.text = "0.75"
            }
            else if value.weight == 1.0{
                weight.text = "1.0"
            }
            weight.font = UIFont(name: "Helvetica", size:16.5 )
            weight.textColor = .black
            self.view.addSubview(weight)
            
            yCounter += 30
        }
        
        yCounter += 40
        
        let semesterAvgLabel = UILabel()
        semesterAvgLabel.frame = CGRect(x: 28, y: yCounter, width: 150, height: 21)
        semesterAvgLabel.font = UIFont(name: "Helvetica Bold", size:16.5 )
        semesterAvgLabel.text = "Semester Average: "
        semesterAvgLabel.textColor = .black
        self.view.addSubview(semesterAvgLabel)
        
        let finalMark = UILabel()
        finalMark.frame = CGRect(x: 185, y: yCounter, width: 150, height: 21)
        finalMark.font = UIFont(name: "Helvetica Bold", size: 16.5)
        finalMark.text = String(format: "%.1f %%",helper.getSemesterAverage(dict: map))
        finalMark.textColor = helper.UIColorFromRGB(rgbValue: 0x7D121C)
        self.view.addSubview(finalMark)
    }
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
