//
//  FirstTime3ViewController.swift
//  Town of Holliston
//
//  Created by Thivakkar Mahendran on 12/2/14.
//  Copyright (c) 2014 Thivakkar Mahendran. All rights reserved.
//

import UIKit
import Social
import CoreData

class FirstTime3ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.toolbarHidden = true

        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "mainmenu.jpg")?.drawInRect(self.view.bounds)
        var image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   

    
    @IBAction func Facebook(sender: AnyObject) {
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
            var facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookSheet.setInitialText("I just downloaded the offical Town of Holliston App, I think you should also")
            self.presentViewController(facebookSheet, animated: true, completion: nil)
        } else {
            var alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

    @IBAction func Twitter(sender: AnyObject) {
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter){
            var twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterSheet.setInitialText("I just downloaded the offical Town of Holliston App, I think you should also")
            self.presentViewController(twitterSheet, animated: true, completion: nil)
        } else {
            var alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    

    @IBAction func Done(sender: AnyObject) {
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        
        var firsttime: AnyObject =  NSEntityDescription.insertNewObjectForEntityForName("Settings", inManagedObjectContext: context)
        firsttime.setValue("No", forKey: "firstUser")
        context.save(nil)

        let alertController = UIAlertController(title: "Message", message: "Please close the app completely and start again now", preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "Dismiss", style: .Default) { (action) in
        }
        alertController.addAction(OKAction)
        presentViewController(alertController, animated: true, completion: nil)
       
    }
    
    @IBAction func Terms(sender: AnyObject) {
        
        var url : NSURL
        url = NSURL(string: "http://mthivakkar.wix.com/hollistonapp#!terms-and-conditions/c1l5g")!
        UIApplication.sharedApplication().openURL(url)
    }
  
    
    
}
