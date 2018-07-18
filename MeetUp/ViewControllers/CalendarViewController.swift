//
//  CalendarViewController.swift
//  MeetUp
//
//  Created by Cappillen on 7/16/18.
//  Copyright © 2018 Cappillen. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {

    @IBOutlet weak var amTableView: UITableView!
    @IBOutlet weak var pmTableView: UITableView!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    var AMSelectedCells = [Int: Bool]()
    var PMSelectedCells = [Int: Bool]()
    
//    var numOfMembers: Int! = 3
//    var duration: Int!
    //accepting values from Main storyboard
    static var testFromDatePage: TestClass?
    //    to call the variables passed from main storyboard: testFromDatePage.NewTime/NewMember/NewDate
    
    static var currentNumOfMembers = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
    }
    @IBAction func nextButtonTapped(_ sender: UIBarButtonItem) {
        CalendarViewController.currentNumOfMembers += 1
        UIViewController.userTimeData.append([AMSelectedCells, PMSelectedCells])
        if CalendarViewController.currentNumOfMembers == CalendarViewController.testFromDatePage?.NewMember {
            self.performSegue(withIdentifier: "donePlanning", sender: self)
        }
        else {
            let storyboard = UIStoryboard(name: "Calendar", bundle: nil)
            
            let nextCalendar = storyboard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
            self.navigationController?.pushViewController(nextCalendar, animated: true)
        }
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        CalendarViewController.currentNumOfMembers -= 1
        if !UIViewController.userTimeData.isEmpty {
            UIViewController.userTimeData.removeLast()
        }
        print(UIViewController.userTimeData)
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = CalendarTableViewCell()
        if tableView == amTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "AMCalendarCell", for: indexPath) as! CalendarTableViewCell
            if let throwaway = AMSelectedCells[indexPath.row - 1], throwaway == true {
                cell.backgroundColor = .green
            }
            else {
                cell.backgroundColor = .clear
            }
        } else if tableView == pmTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "PMCalendarCell", for: indexPath) as! CalendarTableViewCell
            if let throwaway = PMSelectedCells[indexPath.row - 1], throwaway == true {
                cell.backgroundColor = .green
            }
            else {
                cell.backgroundColor = .clear
            }
        }
        if indexPath.row >= 0 {
            if indexPath.row == 0 {
                cell.topTime = ""
                cell.bottomTime = "12:00"
                cell.removeTopSeperatorLine()
                return cell
            } else if indexPath.row == 1 {
                cell.topTime = "12:00"
            } else {
                cell.topTime = "\(indexPath.row - 1):00"
            }
        } else {
            cell.topTime = ""
        }
        cell.bottomTime = "\(indexPath.row ):00"
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
