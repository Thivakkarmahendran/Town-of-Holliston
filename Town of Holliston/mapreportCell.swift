//
//  mapreportCell.swift
//  Town of Holliston
//
//  Created by Thivakkar Mahendran on 4/25/15.
//  Copyright (c) 2015 Thivakkar Mahendran. All rights reserved.
//

import UIKit

class mapreportCell: UITableViewCell {
    
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var Category: UILabel!
    @IBOutlet weak var Type: UILabel!
    @IBOutlet var Imageview: UIImageView!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }



}