//
//  EventsTableViewCell.swift
//  Town of Holliston
//
//  Created by Thivakkar Mahendran on 10/31/14.
//  Copyright (c) 2014 Thivakkar Mahendran. All rights reserved.
//

import UIKit

class EventsTableViewCell: UITableViewCell {
    @IBOutlet weak var eventcellTitle: UILabel!
    @IBOutlet weak var eventcellDesc: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
