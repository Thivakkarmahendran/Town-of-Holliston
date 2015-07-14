//
//  imageDisplayview.swift
//  Town of Holliston
//
//  Created by Thivakkar Mahendran on 4/27/15.
//  Copyright (c) 2015 Thivakkar Mahendran. All rights reserved.
//

import Foundation
import MapKit
import UIKit



class  imageDisplayview: UIViewController{

    @IBOutlet var imageview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...(mapsdata.count - 1) {
            var title =  mapsdata.objectAtIndex(i).objectForKey ("Title") as! NSString
            
            if(displaytitle == title)
            {
                
                let base64String = (mapsdata.objectAtIndex(i).objectForKey ("Image") as! NSString) as String
                let decodedData = NSData(base64EncodedString: base64String, options: NSDataBase64DecodingOptions(rawValue: 0))
                var decodedimage = UIImage(data: decodedData!)
                imageview.image = decodedimage
            }
        }

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}