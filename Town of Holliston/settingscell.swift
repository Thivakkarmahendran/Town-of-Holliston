//
//  settingscell.swift
//  Town of Holliston
//
//  Created by Thivakkar Mahendran on 3/18/15.
//  Copyright (c) 2015 Thivakkar Mahendran. All rights reserved.
//

import UIKit


class settingscell: UITableViewCell {
    @IBOutlet weak var Titlelabelcell: UILabel!
    @IBOutlet weak var switchcell: UISwitch!
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        switchcell.addTarget(self, action: Selector("stateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func stateChanged(switchState: UISwitch) {
        if(Titlelabelcell.text == "Police")
        {
            if switchState.on {
                Settingrespolice = "1"
                 
            } else {
                Settingrespolice = "0"
                
            }        }
        else if(Titlelabelcell.text == "Fire")
        {
            if switchState.on {
                Settingresfire = "1"
                
            } else {
                Settingresfire = "0"
                
            }
            
        }
        else if(Titlelabelcell.text == "School")
        {
            if switchState.on {
                 Settingresschool = "1"
                
            } else {
                 Settingresschool = "0"
                
            }
            
        }
        else if(Titlelabelcell.text == "Town")
        {
            if switchState.on {
                Settingrestown = "1"
                
            } else {
                Settingrestown = "0"
                
            }
            
        }
    }
}

