//
//  ViewController.swift
//  MeetUp
//
//  Created by Cappillen on 7/16/18.
//  Copyright © 2018 Cappillen. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {

    @IBOutlet weak var setUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func unwindFromCalendar(_ segue: UIStoryboardSegue) {
        print ("unwind from calendar")//changeForCal
        let initialViewController = UIStoryboard.initializeViewController(for: UIStoryboard.MeetSBType.main)
        self.view.window?.rootViewController = initialViewController
        self.view.window?.makeKeyAndVisible()
    }
    
    @IBAction func unwindWithSaved(_ segue: UIStoryboardSegue) {
        print("unwind with saved data")//changeForCal
        let initialViewController = UIStoryboard.initializeViewController(for: UIStoryboard.MeetSBType.main)
        self.view.window?.rootViewController = initialViewController
        self.view.window?.makeKeyAndVisible()
    }
    
    @IBAction func unwindFromResult(_ segue: UIStoryboardSegue) {
        print("unwind from result")//changeForCal
//        let initialViewController = UIStoryboard.initializeViewController(for: UIStoryboard.MeetSBType.main)
//        self.view.window?.rootViewController = initialViewController
//        let backToNew = UIStoryboard.initializeViewController(for: UIStoryboard.MeetSBType.main)
//        self.view.window?.rootViewController = backToNew
//        self.view.window?.makeKeyAndVisible()
    }
    
    @IBAction func unwindWithTutorial(_ segue: UIStoryboardSegue){
        let initialViewController = UIStoryboard.initializeViewController(for: UIStoryboard.MeetSBType.main)
        self.view.window?.rootViewController = initialViewController
        self.view.window?.makeKeyAndVisible()
    }
}

@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}


