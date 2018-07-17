//
//  TestingStuff.swift
//  MeetUp
//
//  Created by Pei Qin on 2018/7/16.
//  Copyright © 2018 Cappillen. All rights reserved.
//

import Foundation
import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet weak var memberTest: UILabel!
    
    @IBOutlet weak var durationTest: UILabel!
    
    //    var testFromDurationPage = TestClass(NewTime: 0, NewMember: 0)
    var testFromDurationPage = TestClass(NewTime: 0, NewMember: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        durationTest.text = String(describing: testFromDurationPage.NewTime!)
        memberTest.text = String(describing: testFromDurationPage.NewMember!)
    }
    
    @IBAction func unwindFromCalendar(_ segue: UIStoryboardSegue) {
        print ("unwind from calendar")//changeForCal
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
                // 2
                if let initialViewController = storyboard.instantiateInitialViewController() {
                    // 3
                    self.view.window?.rootViewController = initialViewController
                    // 4
                    self.view.window?.makeKeyAndVisible()
                }
    }
    //not used any more
    @IBAction func unwindWithSaved(_ segue: UIStoryboardSegue) {
//        print("unwind with saved data")//changeForCal
//        let initialViewController = UIStoryboard.initializeViewController(for: UIStoryboard.MeetSBType.main)
//        self.view.window?.rootViewController = initialViewController
//        self.view.window?.makeKeyAndVisible()
        print ("unwind from calendar with saved data")//changeForCal
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
        // 2
        if let initialViewController = storyboard.instantiateInitialViewController() {
            // 3
            self.view.window?.rootViewController = initialViewController
            // 4
            self.view.window?.makeKeyAndVisible()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        switch identifier {
        case "displayResult":
            let destination = segue.destination as! ResultViewController
            destination.incomingResults = ResultClass(NewArray: [[0,0,0],[1,1,1],[2,2,2]])
        default:
            print("something went wrong")
        }
    }
}
