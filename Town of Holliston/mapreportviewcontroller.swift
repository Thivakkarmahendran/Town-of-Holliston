//
//  mapreportviewcontroller.swift
//  Town of Holliston
//
//  Created by Thivakkar Mahendran on 3/31/15.
//  Copyright (c) 2015 Thivakkar Mahendran. All rights reserved.
//

import Foundation
import MapKit
import UIKit

var TestTownlocation = CLLocation(latitude: 1, longitude: 1)
var mapsdata = NSMutableArray()

class mapreportviewcontroller: UIViewController, CLLocationManagerDelegate, UITabBarDelegate, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var locValue = CLLocationCoordinate2D(latitude: 1,longitude: 1)
    var presscount = 0
    var catergory = ""
    var type = ""
   
    @IBOutlet weak var MapButton: UITabBarItem!
    @IBOutlet weak var TableButton: UITabBarItem!
    @IBOutlet weak var TabBar: UITabBar!
    @IBOutlet weak var mapreportTable: UITableView!
    
    @IBOutlet weak var segmentcontrolMapType: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        TabBar.selectedItem = MapButton
        self.navigationController?.toolbarHidden = true
        self.locationManager.requestAlwaysAuthorization()
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            getHTML()
        }
        
        let longPress = UILongPressGestureRecognizer(target: self, action: "action:")
        longPress.minimumPressDuration = 0.5
        mapView.addGestureRecognizer(longPress)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        locValue = manager.location.coordinate
        locationManager.stopUpdatingLocation()
        let span = MKCoordinateSpanMake(0.03, 0.03)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapView.setRegion(region, animated: true)
        
    }
    
    func getHTML()
    {
        if(mapsdata.count == 0)
        {
            
        var query1 = PFQuery(className:"GeoReport")
        
        query1.findObjectsInBackgroundWithBlock({ (objects:[AnyObject]?, NSError) -> Void in
            mapsdata.addObjectsFromArray(objects!.reverse())
            self.addpoints()
            self.mapreportTable.reloadData()
         })
            
        }
        else
        {
            self.addpoints()
            self.mapreportTable.reloadData()
        }
      
     
    }
    
    func addpoints()
    {
        
        for i in 0...(mapsdata.count - 1) {
         var long = (mapsdata.objectAtIndex(i).objectForKey ("Longitude") as! NSString).doubleValue
         var lat = (mapsdata.objectAtIndex(i).objectForKey ("Latitude") as! NSString).doubleValue
         let location = CLLocationCoordinate2D(latitude: lat,longitude: long)
            
            var pointAnnotation:MKPointAnnotation = MKPointAnnotation()
            pointAnnotation.coordinate = location
            pointAnnotation.title = (mapsdata.objectAtIndex(i).objectForKey ("Title") as! NSString) as String
            self.mapView?.addAnnotation(pointAnnotation)
        }
        
    }
    
    func action(gestureRecognizer:UIGestureRecognizer) {
        presscount++
        
        if (presscount == 2)
        {
        if(blocked == false)
        {
        var touchPoint = gestureRecognizer.locationInView(self.mapView)
        var newCoord:CLLocationCoordinate2D = mapView.convertPoint(touchPoint, toCoordinateFromView: self.mapView)
        TestTownlocation = CLLocation(latitude: newCoord.latitude, longitude: newCoord.longitude)
        CoordtoAdd()
        }
        else
        {
            let alert = UIAlertView()
            alert.title = "Alert"
            alert.message = "You have been blocked from posting!!"
            alert.addButtonWithTitle("Understod")
            alert.show()
        }
            presscount = 0
        }
    }
    
    @IBAction func changeMap (sender: UISegmentedControl) {
         switch segmentcontrolMapType.selectedSegmentIndex  {
        case 0:
            mapView.mapType = MKMapType.Standard
        case 1:
             mapView.mapType = MKMapType.Satellite
        case 2:
           mapView.mapType = MKMapType.Hybrid
        default:
           mapView.mapType = MKMapType.Standard
        }
        
    }
    
    func CoordtoAdd()
    {
        
        CLGeocoder().reverseGeocodeLocation(TestTownlocation, completionHandler: {(placemarks, error) -> Void in
            
            if error != nil {
                println("Reverse geocoder failed with error" + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0 {
                let pm = placemarks[0] as! CLPlacemark
                if(pm.locality == "Holliston")
                {
                   self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("newpointadd") as! UITableViewController, animated: true)
                }
                else
                {
                    let alert = UIAlertView()
                    alert.title = "Alert"
                    alert.message = "Please only select in Holliston"
                    alert.addButtonWithTitle("Dismiss")
                    alert.show()
                }
            }
            else {
                println("Problem with the data received from geocoder")
            }
        })
    }
    
    func mapView (mapView: MKMapView!,
        viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
            
            if (annotation.coordinate.latitude ==  mapView.userLocation.coordinate.latitude)
            {
                return nil;
            }
            else
            {
             var pinView:MKPinAnnotationView = MKPinAnnotationView()
             pinView.annotation = annotation
             pinView.pinColor = MKPinAnnotationColor.Purple
             pinView.animatesDrop = true
             pinView.canShowCallout = true
            
             return pinView
            }
    }
    
    func mapView(mapView: MKMapView!,
        didSelectAnnotationView view: MKAnnotationView!){
            if (view.annotation.title == "Current Location")
            {
                
            }
            else
            {
                
             TestTownlocation = CLLocation(latitude: view.annotation.coordinate.latitude, longitude: view.annotation.coordinate.longitude)
                displaytitle = view.annotation.title!
            self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("displayController") as! UITableViewController, animated: true)
            }
            
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
       
        switch item.tag  {
        case 0:
            mapView.hidden = false
            segmentcontrolMapType.hidden = false
            mapreportTable.hidden = true
            break
        case 1:
             mapView.hidden = true
             segmentcontrolMapType.hidden = true
             mapreportTable.hidden = false
            break
        default:
            mapView.hidden = false
            segmentcontrolMapType.hidden = false
            mapreportTable.hidden = true
            break
        }
        
    }
/////////////////////////////////////Table/////////////////////////////////////////
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mapsdata.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return  1;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        catergory = (mapsdata.objectAtIndex(indexPath.row).objectForKey ("Category") as! NSString) as String
        type = (mapsdata.objectAtIndex(indexPath.row).objectForKey ("Type") as! NSString) as String
        updateCat()
        
        let cell: mapreportCell = tableView.dequeueReusableCellWithIdentifier("Maincell123") as! mapreportCell
        cell.Title.text = (mapsdata.objectAtIndex(indexPath.row).objectForKey ("Title") as! NSString) as String
        cell.Date.numberOfLines = 1
        var descE = (mapsdata.objectAtIndex(indexPath.row).objectForKey ("Date") as! NSString) as String
        cell.Date.text = descE
       cell.Category.text = catergory
        cell.Type.text = type
        
         let base64String = (mapsdata.objectAtIndex(indexPath.row).objectForKey ("Image") as! NSString) as String
        let decodedData = NSData(base64EncodedString: base64String, options: NSDataBase64DecodingOptions(rawValue: 0))
        var decodedimage = UIImage(data: decodedData!)
          cell.Imageview.image = decodedimage
       
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        var long = (mapsdata.objectAtIndex(indexPath.row).objectForKey ("Longitude") as! NSString).doubleValue
        var lat = (mapsdata.objectAtIndex(indexPath.row).objectForKey ("Latitude") as! NSString).doubleValue
        TestTownlocation = CLLocation(latitude: lat,longitude: long)
        displaytitle = (mapsdata.objectAtIndex(indexPath.row).objectForKey ("Title") as! NSString) as String
        self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("displayController") as! UITableViewController, animated: true)
        
    }
    
    func updateCat()
    {
        if(catergory == "1")
        {
            catergory = "Police"
            if(type == "1")
            {
                type = "Suspicious"
            }
            else if(type == "2")
            {
                type = "Theft"
            }
            else if(type == "3")
            {
                type = "Accident"
            }
            else if(type == "4")
            {
                type = "Other"
            }
        }
            
        else if(catergory == "2")
        {
            catergory = "Fire"
            type = "None"
        }
            
        else if(catergory == "3")
        {
            catergory = "Town"
            if(type == "1")
            {
                type = "Electricity"
            }
            else if(type == "2")
            {
               type = "Water"
            }
            else if(type == "3")
            {
                type = "Tree"
            }
            else if(type == "4")
            {
                type = "Other"
            }
            
        }
        else if(catergory == "4")
        {
            catergory = "Person"
            if(type == "1")
            {
                type = "Electricity"
            }
            else if(type == "2")
            {
                type = "Pet"
            }
            else if(type == "3")
            {
                type = "Item"
            }
            else if(type == "4")
            {
                type = "Other"
            }
            
        }
        else if(catergory == "5")
        {
            catergory = "Other"
            type = "None"
        }
    }

/////////////////////////////////////////////////////////////////////////////////////////////
    
  }

