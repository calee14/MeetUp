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
    var incomingResults = ResultClass(NewArray: [[0,0],[1,1],[2,2]])
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func goBackTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        // 2
        if let initialViewController = storyboard.instantiateInitialViewController() {
            // 3
            self.view.window?.rootViewController = initialViewController
            // 4
            self.view.window?.makeKeyAndVisible()
        }
    }
    
}
