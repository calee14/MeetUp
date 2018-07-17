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
    
    var AMSelectedCells: [Int] = [Int]()
    var PMSelectedCells: [Int] = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        amTableView.separatorStyle = .none
        pmTableView.separatorStyle = .none
        amTableView.isScrollEnabled = false
        pmTableView.isScrollEnabled = false
        amTableView.register(CalendarTableViewCell.self, forCellReuseIdentifier: "AMCalendarCell")
        pmTableView.register(CalendarTableViewCell.self, forCellReuseIdentifier: "PMCalendarCell")
    }

}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = CalendarTableViewCell()
        if tableView == amTableView {
            print("amtable")
            cell = tableView.dequeueReusableCell(withIdentifier: "AMCalendarCell", for: indexPath) as! CalendarTableViewCell
            if AMSelectedCells.contains(indexPath.row) {
                cell.backgroundColor = .green
            }
        } else if tableView == pmTableView {
            print("pmtable")
            cell = tableView.dequeueReusableCell(withIdentifier: "PMCalendarCell", for: indexPath) as! CalendarTableViewCell
            if PMSelectedCells.contains(indexPath.row) {
                cell.backgroundColor = .green
            }
        }
        if indexPath.row > 0 {
            cell.topTime = "\(indexPath.row):00"
        } else {
            cell.topTime = ""
        }
        cell.bottomTime = "\(indexPath.row + 1):00"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableHeight = tableView.frame.size.height
        return CGFloat(tableHeight / 13)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == amTableView {
            self.AMSelectedCells.append(indexPath.row)
        } else if tableView == pmTableView {
            self.PMSelectedCells.append(indexPath.row)
        }
        tableView.reloadData()
    }
    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        var cell = CalendarTableViewCell()
//        if tableView == amTableView {
////            print("amtable")
//            cell = tableView.dequeueReusableCell(withIdentifier: "AMCalendarCell", for: indexPath) as! CalendarTableViewCell
//        } else if tableView == pmTableView {
////            print("pmtable")
//            cell = tableView.dequeueReusableCell(withIdentifier: "PMCalendarCell", for: indexPath) as! CalendarTableViewCell
//        }
//        cell.backgroundColor = .clear
////        print("selected \(cell.topTimeLabel.text)")
//    }
}
