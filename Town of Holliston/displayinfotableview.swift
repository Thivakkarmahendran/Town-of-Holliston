//
//  displayinfotableview.swift
//  Town of Holliston
//
//  Created by Thivakkar Mahendran on 4/3/15.
//  Copyright (c) 2015 Thivakkar Mahendran. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import AddressBookUI


var displaytitle = ""
class displayinfotableview: UITableViewController, CLLocationManagerDelegate{
    @IBOutlet weak var previewMap: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var TypeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet var imageview: UIImageView!
    
    var address = ""
    var catergory = ""
    var type = ""
    
     override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.toolbarHidden = true
        var locValue = CLLocationCoordinate2D(latitude:TestTownlocation.coordinate.latitude ,longitude: TestTownlocation.coordinate.longitude)
        let span = MKCoordinateSpanMake(0.005, 0.005)
        let region = MKCoordinateRegion(center: locValue, span: span)
        previewMap.setRegion(region, animated: true)
        var newAnotation = MKPointAnnotation()
        newAnotation.coordinate = TestTownlocation.coordinate
        newAnotation.title = displaytitle
        self.previewMap.addAnnotation(newAnotation)
        
        let longPress = UITapGestureRecognizer(target: self, action: "action:")
        imageview.addGestureRecognizer(longPress)
        
        CoordtoAdd()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func CoordtoAdd()
    {
        
        CLGeocoder().reverseGeocodeLocation(TestTownlocation, completionHandler: {(placemarks, error) -> Void in
            
            if error != nil {
                println("Reverse geocoder failed with error" + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0
            {
                let pm = placemarks[0] as! CLPlacemark
               //self.address = String(pm.addressDictionary["FormattedAddressLines"]! as NSString)
              
                self.addressLabel.text =  ABCreateStringWithAddressDictionary(pm.addressDictionary, false)
                self.setup()
                   
            }
            else
            {
                println("Problem with the data received from geocoder")
            }
        })
    }
    
    func setup()
    {
        for i in 0...(mapsdata.count - 1) {
            var title =  mapsdata.objectAtIndex(i).objectForKey ("Title") as! NSString
          
            if(displaytitle == title)
            {
             catergory = mapsdata.objectAtIndex(i).objectForKey ("Category") as! NSString as String
             type = mapsdata.objectAtIndex(i).objectForKey ("Type") as! NSString as String
             self.titleLabel.text = mapsdata.objectAtIndex(i).objectForKey ("Title") as! NSString as String
             self.descriptionLabel.text = mapsdata.objectAtIndex(i).objectForKey ("Description") as! NSString as String
                
                let base64String = (mapsdata.objectAtIndex(i).objectForKey ("Image") as! NSString) as String
                let decodedData = NSData(base64EncodedString: base64String, options: NSDataBase64DecodingOptions(rawValue: 0))
                var decodedimage = UIImage(data: decodedData!)
                imageview.image = decodedimage
                
             updateCat()
            }
        }
    }
    
    func updateCat()
    {
      if(catergory == "1")
      {
        categoryLabel.text = "Police"
        if(type == "1")
        {
            TypeLabel.text = "Suspicious"
        }
        else if(type == "2")
        {
            TypeLabel.text = "Theft"
        }
        else if(type == "3")
        {
            TypeLabel.text = "Accident"
        }
        else if(type == "4")
        {
            TypeLabel.text = "Other"
        }
      }
        
      else if(catergory == "2")
      {
        categoryLabel.text = "Fire"
      }
        
      else if(catergory == "3")
      {
        categoryLabel.text = "Town"
        if(type == "1")
        {
            TypeLabel.text = "Electricity"
        }
        else if(type == "2")
        {
            TypeLabel.text = "Water"
        }
        else if(type == "3")
        {
            TypeLabel.text = "Tree"
        }
        else if(type == "4")
        {
            TypeLabel.text = "Other"
        }

      }
      else if(catergory == "4")
      {
        categoryLabel.text = "Person"
        if(type == "1")
        {
            TypeLabel.text = "Electricity"
        }
        else if(type == "2")
        {
            TypeLabel.text = "Pet"
        }
        else if(type == "3")
        {
            TypeLabel.text = "Item"
        }
        else if(type == "4")
        {
            TypeLabel.text = "Other"
        }

      }
      else if(catergory == "5")
      {
        categoryLabel.text = "Other"
      }
    }
    
    func action(gestureRecognizer:UIGestureRecognizer) {
        self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("imageDisplay") as! UIViewController, animated: true)
    }
    

}

