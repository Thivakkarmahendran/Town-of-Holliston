//
//  SettingsViewController.swift
//  Town of Holliston
//
//  Created by Thivakkar Mahendran on 12/2/14.
//  Copyright (c) 2014 Thivakkar Mahendran. All rights reserved.
//

import UIKit
import CoreData


var Settingrespolice = "1"
var Settingresfire = "1"
var Settingresschool = "1"
var Settingrestown = "1"
class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.toolbarHidden = true

        let rect : CGRect = CGRectMake(0,0,self.view.frame.width,self.view.frame.height)
        var vista : UIView = UIView(frame: rect)
        let gradient : CAGradientLayer = CAGradientLayer()
        gradient.frame = vista.bounds
        let cor1 = UIColor.redColor().CGColor
        let cor2 = UIColor.whiteColor().CGColor
        let cor3 = UIColor.blueColor().CGColor
        let arrayColors = [cor1, cor2,cor3]
        gradient.colors = arrayColors
        view.layer.insertSublayer(gradient, atIndex: 0)
        
                
        let recognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeRight:")
        
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName: "Settings")
        if let fetchResults = context.executeFetchRequest(fetchRequest, error: nil) as? [Settings]
        {
            
            if fetchResults.isEmpty
            {
                
            }
            else
            {
                
                var request = NSFetchRequest (entityName: "Notification")
                request.returnsObjectsAsFaults = false
                var results:NSArray = context.executeFetchRequest(request, error:nil)!
                
                let res = results[0] as! NSManagedObject
                Settingrespolice = res.valueForKey("police") as! String
                Settingresfire = res.valueForKey("fire") as! String
                Settingresschool = res.valueForKey("school") as! String
                Settingrestown = res.valueForKey("town") as! String
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ///////
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return  1;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: settingscell = tableView.dequeueReusableCellWithIdentifier("Maincell") as! settingscell
        cell.switchcell.on = true
       
      
        if(indexPath.row == 0)
        {
            cell.Titlelabelcell.text = "Receive Notification:"
            cell.Titlelabelcell.textColor = UIColor.redColor()
            cell.switchcell.enabled = false
            cell.switchcell.hidden = true
            
        }
        if(indexPath.row == 1)
        {
            cell.Titlelabelcell.text = "Police"
            if(Settingrespolice == "0")
            {
            cell.switchcell.on = false
            }
        
        }
        else if(indexPath.row == 2)
        {
            cell.Titlelabelcell.text = "Fire"
            if(Settingresfire == "0")
            {
                cell.switchcell.on = false
            }
            
        }
        else if(indexPath.row == 3)
        {
            cell.Titlelabelcell.text = "School"
            if(Settingresschool == "0")
            {
                cell.switchcell.on = false
            }
            
        }
        else if(indexPath.row == 4)
        {
            cell.Titlelabelcell.text = "Town"
            if(Settingrestown == "0")
            {
                cell.switchcell.on = false
            }
             
        }
        
        return cell
    }
    ///////
    
    
    @IBAction func Done(sender: AnyObject) {
        
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName: "Settings")
        if let fetchResults = context.executeFetchRequest(fetchRequest, error: nil) as? [Settings]
        {
            if fetchResults.isEmpty
            {
               SetiingFirstDone()
            }
                
            else
            {
                SettingChangeDone()
            }

        }
    }
    
    func SetiingFirstDone()
    {
        
        let notificationTypes:UIUserNotificationType = UIUserNotificationType.Alert | UIUserNotificationType.Badge | UIUserNotificationType.Sound
        let notificationSettings:UIUserNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        var saveNotification: AnyObject =  NSEntityDescription.insertNewObjectForEntityForName("Notification", inManagedObjectContext: context)
        
        let currentInstallation:PFInstallation = PFInstallation.currentInstallation()
        
        if (Settingrespolice == "1")
        {
            saveNotification.setValue("1", forKey: "police")
            currentInstallation.addUniqueObject("Police", forKey: "channels")
        }
        else
        {
            saveNotification.setValue("0", forKey: "police")
        }
        
        if (Settingresfire == "1")
        {
            saveNotification.setValue("1", forKey: "fire")
            currentInstallation.addUniqueObject("Fire", forKey: "channels")
        }
        else
        {
            saveNotification.setValue("0", forKey: "fire")
        }
        
        if (Settingresschool == "1")
        {
            saveNotification.setValue("1", forKey: "school")
            
            currentInstallation.addUniqueObject("School", forKey: "channels")
        }
        else
        {
            saveNotification.setValue("0", forKey: "school")
        }
        
        if (Settingrestown == "1")
        {
            saveNotification.setValue("1", forKey: "town")
            currentInstallation.addUniqueObject("Town", forKey: "channels")
        }
        else
        {
            saveNotification.setValue("0", forKey: "town")
        }
        
        context.save(nil)
        
        
            currentInstallation.setValue(name, forKey: "Name")
            currentInstallation.setValue(email, forKey: "Email")
             currentInstallation.setValue(blocked, forKey: "Blocked")
            currentInstallation.saveInBackgroundWithTarget(nil, selector: nil)
            var FirstTime3: FirstTime3ViewController = self.storyboard?.instantiateViewControllerWithIdentifier("FirstTime3") as! FirstTime3ViewController
        self.presentViewController(FirstTime3, animated: true, completion: nil)

    }
    
    func SettingChangeDone()
    {
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        let currentInstallation:PFInstallation = PFInstallation.currentInstallation()
        var request = NSFetchRequest (entityName: "Notification")
        request.returnsObjectsAsFaults = false
        var results:NSArray = context.executeFetchRequest(request, error:nil)!
        context.deleteObject(results[0] as! NSManagedObject)
        context.save(nil)
        currentInstallation.removeObject("Police", forKey: "channels")
        currentInstallation.removeObject("Fire", forKey: "channels")
        currentInstallation.removeObject("School", forKey: "channels")
        currentInstallation.removeObject("Town", forKey: "channels")
         currentInstallation.saveInBackgroundWithTarget(nil, selector: nil)
        ////////////////
        var saveNotification: AnyObject =  NSEntityDescription.insertNewObjectForEntityForName("Notification", inManagedObjectContext: context)
        if (Settingrespolice == "1")
        {
        saveNotification.setValue("1", forKey: "police")
        currentInstallation.addUniqueObject("Police", forKey: "channels")
        }
        else
        {
        saveNotification.setValue("0", forKey: "police")
        }
        if (Settingresfire == "1")
        {
        saveNotification.setValue("1", forKey: "fire")
        currentInstallation.addUniqueObject("Fire", forKey: "channels")
        }
        else
        {
        saveNotification.setValue("0", forKey: "fire")
        }
        if (Settingresschool == "1")
        {
        saveNotification.setValue("1", forKey: "school")
        
        currentInstallation.addUniqueObject("School", forKey: "channels")
        }
        else
        {
        saveNotification.setValue("0", forKey: "school")
        }
        if (Settingrestown == "1")
        {
        saveNotification.setValue("1", forKey: "town")
        currentInstallation.addUniqueObject("Town", forKey: "channels")
        }
        else
        {
        saveNotification.setValue("0", forKey: "town")
        }
        context.save(nil)
        currentInstallation.saveInBackgroundWithTarget(nil, selector: nil)
        
        let alertController = UIAlertController(title: "Message", message: "You have succefully changed!!", preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "Dismiss", style: .Default) { (action) in
        }
         alertController.addAction(OKAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
}
