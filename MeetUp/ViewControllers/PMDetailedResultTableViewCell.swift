//
//  PMDetailedResultTableViewCell.swift
//  MeetUp
//
//  Created by Joshua Zhu on 7/20/18.
//  Copyright © 2018 Cappillen. All rights reserved.
//

import UIKit

class PMDetailedResultTableViewCell: UITableViewCell {

    @IBOutlet weak var PMColorCell: UIView!
    @IBOutlet weak var PMNumberLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
