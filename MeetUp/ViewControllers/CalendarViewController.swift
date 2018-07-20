//
//  CalendarViewController.swift
//  MeetUp
//
//  Created by Cappillen on 7/16/18.
//  Copyright © 2018 Cappillen. All rights reserved.
//

import UIKit

enum Side {
    case left, right 
}
class CalendarViewController: UIViewController {

    @IBOutlet weak var amTableView: UITableView!
    @IBOutlet weak var pmTableView: UITableView!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var transparentView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    
    
    //Calls this function when the tap is recognized.
    
    var AMSelectedCells = [Int: Bool]()
    var PMSelectedCells = [Int: Bool]()
    var touchSide: Side!
    var initialTouch: CGPoint!
    var initialCellIsTouched: Bool!
    let blackCellColor = UIColor(rgb: 0x222222)
    
//    var numOfMembers: Int! = 3
//    var duration: Int!
    //accepting values from Main storyboard
//    static var testFromDatePage: TestClass?
    static var testFromDatePage = TestClass.init(NewTime: 1, NewMember: 1)
    //    to call the variables passed from main storyboard: testFromDatePage.NewTime/NewMember/NewDate
    
    static var currentNumOfMembers = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        // Do any additional setup after loading the view.
//        print(CalendarViewController.testFromDatePage.NewDate)
//        dateLabel.text = CalendarViewController.testFromDatePage.NewDate
        
        for i in 0...12 {
            AMSelectedCells[i] = false
            PMSelectedCells[i] = false
        }
        
        amTableView.separatorStyle = .none
        pmTableView.separatorStyle = .none
        amTableView.isScrollEnabled = false
        pmTableView.isScrollEnabled = false
        amTableView.register(CalendarTableViewCell.self, forCellReuseIdentifier: "AMCalendarCell")
        pmTableView.register(CalendarTableViewCell.self, forCellReuseIdentifier: "PMCalendarCell")
        amTableView.backgroundColor = blackCellColor
        pmTableView.backgroundColor = blackCellColor
    }
    
    @IBAction func nextButtonTapped(_ sender: UIBarButtonItem) {
        CalendarViewController.currentNumOfMembers += 1
        UIViewController.userTimeData.append([AMSelectedCells, PMSelectedCells])
        if CalendarViewController.currentNumOfMembers == CalendarViewController.testFromDatePage.NewMember {
            
            self.performSegue(withIdentifier: "donePlanning", sender: self)
        }
        else {
            let storyboard = UIStoryboard(name: "Calendar", bundle: nil)
            
            let nextCalendar = storyboard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
            self.navigationController?.pushViewController(nextCalendar, animated: true)
        }
        
        let userName = nameTextField.text != "" ? nameTextField.text : "User Name \(UIViewController.userNames.count + 1)"
        UIViewController.userNames.append(userName!)
        print(UIViewController.userNames)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        CalendarViewController.currentNumOfMembers -= 1
        if !UIViewController.userTimeData.isEmpty {
            UIViewController.userTimeData.removeLast()
            UIViewController.userNames.removeLast()
        }
        print(UIViewController.userTimeData)
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Overrided functions for touch recognition
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: transparentView)
        initialTouch = location
        if (location?.x)! < transparentView.frame.size.width / 2 {
            // left: touch is in the am table view
            initialCellIsTouched = checkIfCellTouched(for: amTableView, at: location!)
        } else if (location?.x)! > transparentView.frame.size.width / 2 {
            // right: touch is in the pm table view
            initialCellIsTouched = checkIfCellTouched(for: pmTableView, at: location!)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: transparentView)
        if (location?.x)! < transparentView.frame.size.width / 2 {
            if !(touchSide == .right) {
                initialTouch = location
                touchSide = .right
            }
            // left: touch is in the am table view
            checkIfCellHasBeenHighlighted(for: amTableView, at: location!)
            
        } else if (location?.x)! > transparentView.frame.size.width / 2 {
            if !(touchSide == .left) {
                initialTouch = location
                touchSide = .left
            }
            // right: touch is in the pm table view
            checkIfCellHasBeenHighlighted(for: pmTableView, at: location!)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: transparentView)
    }
    
    // MARK: - Functions to check touches
    
    func checkIfCellHasBeenHighlighted(for table: UITableView, at location: CGPoint) {
        for cell in table.visibleCells {
            guard let cell = cell as? CalendarTableViewCell else { return }
            
            guard let indexPath = table.indexPath(for: cell) else { return }
            
            let cellPosition = cell.layer.position
            let cellY = cellPosition.y
            
            let cellSize = cell.frame.size
            let cellHeight = cellSize.height
            
            if initialTouch.y < location.y {
                // the touch has moved below the initial touch
                if cellY + (cellHeight/2) > initialTouch.y && cellY - (cellHeight/2) < location.y {
                    if cell.selectedTime != initialCellIsTouched {
                        if indexPath.row == 0 {
                            return
                        }
                        cell.selectedTime = initialCellIsTouched
                        updateTableView(for: table, indexPath: indexPath)
                    }
                }
            } else if initialTouch.y > location.y {
                // the touch has moved above the initial touch
                if cellY + (cellHeight/2) < initialTouch.y && cellY - (cellHeight/2) > location.y {
                    if cell.selectedTime != initialCellIsTouched{
                        if indexPath.row == 0 {
                            return
                        }
                        cell.selectedTime = initialCellIsTouched
                        updateTableView(for: table, indexPath: indexPath)
                    }
                }
            }
        }
    }
    
    func updateTableView(for table: UITableView, indexPath: IndexPath) {
        if table == amTableView {
            self.AMSelectedCells[indexPath.row - 1] = !self.AMSelectedCells[indexPath.row - 1]!
        } else if table == pmTableView {
            self.PMSelectedCells[indexPath.row - 1] = !self.PMSelectedCells[indexPath.row - 1]!
        }
        table.reloadData()
    }
    
    func checkIfCellTouched(for table: UITableView, at location: CGPoint) -> Bool {
        for cell in table.visibleCells {
            guard let cell = cell as? CalendarTableViewCell else { return false }
            guard let indexPath = table.indexPath(for: cell) else { return false }
            
            let cellPosition = cell.layer.position
            let cellY = cellPosition.y
            
            let cellSize = cell.frame.size
            let cellHeight = cellSize.height
            
            if cellY + (cellHeight/2) > location.y && cellY - (cellHeight/2) < location.y {
                // if tap is in the cell
                if cell.selectedTime == false {
                    if indexPath.row == 0 {
                        return false
                    }
                    cell.selectedTime = true
                    updateTableView(for: table, indexPath: indexPath)
                    return true
                } else if cell.selectedTime == true{
                    if indexPath.row == 0 {
                        return false
                    }
                    cell.selectedTime = false
                    updateTableView(for: table, indexPath: indexPath)
                    return false
                }
            }
        }
        return false
    }
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = CalendarTableViewCell()
        let cellColor = UIColor(rgb: 0xFF2A64)
        var newBlack=UIColor(rgb: 0x222222)
        if tableView == amTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "AMCalendarCell", for: indexPath) as! CalendarTableViewCell
            
            if let throwaway = AMSelectedCells[indexPath.row - 1], throwaway == true {
                cell.backgroundColor = cellColor
            }
            else {
                cell.backgroundColor = newBlack
            }
        } else if tableView == pmTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "PMCalendarCell", for: indexPath) as! CalendarTableViewCell
            if let throwaway = PMSelectedCells[indexPath.row - 1], throwaway == true {
                cell.backgroundColor = cellColor
            }
            else {
                cell.backgroundColor = newBlack
            }
        }
        var timesuffix = ""
        if tableView == amTableView {
            timesuffix = "AM"
        } else {
            timesuffix = "PM"
        }
        if indexPath.row >= 0 {
            
            if indexPath.row == 0 {
                cell.topTime = ""
                cell.bottomTime = "12:00\(timesuffix)"
                cell.removeTopSeperatorLine()
                return cell
            } else if indexPath.row == 1 {
                cell.topTime = "12:00\(timesuffix)"
            } else {
                cell.topTime = "\(indexPath.row - 1):00\(timesuffix)"
            }
        } else {
            cell.topTime = ""
        }
        cell.bottomTime = "\(indexPath.row ):00\(timesuffix)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return CGFloat(15)
        }
        let tableHeight = tableView.frame.size.height
        return CGFloat(tableHeight / 13)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            return
        }
        if tableView == amTableView {
            self.AMSelectedCells[indexPath.row - 1] = !self.AMSelectedCells[indexPath.row - 1]!
        } else if tableView == pmTableView {
            self.PMSelectedCells[indexPath.row - 1] = !self.PMSelectedCells[indexPath.row - 1]!
        }
        tableView.reloadData()
    }
}

