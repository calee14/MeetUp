//
//  ResultViewController.swift
//  MeetUp
//
//  Created by Pei Qin on 2018/7/17.
//  Copyright © 2018 Cappillen. All rights reserved.
//

import Foundation
import UIKit

class ResultViewController: UIViewController {
//    weak var incomingResults = ResultClass(NewArray: [[0,0],[1,1],[2,2]])
    
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var moreButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.moreButton.layer.cornerRadius=8
        self.resetButton.layer.cornerRadius=8
        self.dataLabel.layer.cornerRadius=8
        self.timeLabel.layer.cornerRadius=8
        dataLabel.text = "Date: \(CalendarViewController.testFromDatePage.NewDate!)"
        timeLabel.text = "Time: \(CalculateTime.calculate())"
        
    }
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        UIViewController.userTimeData = [[[Int : Bool]]]()
        UIViewController.userNames = [String]()
//        if let nvc = navigationController {
//            nvc.popViewController(animated: true)
//        } else {
//            dismiss(animated: true, completion: nil)
//        }
    }
    
}
