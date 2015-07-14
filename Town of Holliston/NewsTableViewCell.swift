//
//  NewsTableViewCell.swift
//  Town of Holliston
//
//  Created by Thivakkar Mahendran on 10/29/14.
//  Copyright (c) 2014 Thivakkar Mahendran. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var newscellTitle: UILabel!
    @IBOutlet weak var newscellDesc: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
