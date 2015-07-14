//
//  reportviewcontrollerList.swift
//  Town of Holliston
//
//  Created by Thivakkar Mahendran on 3/27/15.
//  Copyright (c) 2015 Thivakkar Mahendran. All rights reserved.
//

import UIKit
import Foundation
import MessageUI


class  reportviewcontrollerList: UIViewController, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var reporttableviewlist: UITableView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.toolbarHidden = true
        reporttableviewlist.estimatedRowHeight = 44
        reporttableviewlist.rowHeight = UITableViewAutomaticDimension
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "mainmenu2.png")?.drawInRect(self.view.bounds)
        var image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)

    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return  1;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: reporttableviewlistcell = tableView.dequeueReusableCellWithIdentifier("Maincell") as! reporttableviewlistcell
        
        if(indexPath.row == 0)
        {
           cell.titlelabel.text = "STREET LIGHT OUT"
        }
        else if(indexPath.row == 1)
        {
            cell.titlelabel.text = "GEO REPORT"
        }
        else if(indexPath.row == 2)
        {
            cell.titlelabel.text = "Feature request or bug report"
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if(indexPath.row == 0)
        {
    self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("streetlightout") as! UITableViewController, animated: true)
        }
        else if(indexPath.row == 1)
        {
            self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("mapreport") as! UIViewController, animated: true)
        }
        else if(indexPath.row == 2)
        {
            
            if (MFMailComposeViewController.canSendMail()) {
                
                var emailTitle = "Holliston App"
                var messageBody = ""
                var toRecipents = ["thivakkarmahendransoftware@gmail.com"]
                
                var mc:MFMailComposeViewController = MFMailComposeViewController()
                
                mc.mailComposeDelegate = self
                mc.setSubject(emailTitle)
                
                mc.setMessageBody(messageBody, isHTML: false)
                
                mc.setToRecipients(toRecipents)
                
                self.presentViewController(mc, animated: true, completion: nil)
                
            }else {
                
                println("No email account found")
                
            }
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        
        switch result.value {
            
        case MFMailComposeResultCancelled.value:
            println("Mail Cancelled")
        case MFMailComposeResultSaved.value:
            println("Mail Saved")
        case MFMailComposeResultSent.value:
            println("Mail Sent")
        case MFMailComposeResultFailed.value:
            println("Mail Failed")
        default:
            break
            
        }
        
        self.dismissViewControllerAnimated(false, completion: nil)
        
    }



}
