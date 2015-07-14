//
//  DirectoryViewController.swift
//  Town of Holliston
//
//  Created by Thivakkar Mahendran on 11/5/14.
//  Copyright (c) 2014 Thivakkar Mahendran. All rights reserved.
//

import UIKit

var Accountant: NSMutableArray = NSMutableArray()
var AnimalControl: NSMutableArray = NSMutableArray()
var AssessorsOffice: NSMutableArray = NSMutableArray()
var Building: NSMutableArray = NSMutableArray()
var Conservation: NSMutableArray = NSMutableArray()
var DPW: NSMutableArray = NSMutableArray()
var Employment: NSMutableArray = NSMutableArray()
var Fire: NSMutableArray = NSMutableArray()
var Health: NSMutableArray = NSMutableArray()
var Highway: NSMutableArray = NSMutableArray()
var Library: NSMutableArray = NSMutableArray()
var Police: NSMutableArray = NSMutableArray()
var Parks: NSMutableArray = NSMutableArray()
var Senior: NSMutableArray = NSMutableArray()
var Technology: NSMutableArray = NSMutableArray()
var TownAdmin: NSMutableArray = NSMutableArray()
var TownClerk: NSMutableArray = NSMutableArray()
var Treasurer: NSMutableArray = NSMutableArray()
var Veteran: NSMutableArray = NSMutableArray()
var Water: NSMutableArray = NSMutableArray()
var Youth: NSMutableArray = NSMutableArray()

var info:NSMutableArray = NSMutableArray()

class DirectoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var DirectoryTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.toolbarHidden = true
           println(times)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 1
        if section == 0
        {
            rows = Accountant.count
        }
        if section == 1
        {
            rows = AnimalControl.count
        }
        if section == 2
        {
            rows = AssessorsOffice.count
        }
        if section == 3
        {
            rows = Building.count
        }
        if section == 4
        {
            rows = Conservation.count
        }
         if section == 5
        {
            rows = DPW.count
        }
        if section == 6
        {
            rows = Employment.count
        }
         if section == 7
        {
            rows = Fire.count
        }
        if section == 8
        {
            rows = Health.count
        }
         if section == 9
        {
            rows = Highway.count
        }
         if section == 10
        {
            rows = Library.count
        }
         if section == 11
        {
            rows = Police.count
        }
         if section == 12
        {
            rows = Parks.count
        }
        if section == 13
        {
            rows = Senior.count
        }
        if section == 14
        {
            rows = Technology.count
        }
         if section == 15
        {
            rows = TownAdmin.count
        }
         if section == 16
        {
            rows = TownClerk.count
        }
         if section == 17
        {
            rows = Treasurer.count
        }
         if section == 18
        {
            rows = Veteran.count
        }
         if section == 19
        {
            rows = Water.count
        }
         if section == 20
        {
            rows = Youth.count
        }
        return rows
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell:UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath)
    {
        cell.layer.transform = CATransform3DMakeScale(0,0,0)
        
        UIView.animateWithDuration(0.4, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
            
        })
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: DirectoryTableViewCell = tableView.dequeueReusableCellWithIdentifier("Maincell") as! DirectoryTableViewCell
        
        
        
        if indexPath.section == 0
        {
        cell.NameList.text = Accountant.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
           
        }
        if indexPath.section == 1
        {
          cell.NameList.text = AnimalControl.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
           
        }
        if indexPath.section == 2
        {
            cell.NameList.text = AssessorsOffice.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
        }
         if indexPath.section == 3
        {
            cell.NameList.text = Building.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
        }
         if indexPath.section == 4
        {
            cell.NameList.text = Conservation.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
        }
         if indexPath.section == 5
        {
            cell.NameList.text = DPW.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
        }
        else if indexPath.section == 6
        {
            cell.NameList.text = Employment.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
        }
        if indexPath.section == 7
        {
            cell.NameList.text = Fire.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
        }
         if indexPath.section == 8
        {
            cell.NameList.text = Health.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
        }
        if indexPath.section == 9
        {
            cell.NameList.text = Highway.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
        }
         if indexPath.section == 10
        {
            cell.NameList.text = Library.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
        }
         if indexPath.section == 11
        {
            cell.NameList.text = Police.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
        }
        if indexPath.section == 12
        {
            cell.NameList.text = Parks.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
        }
         if indexPath.section == 13
        {
            cell.NameList.text = Senior.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
        }
        if indexPath.section == 14
        {
            cell.NameList.text = Technology.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
        }
        else if indexPath.section == 15
        {
            cell.NameList.text = TownAdmin.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
        }
         if indexPath.section == 16
        {
            cell.NameList.text = TownClerk.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
        }
         if indexPath.section == 17
        {
            cell.NameList.text = Treasurer.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
        }
        else if indexPath.section == 18
        {
            cell.NameList.text = Veteran.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
        }
         if indexPath.section == 19
        {
            cell.NameList.text = Water.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
        }
        if indexPath.section == 20
        {
            cell.NameList.text = Youth.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
        }
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 21
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if section == 0
        {
            return "Accountant"
        }
        else if section == 1
        {
            return "Animal Control"
        }
        else if section == 2
        {
            return "Assessors Office"
        }
        else if section == 3
        {
            return "Building"
        }
        else if section == 4
        {
            return "Conservation"
        }
        else if section == 5
        {
            return "D.P.W."
        }
        else if section == 6
        {
            return "Employment & Personnel"
        }
        else if section == 7
        {
            return "Fire"
        }
        else if section == 8
        {
            return "Health"
        }
        else if section == 9
        {
            return "Highway"
        }
        else if section == 10
        {
            return "Library"
        }
        else if section == 11
        {
            return "Police"
        }
        else if section == 12
        {
            return "Parks & Recreation"
        }
        else if section == 13
        {
            return "Senior Center"
        }
        else if section == 14
        {
            return "Technology"
        }
        else if section == 15
        {
            return "Town Administrator"
        }
        else if section == 16
        {
            return "Town Clerk"
        }
        else if section == 17
        {
            return "Treasurer / Tax Collector"
        }
        else if section == 18
        {
            return "Veteran Services"
        }
        else if section == 19
        {
            return "Water"
        }
        else
        {
            return "Youth and Family Services"
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         var header: UILabel = UILabel()
        if section == 0
        {
            header.text =  "Accountant"
        }
        else if section == 1
        {
            header.text = "Animal Control"
        }
        else if section == 2
        {
            header.text = "Assessors Office"
        }
        else if section == 3
        {
            header.text = "Building"
        }
        else if section == 4
        {
            header.text = "Conservation"
        }
        else if section == 5
        {
            header.text = "D.P.W."
        }
        else if section == 6
        {
            header.text = "Employment & Personnel"
        }
        else if section == 7
        {
            header.text = "Fire"
        }
        else if section == 8
        {
            header.text = "Health"
        }
        else if section == 9
        {
            header.text = "Highway"
        }
        else if section == 10
        {
            header.text = "Library"
        }
        else if section == 11
        {
            header.text = "Police"
        }
        else if section == 12
        {
            header.text = "Parks & Recreation"
        }
        else if section == 13
        {
            header.text = "Senior Center"
        }
        else if section == 14
        {
            header.text = "Technology"
        }
        else if section == 15
        {
            header.text = "Town Administrator"
        }
        else if section == 16
        {
            header.text = "Town Clerk"
        }
        else if section == 17
        {
            header.text = "Treasurer / Tax Collector"
        }
        else if section == 18
        {
            header.text = "Veteran Services"
        }
        else if section == 19
        {
            header.text = "Water"
        }
        else
        {
            header.text = "Youth and Family Services"
        }
        
        if section % 2 == 0
        {
             header.backgroundColor = UIColor.redColor()
        }
        else{
             header.backgroundColor = UIColor.blueColor()
        }


        header.textColor = UIColor.whiteColor()
        header.font = UIFont.boldSystemFontOfSize(16.0)
        header.textAlignment = NSTextAlignment.Center
        return header
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        var name = ""
        var title = ""
        var phone = ""
       
        if indexPath.section == 0
        {
            name = Accountant.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
            title = Accountant.objectAtIndex(indexPath.row).objectForKey ("Title") as! NSString as String
            phone = Accountant.objectAtIndex(indexPath.row).objectForKey ("Phone") as! NSString as String
        }
        if indexPath.section == 1
        {
           name = AnimalControl.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
            title = AnimalControl.objectAtIndex(indexPath.row).objectForKey ("Title") as! NSString as String
            phone = AnimalControl.objectAtIndex(indexPath.row).objectForKey ("Phone") as! NSString as String
            
        }
        if indexPath.section == 2
        {
            name = AssessorsOffice.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
            title = AssessorsOffice.objectAtIndex(indexPath.row).objectForKey ("Title") as! NSString as String
            phone = AssessorsOffice.objectAtIndex(indexPath.row).objectForKey ("Phone") as! NSString as String
        }
        if indexPath.section == 3
        {
            name = Building.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
            title = Building.objectAtIndex(indexPath.row).objectForKey ("Title") as! NSString as String
            phone = Building.objectAtIndex(indexPath.row).objectForKey ("Phone") as! NSString as String
        }
        if indexPath.section == 4
        {
            name = Conservation.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
            title = Conservation.objectAtIndex(indexPath.row).objectForKey ("Title") as! NSString as String
            phone = Conservation.objectAtIndex(indexPath.row).objectForKey ("Phone") as! NSString as String
        }
        if indexPath.section == 5
        {
            name = DPW.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
            title = DPW.objectAtIndex(indexPath.row).objectForKey ("Title") as! NSString as String
            phone = DPW.objectAtIndex(indexPath.row).objectForKey ("Phone") as! NSString as String
        }
        else if indexPath.section == 6
        {
            name = Employment.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
            title = Employment.objectAtIndex(indexPath.row).objectForKey ("Title") as! NSString as String
            phone = Employment.objectAtIndex(indexPath.row).objectForKey ("Phone") as! NSString as String
        }
        if indexPath.section == 7
        {
            name = Fire.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
            title = Fire.objectAtIndex(indexPath.row).objectForKey ("Title") as! NSString as String
            phone = Fire.objectAtIndex(indexPath.row).objectForKey ("Phone") as! NSString as String
        }
        if indexPath.section == 8
        {
            name = Health.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
            title = Health.objectAtIndex(indexPath.row).objectForKey ("Title") as! NSString as String
            phone = Health.objectAtIndex(indexPath.row).objectForKey ("Phone") as! NSString as String
        }
        if indexPath.section == 9
        {
            name = Highway.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
            title = Highway.objectAtIndex(indexPath.row).objectForKey ("Title") as! NSString as String
            phone = Highway.objectAtIndex(indexPath.row).objectForKey ("Phone") as! NSString as String
        }
        if indexPath.section == 10
        {
            name = Library.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
            title = Library.objectAtIndex(indexPath.row).objectForKey ("Title") as! NSString as String
            phone = Library.objectAtIndex(indexPath.row).objectForKey ("Phone") as! NSString as String
        }
        if indexPath.section == 11
        {
            name = Police.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
            title = Police.objectAtIndex(indexPath.row).objectForKey ("Title") as! NSString as String
            phone = Police.objectAtIndex(indexPath.row).objectForKey ("Phone") as! NSString as String
        }
        if indexPath.section == 12
        {
            name = Parks.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
            title = Parks.objectAtIndex(indexPath.row).objectForKey ("Title") as! NSString as String
            phone = Parks.objectAtIndex(indexPath.row).objectForKey ("Phone") as! NSString as String
        }
        if indexPath.section == 13
        {
            name = Senior.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
            title = Senior.objectAtIndex(indexPath.row).objectForKey ("Title") as! NSString as String
            phone = Senior.objectAtIndex(indexPath.row).objectForKey ("Phone") as! NSString as String
        }
        if indexPath.section == 14
        {
            name = Technology.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
            title = Technology.objectAtIndex(indexPath.row).objectForKey ("Title") as! NSString as String
            phone = Technology.objectAtIndex(indexPath.row).objectForKey ("Phone") as! NSString as String
        }
        else if indexPath.section == 15
        {
            name = TownAdmin.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
            title = TownAdmin.objectAtIndex(indexPath.row).objectForKey ("Title") as! NSString as String
            phone = TownAdmin.objectAtIndex(indexPath.row).objectForKey ("Phone") as! NSString as String
        }
        if indexPath.section == 16
        {
            name = TownClerk.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
            title = TownClerk.objectAtIndex(indexPath.row).objectForKey ("Title") as! NSString as String
            phone = TownClerk.objectAtIndex(indexPath.row).objectForKey ("Phone") as! NSString as String
        }
        if indexPath.section == 17
        {
            name = Treasurer.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
            title = Treasurer.objectAtIndex(indexPath.row).objectForKey ("Title") as! NSString as String
            phone = Treasurer.objectAtIndex(indexPath.row).objectForKey ("Phone") as! NSString as String
        }
        else if indexPath.section == 18
        {
            name = Veteran.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
            title = Veteran.objectAtIndex(indexPath.row).objectForKey ("Title") as! NSString as String
            phone = Veteran.objectAtIndex(indexPath.row).objectForKey ("Phone") as! NSString as String
        }
        if indexPath.section == 19
        {
            name = Water.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
            title = Water.objectAtIndex(indexPath.row).objectForKey ("Title") as! NSString as String
            phone = Water.objectAtIndex(indexPath.row).objectForKey ("Phone") as! NSString as String
        }
        if indexPath.section == 20
        {
            name = Youth.objectAtIndex(indexPath.row).objectForKey ("Name") as! NSString as String
            title = Youth.objectAtIndex(indexPath.row).objectForKey ("Title") as! NSString as String
            phone = Youth.objectAtIndex(indexPath.row).objectForKey ("Phone") as! NSString as String
        }
        
         let alertController = UIAlertController(title: name, message: "Title: " + title + "\n"
            + "Phone: " + phone, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
        
        
    }

    

}
