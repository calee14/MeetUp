//
//  SetUpViewController.swift
//  MeetUp
//
//  Created by Cappillen on 7/16/18.
//  Copyright © 2018 Cappillen. All rights reserved.
//

import UIKit

class MemberViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var peopleLabel: UILabel!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    var pickedNumberOfPeople = 1
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        pickedNumberOfPeople = row + 1
        print(pickedNumberOfPeople)
    }
    

    @IBOutlet weak var picker: UIPickerView!
    var pickerData: [String] = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self
        self.picker.dataSource = self
        pickerData = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        switch identifier {
        case "toTest":
            print("Error activation of toTest segue")
        case "toDuration":
            let destination = segue.destination as! DurationViewController
//            destination.testFromDurationPage.NewTime = pickedDuration
            destination.testFromMemberPage.NewMember = pickedNumberOfPeople
        default:
            print("something went wrong")
        }
    }
    
}
