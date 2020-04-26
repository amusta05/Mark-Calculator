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
        
        let labels = getLabels(view: self.view)
        let len = labels.count
        var i = 4
        while i < len{
            print(labels[i].text!)
            labels[i].removeFromSuperview()
            i += 1
        }
        yCounter = 156.0
        for (key,value) in map{
            //print("the value of weight is \(value.weight)")
            let courseName = UILabel()
            courseName.frame = CGRect(x: 35, y: yCounter, width: 125, height: 21)
            courseName.text = key
            courseName.font = UIFont(name: "Helvetica", size:16.5 )
            courseName.textColor = .black
            self.view.addSubview(courseName)
            
          
            let mark = UILabel()
            mark.frame = CGRect(x: 185, y: yCounter, width: 82, height: 21)
           
            mark.text = String(format: "%.1f %%",getCurrentMark(marks: value.marks) )
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
        finalMark.text = String(format: "%.1f %%",getSemesterAverage(dict: map))
        finalMark.textColor = UIColorFromRGB(rgbValue: 0x7D121C)
        self.view.addSubview(finalMark)
        
        
        
    }
   
    
    
    func getLabels(view: UIView) -> [UILabel] {
         var results = [UILabel]()
         for subview in view.subviews as [UIView] {
             if let textField = subview as? UILabel {
                 results += [textField]
             } else {
                 results += getLabels(view: subview)
             }
         }
         return results
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
      
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func getSemesterAverage(dict: [String:Course]) -> Float {
        
        var totalWeight: Float = 0.0
        var totalPercentOfMark = 0.0
        for (_,value) in dict{
            
            let totalVal = getCurrentMark(marks: value.marks) * value.getWeight()
            
            totalWeight = totalWeight + value.getWeight()
            totalPercentOfMark = totalPercentOfMark + Double(totalVal)
            
            
        }
        totalPercentOfMark = totalPercentOfMark / Double(totalWeight)
        return Float(totalPercentOfMark)
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
          return UIColor(
              red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
              green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
              blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
              alpha: CGFloat(1.0)
          )
    }
    
    func createAlert(title: String,message: String) -> Void{
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            
        }))
        self.present(alert,animated: true,completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
