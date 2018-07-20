//
//  DetailedResultViewController.swift
//  MeetUp
//
//  Created by Joshua Zhu on 7/20/18.
//  Copyright © 2018 Cappillen. All rights reserved.
//

import UIKit

class DetailedResultViewController: UIViewController {

    @IBOutlet weak var AMTableView: UITableView!
    @IBOutlet weak var PMTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension DetailedResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let times = CalculateTime.preprocessing()
        print(times)
        
        if tableView == AMTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AMDetailCell", for: indexPath) as! AMDetailedResultTableViewCell
            let bounds = UIScreen.main.bounds
            let screenWidth = bounds.size.width
            let width = (screenWidth/2)*((CGFloat(times[indexPath.row]!)/(CGFloat(CalendarViewController.testFromDatePage.NewMember!))))
            cell.AMColorCell.widthAnchor.constraint(equalToConstant: width).isActive = true
            cell.AMColorCell.alpha = CGFloat(times[indexPath.row]!)/(CGFloat(CalendarViewController.testFromDatePage.NewMember!))
            if let text = times[indexPath.row], text != 0 {
               cell.AMNumberLabel.text = String(text)
            }
            else {
                cell.AMNumberLabel.text = ""
            }
            return cell

        } else if tableView == PMTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PMDetailCell", for: indexPath) as! PMDetailedResultTableViewCell
            let bounds = UIScreen.main.bounds
            let screenWidth = bounds.size.width
            let width = (screenWidth/2)*((CGFloat(times[indexPath.row + 12]!)/(CGFloat(CalendarViewController.testFromDatePage.NewMember!))))
            cell.PMColorCell.widthAnchor.constraint(equalToConstant: width).isActive = true
            cell.PMColorCell.alpha = CGFloat(times[indexPath.row + 12]!)/(CGFloat(CalendarViewController.testFromDatePage.NewMember!))
            if let text = times[indexPath.row + 12], text != 0 {
                cell.PMNumberLabel.text = String(text)
            }
            else {
                cell.PMNumberLabel.text = ""
            }
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let names = UIViewController.userNames
        if tableView == AMTableView {
            let popOver = UIStoryboard(name: "Result", bundle: nil).instantiateViewController(withIdentifier: "WhoCanMakeIt") as! WhoCanMakeItViewController
            self.addChildViewController(popOver)
            popOver.view.frame = self.view.frame
            self.view.addSubview(popOver.view)
            let (canMakeIt, cantMakeIt) = CalculateTime.findNames(time: indexPath.row, names: names)
            print(canMakeIt)
            print(cantMakeIt)
            popOver.canMakeNamesLabel.text = canMakeIt
            popOver.cannotMakeNamesLabel.text = cantMakeIt
            popOver.didMove(toParentViewController: self)
        } else if tableView == PMTableView {
            let popOver = UIStoryboard(name: "Result", bundle: nil).instantiateViewController(withIdentifier: "WhoCanMakeIt") as! WhoCanMakeItViewController
            self.addChildViewController(popOver)
            popOver.view.frame = self.view.frame
            self.view.addSubview(popOver.view)
            let (canMakeIt, cantMakeIt) = CalculateTime.findNames(time: indexPath.row + 12, names: names)
            print(canMakeIt)
            print(cantMakeIt)
            popOver.canMakeNamesLabel.text = canMakeIt
            popOver.cannotMakeNamesLabel.text = cantMakeIt
            popOver.didMove(toParentViewController: self)
        }
    }
    
}
