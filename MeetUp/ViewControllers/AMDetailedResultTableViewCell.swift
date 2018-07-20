//
//  AMDetailedResultTableViewCell.swift
//  MeetUp
//
//  Created by Joshua Zhu on 7/20/18.
//  Copyright © 2018 Cappillen. All rights reserved.
//

import UIKit

class AMDetailedResultTableViewCell: UITableViewCell {

    @IBOutlet weak var AMColorCell: UIView!
    @IBOutlet weak var AMNumberLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
