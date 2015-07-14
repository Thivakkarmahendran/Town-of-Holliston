//
//  LiveViewController.swift
//  Town of Holliston
//
//  Created by Thivakkar Mahendran on 11/4/14.
//  Copyright (c) 2014 Thivakkar Mahendran. All rights reserved.
//

import UIKit
 import AVFoundation


class LiveViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var LiveTableView: UITableView!
    var feedName = ["Police Department", "Fire Department", "Holliston Schools", "Holliston High School"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.toolbarHidden = true
    }
    


    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
        
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return feedName.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return  1;
    }
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath)
    {
        //cell.layer.transform = CATransform3DMakeScale(0.1,0.1,0.1)
        cell.layer.transform = CATransform3DMakeRotation(-90.0, 0.0, 0.7, 0.4)
        cell.layer.shadowOffset = CGSizeMake(10, 10)
        cell.backgroundColor = UIColor.blueColor()
        cell.alpha = 0
        cell.layer.anchorPoint = CGPointMake(0, 0.5)
        UIView.animateWithDuration(0.4, animations: {
            //cell.layer.transform = CATransform3DMakeScale(1,1,1)
            cell.layer.transform = CATransform3DMakeRotation(0, 0, 0, 0)
            cell.alpha = 1
            cell.layer.shadowOffset = CGSizeMake(0, 0)
        })
        
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: LiveTableViewCell = tableView.dequeueReusableCellWithIdentifier("Maincell") as! LiveTableViewCell
        var title = ""
        title = feedName[indexPath.row]
        cell.LivecellTitle.text = title
       return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
       
        if(indexPath.row == 0)
        {
         myURLString = "https://twitter.com/hollistonpolice"
        }
        else if(indexPath.row == 1)
        {
          myURLString = "https://twitter.com/hollistonfd"
        }
        else if(indexPath.row == 2)
        {
            myURLString = "https://twitter.com/holliston_ps"
        }
        else if(indexPath.row == 3)
        {
            myURLString = "https://twitter.com/hollistonhigh"
        }
        
        self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("twitterfeed") as! UITableViewController, animated: true)
    }
    
    

    
    

}
