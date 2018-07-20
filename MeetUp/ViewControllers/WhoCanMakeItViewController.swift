//
//  WhoCanMakeItViewController.swift
//  MeetUp
//
//  Created by Pei Qin on 2018/7/20.
//  Copyright © 2018 Cappillen. All rights reserved.
//

import UIKit

class WhoCanMakeItViewController: UIViewController {
    @IBOutlet weak var canMakeTitleLabel: UILabel!
    
    @IBOutlet weak var canMakeNamesLabel: UILabel!
    
    @IBOutlet weak var cannotMakeTitleLabel: UILabel!
    
    @IBOutlet weak var cannotMakeNamesLabel: UILabel!
    
    @IBOutlet weak var closeButton: UIButton!
    @IBAction func closePopupButton(_ sender: UIButton) {
        self.removeAnimate()
        self.view.removeFromSuperview()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.closeButton.layer.cornerRadius=8
        self.view.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        self.showAnimate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAnimate() {
        self.view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        })
    }
    func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion:{(finished: Bool) in
            if (finished) {
                self.view.removeFromSuperview()
            }
        })
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
