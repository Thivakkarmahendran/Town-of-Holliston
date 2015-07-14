//  ReportViewController.swift
//  Town of Holliston
//
//  Created by Thivakkar Mahendran on 12/19/14.
//  Copyright (c) 2014 Thivakkar Mahendran. All rights reserved.
//

import UIKit
import Foundation

var SuggestFeed = NSMutableArray()

class  SuggestViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var ReportTableView: UITableView!
    var refreshControl:UIRefreshControl!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        var query1 = PFQuery(className:"Report")
        query1.findObjectsInBackgroundWithBlock({ (objects:[AnyObject]?, NSError) -> Void in
            println("Loading: Downloading Suggestion")
            SuggestFeed.addObjectsFromArray(objects!.reverse())
            self.ReportTableView.reloadData()
        })

        
        self.navigationController?.toolbarHidden = true
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to Add")
       self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.ReportTableView.addSubview(refreshControl)
      ReportTableView.editing = true
    }
    
   
   
    func refresh(sender:AnyObject)
    {
        if(blocked == false)
        {
        var inputTextFieldTitle: UITextField?
        var inputTextFieldDesc: UITextField?
        let alertController = UIAlertController(title: "Add Suggestion", message: "", preferredStyle: .Alert)
        let cancel = UIAlertAction(title: "Cancel", style: .Default, handler: { (action) -> Void in
        })
        alertController.addAction(cancel)
        let ok = UIAlertAction(title: "Done", style: .Default, handler: { (action) -> Void in
            
            let currentInstallation:PFInstallation = PFInstallation.currentInstallation()
            var sendreport = PFObject(className:"Report")
            sendreport["Title"] = inputTextFieldTitle?.text
            sendreport["Description"] = inputTextFieldDesc?.text
            sendreport["User"] = currentInstallation.installationId
            sendreport["Name"] = name
            sendreport["Email"] = email
            sendreport["Vote"] = 0
            sendreport.saveInBackgroundWithTarget(nil, selector: nil)
            let alert = UIAlertView()
            alert.title = "Submitted"
            alert.message = "You post will be published in few minutes!!"
            alert.addButtonWithTitle("Understod")
            alert.show()
            
        })
        alertController.addAction(ok)
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Title"
            inputTextFieldTitle = textField
        }
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Description"
            inputTextFieldDesc = textField
        }
        presentViewController(alertController, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertView()
            alert.title = "Alert"
            alert.message = "You have been blocked from posting!!"
            alert.addButtonWithTitle("Understood")
            alert.show()
        }
        self.refreshControl.endRefreshing()
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return SuggestFeed.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return  1;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: SuggestTableViewCell = tableView.dequeueReusableCellWithIdentifier("Maincell") as! SuggestTableViewCell
        cell.title?.text = SuggestFeed.objectAtIndex(indexPath.row).objectForKey ("Title") as! NSString as String
        cell.descriptionCell?.text = SuggestFeed.objectAtIndex(indexPath.row).objectForKey ("Description") as! NSString as String
         var cellvote =  SuggestFeed.objectAtIndex(indexPath.row).objectForKey ("Vote") as! NSInteger
        cell.VoteCounterLabel?.text = String(cellvote)
        if(cellvote > 0)
        {
             cell.VoteCounterLabel.textColor = UIColor.greenColor()
        }
        else if (cellvote < 0)
        {
            cell.VoteCounterLabel.textColor = UIColor.redColor()
        }
        
        return cell
    }


    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
      func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]?  {
        let indexPath1 = tableView.indexPathForSelectedRow();
        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! SuggestTableViewCell;
        
        var vote =  SuggestFeed.objectAtIndex(indexPath.row).objectForKey ("Vote") as! NSInteger
        
        var objectID: String = String(stringInterpolationSegment: SuggestFeed.objectAtIndex(indexPath.row).objectId)
        objectID = objectID.stringByReplacingOccurrencesOfString("Optional(", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil);
        objectID = objectID.stringByReplacingOccurrencesOfString(")", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil);
        objectID = objectID.stringByReplacingOccurrencesOfString("\"", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil);
        var buttonDisable = 0
        var shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Vote Up" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
        
        if buttonDisable == 0 || buttonDisable == 1
        {
        vote = vote + 1
        currentCell.VoteCounterLabel.text = String(vote)
        buttonDisable = 2
            var query = PFQuery(className:"Report")
            query.getObjectInBackgroundWithId(objectID) {
                (gameScore: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    println(error)
                } else if let gameScore = gameScore {
                    gameScore["Vote"] = vote
                    gameScore.saveInBackgroundWithTarget(nil, selector: nil)
                }
            }
        }
        else{
        let alert = UIAlertView()
        alert.title = "Alert"
        alert.message = "You can't vote twice!"
        alert.addButtonWithTitle("Dismiss")
        alert.show()
        }
        
        
        
        })
        
        var rateAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Vote Down" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
        
        if buttonDisable == 0 || buttonDisable == 2
        {
        vote = vote - 1
        currentCell.VoteCounterLabel.text = String(vote)
        buttonDisable = 1
        var query = PFQuery(className:"Report")
        
            query.getObjectInBackgroundWithId(objectID) {
                (gameScore: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    println(error)
                } else if let gameScore = gameScore {
                    gameScore["Vote"] = vote
                    gameScore.saveInBackgroundWithTarget(nil, selector: nil)
                }
            }

        }
        else
        {
        let alert = UIAlertView()
        alert.title = "Alert"
        alert.message = "You can't vote twice!"
        alert.addButtonWithTitle("Dismiss")
        alert.show()
        }
        
        
        })
        
        shareAction.backgroundColor = UIColor.blueColor()
        
        return [shareAction,rateAction]

    
}

}
