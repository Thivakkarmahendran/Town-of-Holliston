//
//  newpointaddtableviewcontroller.swift
//  Town of Holliston
//
//  Created by Thivakkar Mahendran on 4/1/15.
//  Copyright (c) 2015 Thivakkar Mahendran. All rights reserved.
//

import Foundation
import UIKit
import MapKit


class newpointaddtableviewcontroller: UITableViewController, CLLocationManagerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    @IBOutlet weak var preiewmap: MKMapView!
    @IBOutlet weak var CategorySegmentControl: UISegmentedControl!
    @IBOutlet weak var TypeSegmentControl: UISegmentedControl!
    var CatType = 1
    var TypeType = 1
   
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var decsTextField: UITextField!
    @IBOutlet var addimage: UIImageView!
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.toolbarHidden = true
        var locValue = CLLocationCoordinate2D(latitude:TestTownlocation.coordinate.latitude ,longitude: TestTownlocation.coordinate.longitude)
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegion(center: locValue, span: span)
        preiewmap.setRegion(region, animated: true)
        
        let longPress = UITapGestureRecognizer(target: self, action: "action:")
        addimage.addGestureRecognizer(longPress)
        
        var newAnotation = MKPointAnnotation()
        newAnotation.coordinate = TestTownlocation.coordinate
        newAnotation.title = "Droped Pin"
        self.preiewmap.addAnnotation(newAnotation)
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       }
    
    @IBAction func categorySegment (sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex  {
        case 0:
            CatType = 1
           TypeSegmentControl.enabled = true
           TypeSegmentControl.removeSegmentAtIndex(0, animated: true)
           TypeSegmentControl.insertSegmentWithTitle("Suspicious", atIndex: 0, animated: true)
           TypeSegmentControl.removeSegmentAtIndex(1, animated: true)
           TypeSegmentControl.insertSegmentWithTitle("Theft", atIndex: 1, animated: true)
           TypeSegmentControl.removeSegmentAtIndex(2, animated: true)
           TypeSegmentControl.insertSegmentWithTitle("Accident", atIndex: 2, animated: true)
           TypeSegmentControl.removeSegmentAtIndex(3, animated: true)
           TypeSegmentControl.insertSegmentWithTitle("Other", atIndex: 3, animated: true)
        case 1:
            CatType = 2
            TypeSegmentControl.enabled = false
        case 2:
            CatType = 3
            TypeSegmentControl.enabled = true
            TypeSegmentControl.removeSegmentAtIndex(0, animated: true)
            TypeSegmentControl.insertSegmentWithTitle("Electricity", atIndex: 0, animated: true)
            TypeSegmentControl.removeSegmentAtIndex(1, animated: true)
            TypeSegmentControl.insertSegmentWithTitle("Water", atIndex: 1, animated: true)
            TypeSegmentControl.removeSegmentAtIndex(2, animated: true)
            TypeSegmentControl.insertSegmentWithTitle("Tree", atIndex: 2, animated: true)
            TypeSegmentControl.removeSegmentAtIndex(3, animated: true)
            TypeSegmentControl.insertSegmentWithTitle("Other", atIndex: 3, animated: true)
        case 3:
            CatType = 4
            TypeSegmentControl.enabled = true
            TypeSegmentControl.removeSegmentAtIndex(0, animated: true)
            TypeSegmentControl.insertSegmentWithTitle("Person", atIndex: 0, animated: true)
            TypeSegmentControl.removeSegmentAtIndex(1, animated: true)
            TypeSegmentControl.insertSegmentWithTitle("Pet", atIndex: 1, animated: true)
            TypeSegmentControl.removeSegmentAtIndex(2, animated: true)
            TypeSegmentControl.insertSegmentWithTitle("Item", atIndex: 2, animated: true)
            TypeSegmentControl.removeSegmentAtIndex(3, animated: true)
            TypeSegmentControl.insertSegmentWithTitle("Other", atIndex: 3, animated: true)
            
        case 4:
            CatType = 5
            TypeSegmentControl.enabled = false
        default:
            TypeSegmentControl.enabled = false
        }
    }

    @IBAction func typeSegmenet (sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex  {
        case 0:
            TypeType = 1
        case 1:
            TypeType = 2
            
        case 2:
            TypeType = 3
            
        case 3:
            TypeType = 4
            
            
        case 4:
            TypeType = 5
            
        default:
           TypeType = 1
        }
    }

    @IBAction func AddReportButton(sender: AnyObject) {
        if((titleTextField.text != "")&&(decsTextField.text != ""))
       {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitDay | .CalendarUnitMonth | .CalendarUnitYear, fromDate: date)
        let year = components.year
        let month = components.month
        let day = components.day
        
        var long = TestTownlocation.coordinate.longitude
        var lat = TestTownlocation.coordinate.latitude
        var title = titleTextField.text
        var dec = decsTextField.text
        
        var imageObbj:UIImage! =   self.imageResize(addimage.image!, sizeChange: CGSizeMake(200,200))
        let imageData = UIImageJPEGRepresentation(imageObbj, 0.9)
        let base64String = imageData.base64EncodedStringWithOptions(.allZeros)
        
        
        let currentInstallation:PFInstallation = PFInstallation.currentInstallation()
        var sendreport = PFObject(className:"GeoReport")
        sendreport["Date"] = "\(day)-\(month)-\(year)"
        sendreport["Title"] = title
        sendreport["Description"] = dec
        sendreport["Longitude"] = String(stringInterpolationSegment: long)
        sendreport["Latitude"] = String(stringInterpolationSegment: lat)
        sendreport["Type"] = String(TypeType)
        sendreport["Category"] = String(CatType)
        sendreport["Image"] = String(base64String)
        sendreport["Name"] = name
        sendreport["Email"] = email
         sendreport["User"] = currentInstallation.installationId
       
        sendreport.saveInBackgroundWithBlock({ (Bool, NSError) -> Void in
            if(Bool == true)
            {
                let alert = UIAlertView()
                alert.title = "Alert"
                alert.message = "Report has been posted"
                alert.addButtonWithTitle("Dismiss")
                alert.show()
            }
            else
            {
                let alert = UIAlertView()
                alert.title = "Please try again later"
                alert.message = "There was a network error or image is too large"
                alert.addButtonWithTitle("Dismiss")
                alert.show()
            }
        })
        
      
       }
        else
       {
        let alert = UIAlertView()
        alert.title = "Alert"
        alert.message = "You have a field missing"
        alert.addButtonWithTitle("Dismiss")
        alert.show()
       }

    }
    
    func action(gestureRecognizer:UIGestureRecognizer) {
        
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = false
            
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        
        else if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
       
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        picker.dismissViewControllerAnimated(true, completion: { () -> Void in
    
        })
        addimage.image = image
    }
    
    func imageResize (imageObj:UIImage, sizeChange:CGSize)-> UIImage{
        
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        imageObj.drawInRect(CGRect(origin: CGPointZero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
    }
    
}
