//
//  DurationViewController.swift
//  MeetUp
//
//  Created by Pei Qin on 2018/7/16.
//  Copyright © 2018 Cappillen. All rights reserved.
//

import Foundation
import UIKit

class DurationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var howLongLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return eventPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return eventPickerData[row]
    }
    
    var pickedDuration: Int = 0
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        pickedDuration = row + 1
        print(pickedDuration)
    }

    @IBOutlet weak var eventTime: UIPickerView!
    
    var eventPickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventTime.delegate = self
        self.eventTime.dataSource = self
        eventPickerData = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    }
    
    var testFromMemberPage = TestClass(NewTime: 0, NewMember: 0)//changeForCal
    
    
    @IBAction func toCalendar(_ sender: Any) {
        let intializeCalendarView = UIStoryboard.initializeViewController(for: UIStoryboard.MeetSBType.testboard)//changeForCal
        self.view.window?.rootViewController = intializeCalendarView
        self.view.window?.makeKeyAndVisible()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        switch identifier {
        case "toDuration":
            print("Error activation of toDuration segue")
        case "toCalendar"://changeForCal
            let destination = segue.destination as! TestViewController
            destination.testFromDurationPage.NewTime = pickedDuration
            destination.testFromDurationPage.NewMember = testFromMemberPage.NewMember
        default:
            print("something went wrong")
        }
    }
    
}


