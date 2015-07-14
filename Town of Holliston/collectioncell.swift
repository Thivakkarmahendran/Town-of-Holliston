//
//  collectioncell.swift
//  Town of Holliston
//
//  Created by Thivakkar Mahendran on 4/29/15.
//  Copyright (c) 2015 Thivakkar Mahendran. All rights reserved.
//

import Foundation
import UIKit

class collectioncell: UICollectionViewCell {
   
    @IBOutlet var Title: UILabel!
    
    @IBOutlet var Description: UITextView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
