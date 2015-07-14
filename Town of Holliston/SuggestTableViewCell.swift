//
//  ReportTableViewCell.swift
//  Town of Holliston
//
//  Created by Thivakkar Mahendran on 12/19/14.
//  Copyright (c) 2014 Thivakkar Mahendran. All rights reserved.
//

import UIKit

class SuggestTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionCell: UILabel!
    @IBOutlet weak var VoteCounterLabel: UILabel!
    var voteNumEdit = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func changevounterlabel()
    {
      
    VoteCounterLabel.text = String(voteNumEdit)
        
    }
   
    
}
