//
//  TestingStuff.swift
//  MeetUp
//
//  Created by Pei Qin on 2018/7/16.
//  Copyright © 2018 Cappillen. All rights reserved.
//

import Foundation
import UIKit

class TestClass {
    var NewTime: Int?
    var NewMember: Int?
    
    init(NewTime: Int, NewMember: Int){
        self.NewTime = NewTime
        self.NewMember = NewMember
    }
}

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
}
