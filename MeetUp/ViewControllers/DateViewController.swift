//
//  DateViewController.swift
//  MeetUp
//
//  Created by Pei Qin on 2018/7/17.
//  Copyright © 2018 Cappillen. All rights reserved.
//

import Foundation
import UIKit

class DateViewController: UIViewController {
    
    var testFromDurationPage = TestClass(NewTime: 1, NewMember: 1)
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var roundedView: UIView!
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        let strDate = datePicker.date.convertToString()
        testFromDurationPage.NewDate = strDate
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.roundedView.layer.cornerRadius=8
        self.dateLabel.layer.cornerRadius=8
        self.datePicker.layer.cornerRadius=8
    }
    
    @IBAction func toCalendar(_ sender: Any) {
        let intializeCalendarView = UIStoryboard.initializeViewController(for: UIStoryboard.MeetSBType.testboard)//changeForCal
        self.view.window?.rootViewController = intializeCalendarView
        self.view.window?.makeKeyAndVisible()
        datePicker.datePickerMode = UIDatePickerMode.date
    }
    
//    var pickedDate: Date?
    //Pei, write code to change pickedDate
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        switch identifier {
        case "toCalendar":
            CalendarViewController.currentNumOfMembers = 0
            CalendarViewController.testFromDatePage = TestClass(NewTime: testFromDurationPage.NewTime!, NewMember: testFromDurationPage.NewMember!, NewDate: testFromDurationPage.NewDate!)
        default:
            print("something went wrong")
        }
    }
    
}
