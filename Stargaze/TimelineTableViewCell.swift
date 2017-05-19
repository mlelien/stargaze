//
//  TimelineTableViewCell.swift
//  Stargaze
//
//  Created by Emily Lien on 1/8/17.
//  Copyright © 2017 EmilyLien. All rights reserved.
//

import UIKit

class TimelineTableViewCell: UITableViewCell {
    @IBOutlet var hourLabel: UILabel!
    @IBOutlet var iconIV: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
