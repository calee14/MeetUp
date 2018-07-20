//
//  UIViewController+Extenstion.swift
//  MeetUp
//
//  Created by Cappillen on 7/17/18.
//  Copyright © 2018 Cappillen. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    // static var to store the date times of the users
    static var userTimeData: [[[Int : Bool]]] = [[[Int : Bool]]]()
    
    static var userNames: [String] = [String]()
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
