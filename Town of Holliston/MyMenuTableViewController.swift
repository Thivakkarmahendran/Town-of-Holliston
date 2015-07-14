//
//  MyMenuTableViewController.swift
//  Town of Holliston
//
//  Created by Thivakkar Mahendran on 10/29/14.
//  Copyright (c) 2014 Thivakkar Mahendran. All rights reserved.
//

import UIKit
import CoreData





class MyMenuTableViewController: UITableViewController {
    
    var selectedMenuItem : Int = 0
   

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.toolbarHidden = true
        
        tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0) //
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.clearColor()
        tableView.scrollsToTop = false
        self.clearsSelectionOnViewWillAppear = false
        tableView.selectRowAtIndexPath(NSIndexPath(forRow: selectedMenuItem, inSection: 0), animated: false, scrollPosition: .Middle)
        
        }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        var numofSections = 10
        let fetchRequest = NSFetchRequest(entityName: "Admin")
        if let fetchResults = context.executeFetchRequest(fetchRequest, error: nil) as? [Settings]
        {
            if fetchResults.isEmpty
            {
             
                numofSections = 9
            }
            
        }
        
        return numofSections
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("CELL") as? UITableViewCell
        
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CELL")
            cell!.backgroundColor = UIColor.clearColor()
            cell!.textLabel?.textColor = UIColor.darkGrayColor()
            let selectedBackgroundView = UIView(frame: CGRectMake(0, 0, cell!.frame.size.width, cell!.frame.size.height))
            selectedBackgroundView.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.2)
            cell!.selectedBackgroundView = selectedBackgroundView
        }
        
         var test = indexPath.row
        if test == 0
        {
            cell!.textLabel?.text = "Main"
        }
        else if test == 1
        {
            cell!.textLabel?.text = "News"
        }
        else if test == 2
        {
            cell!.textLabel?.text = "Events"
        }
        else if test == 3
        {
            cell!.textLabel?.text = "Live Feed"
        }
        else if test == 4
        {
            cell!.textLabel?.text = "Directory"
        }
        else if test == 5
        {
            cell!.textLabel?.text = "Settings"
        }
        else if test == 6
        {
            cell!.textLabel?.text = "Report"
        }
        else if test == 7
        {
            cell!.textLabel?.text = "Suggestion"
        }
        else if test == 8
        {
            cell!.textLabel?.text = "About"
        }
        else if test == 9
        {
            cell!.textLabel?.text = "Notification"
        }
        

       
        //cell!.textLabel.text = "ViewController #\(indexPath.row+1)"
        
        return cell!
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if (indexPath.row == selectedMenuItem) {
            return
        }
        selectedMenuItem = indexPath.row
        
        //Present new view controller
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        switch (indexPath.row) {
        case 0:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Main") as! UIViewController
            sideMenuController()?.setContentViewController(destViewController)
            
            break
        case 1:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("News") as! UIViewController
            sideMenuController()?.setContentViewController(destViewController)
            
            break
        case 2:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Events") as! UIViewController
            sideMenuController()?.setContentViewController(destViewController)
            
            break
        case 3:
            
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Live") as! UIViewController
            sideMenuController()?.setContentViewController(destViewController)
            break
        case 4:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Directory") as! UIViewController
            sideMenuController()?.setContentViewController(destViewController)
            break
        case 5:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Settings") as! UIViewController
            sideMenuController()?.setContentViewController(destViewController)
            break
        case 6:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("report") as! UIViewController
            sideMenuController()?.setContentViewController(destViewController)
            break
        case 7:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("suggest") as! UIViewController
            sideMenuController()?.setContentViewController(destViewController)
            break
        case 8:
            let alertController = UIAlertController(title: "About", message: "Version: 1.0 \n App by Thivakkar Mahendran", preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "Dismiss", style: .Default) { (action) in
           }
            alertController.addAction(OKAction)
            presentViewController(alertController, animated: true, completion: nil)
            
            break
        default:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Notification") as! UIViewController
            sideMenuController()?.setContentViewController(destViewController)
            break
        }
    }
    



    
    
    
}
