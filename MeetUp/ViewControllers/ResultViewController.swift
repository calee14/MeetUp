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
    weak var incomingResults = ResultClass(NewArray: [[0,0],[1,1],[2,2]])
    
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLabel.text = "Time: \(CalculateTime.calculate(superDict: CalculateTime.changeTimeDataType(), pickedDuration: (CalendarViewController.testFromDatePage?.NewTime)!, pickedNumberOfPeople: (CalendarViewController.testFromDatePage?.NewMember)!))"
        
    }
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        UIViewController.userTimeData = [[[Int : Bool]]]()
        if let nvc = navigationController {
            nvc.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
}
