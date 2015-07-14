//
//  EventsViewController.swift
//  Town of Holliston
//
//  Created by Thivakkar Mahendran on 10/31/14.
//  Copyright (c) 2014 Thivakkar Mahendran. All rights reserved.
//

import UIKit
import Foundation
import QuartzCore
import AVFoundation
import EventKit


var feedsEvents = NSMutableArray()
var feedsEventsUpcoming = NSMutableArray()
var feedsEventsToday = NSMutableArray()
var feedsEventsPast = NSMutableArray()

class EventsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSXMLParserDelegate {
    @IBOutlet weak var EventTableView: UITableView!
    
    
    var parser = NSXMLParser()
    var elements = NSMutableDictionary()
    var element = NSString()
    var ftitle = NSMutableString()
    var link = NSMutableString()
    var fdescription = NSMutableString()

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.toolbarHidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "mainmenu1.jpg")?.drawInRect(self.view.bounds)
        var image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        
    }
    
    func loadParserEvents()
    {
        feedsEvents = []
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitDay | .CalendarUnitMonth | .CalendarUnitYear, fromDate: date)
        let year = components.year
        let month = components.month
        
        var url: NSURL = NSURL(string: "http://www.townofholliston.us/node/\(year)-\(month)/town-events/feed")!
        
        parser = NSXMLParser (contentsOfURL: url)!
        parser.delegate = self
        parser.shouldProcessNamespaces = false
        parser.shouldReportNamespacePrefixes = false
        parser.shouldResolveExternalEntities = false
        parser.parse()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        element = elementName
        
        if (element as NSString).isEqualToString("item")
        {
            elements = NSMutableDictionary.alloc()
            elements = [:]
            ftitle = NSMutableString.alloc ()
            ftitle = ""
            link = NSMutableString.alloc()
            link = ""
            fdescription = NSMutableString.alloc()
            fdescription = ""
            
        }
        
    }
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        
        if (elementName as NSString).isEqualToString("item") {
            if ftitle != "" {
                elements.setObject(ftitle, forKey: "title")
                
            }
            
            if (link != "") {
                elements.setObject(link, forKey: "link")
                
            }
            
            if (fdescription != "") {
                
                
                var fdescString = String(fdescription)
                let str = fdescString.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
                let split=str.componentsSeparatedByString("&nbsp;")
                let split1 = split[1].componentsSeparatedByString(",")
                var  final=split1[0]
                final = final.stringByReplacingOccurrencesOfString("\n", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil);
                final = final.stringByReplacingOccurrencesOfString("\t", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil);
                final = final.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil);
                final = final.stringByReplacingOccurrencesOfString("January", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil);
                final = final.stringByReplacingOccurrencesOfString("Febraury", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil);
                final = final.stringByReplacingOccurrencesOfString("March", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil);
                final = final.stringByReplacingOccurrencesOfString("April", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil);
                final = final.stringByReplacingOccurrencesOfString("May", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil);
                final = final.stringByReplacingOccurrencesOfString("June", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil);
                final = final.stringByReplacingOccurrencesOfString("July", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil);
                final = final.stringByReplacingOccurrencesOfString("August", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil);
                final = final.stringByReplacingOccurrencesOfString("September", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil);
                final = final.stringByReplacingOccurrencesOfString("October", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil);
                final = final.stringByReplacingOccurrencesOfString("November", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil);
                final = final.stringByReplacingOccurrencesOfString("December", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil);
                
                if(count(final) == 1)
                {
                 final = "0" + final
                }
                elements.setObject(final, forKey: "description")
                
                
            }
            feedsEvents.addObject(elements)
           
        }
        
    }
    func parser(parser: NSXMLParser, foundCharacters string: String?)
    {
        
        
        if element.isEqualToString("title"){
            ftitle.appendString(string!)
            
            
        }else if element.isEqualToString("link"){
            link.appendString(string!)
            
            
        }else if element.isEqualToString("description"){
            fdescription.appendString(string!)
            
        }
        
    }
    func parserDidEndDocument(parser: NSXMLParser)
    {
        let sd = NSSortDescriptor(key: "description", ascending: true)
        feedsEvents.sortUsingDescriptors([sd])
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitDay | .CalendarUnitMonth | .CalendarUnitYear, fromDate: date)
        let day = components.day
        
        for var i = 0; i < feedsEvents.count; i++
        {
            var desc1 = feedsEvents.objectAtIndex(i).objectForKey("description") as! String
            var desc = (desc1.toInt())
            if(day == desc)
            {
                feedsEventsToday.addObject(feedsEvents.objectAtIndex(i))
            }
            else if(day < desc)
            {
                feedsEventsUpcoming.addObject(feedsEvents.objectAtIndex(i))
            }
            else
            {
                feedsEventsPast.addObject(feedsEvents.objectAtIndex(i))
            }
        }
 
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 1
        if section == 0
        {
            rows = feedsEventsToday.count
        }
        if section == 1
        {
            rows = feedsEventsUpcoming.count
        }
        if section == 2
        {
            rows = feedsEventsPast.count
        }

        return rows
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return  3;
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath)
    {
        //cell.layer.transform = CATransform3DMakeScale(0.1,0.1,0.1)
        cell.layer.transform = CATransform3DMakeRotation(90.0, 0.0, 0.7, 0.4)
        cell.layer.shadowColor = UIColor.blackColor().CGColor
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
        
        UIView.animateWithDuration(1, animations: {
            cell.backgroundColor = UIColor.whiteColor()
        })
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitDay | .CalendarUnitMonth | .CalendarUnitYear, fromDate: date)
        let year = components.year
        let month = components.month
       
        let cell: EventsTableViewCell = tableView.dequeueReusableCellWithIdentifier("Maincell1") as! EventsTableViewCell
        
        if indexPath.section == 0
        {
            cell.eventcellTitle.text = feedsEventsToday.objectAtIndex(indexPath.row).objectForKey ("title") as! NSString as String
            cell.eventcellDesc.numberOfLines = 1
            var descE = feedsEventsToday.objectAtIndex(indexPath.row).objectForKey("description") as! String
            
            descE = "\(month)-\(descE)-\(year)"
            cell.eventcellDesc.text = descE
        }
        else if indexPath.section == 1
        {
            cell.eventcellTitle.text = feedsEventsUpcoming.objectAtIndex(indexPath.row).objectForKey ("title") as! NSString as String
            cell.eventcellDesc.numberOfLines = 1
            var descE = feedsEventsUpcoming.objectAtIndex(indexPath.row).objectForKey("description") as! String
            
            descE = "\(month)-\(descE)-\(year)"
            cell.eventcellDesc.text = descE
        }
        else if indexPath.section == 2
        {
            cell.eventcellTitle.text = feedsEventsPast.objectAtIndex(indexPath.row).objectForKey ("title") as! NSString as String
            cell.eventcellDesc.numberOfLines = 1
            var descE = feedsEventsPast.objectAtIndex(indexPath.row).objectForKey("description") as! String
            
            descE = "\(month)-\(descE)-\(year)"
            cell.eventcellDesc.text = descE
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]?
    {
        let indexPath1 = tableView.indexPathForSelectedRow();
        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! EventsTableViewCell;
      
        
        var shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Add to Calendar" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            
            let eventStore = EKEventStore()
            let event = EKEvent(eventStore: eventStore)
            event.title = currentCell.eventcellTitle.text
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            var dateFromString = dateFormatter.dateFromString(currentCell.eventcellDesc.text!)
            event.startDate = dateFromString
            event.allDay = true
            event.calendar = eventStore.defaultCalendarForNewEvents
            
            var saveError : NSError? = nil
            eventStore.saveEvent(event, span: EKSpanThisEvent, commit: true, error: &saveError)
            
            var alertView = UIAlertView()
            alertView.addButtonWithTitle("Dismiss")
            alertView.title = "Calender"
            alertView.message = "Event has been successfully added"
            alertView.show()
            
            //// Following checks for errors and prints result to Debug Area ////
            if saveError != nil {
                println("Saving event to Calendar failed with error: \(saveError!)")
            } else {
                println("Successfully saved '\(event.title)' to '\(event.calendar.title)' calendar.")
            }
        })
        
        var remind = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Remind" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            var dateFromString = dateFormatter.dateFromString(currentCell.eventcellDesc.text!)
            
            var localNotification: UILocalNotification = UILocalNotification()
            localNotification.alertAction = "Event Reminder"
            localNotification.alertBody = currentCell.eventcellTitle.text
            localNotification.fireDate = dateFromString
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
           
            
            var alertView = UIAlertView()
            alertView.addButtonWithTitle("Dismiss")
            alertView.title = "Reminder"
            alertView.message = "You will be reminded!!"
            alertView.show()
            
        })

        shareAction.backgroundColor = UIColor.redColor()
        remind.backgroundColor = UIColor.blueColor()
 
        
        
        return [remind, shareAction]
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        var sectionname = ""
        
        if section == 0
        {
            sectionname = "Today"
        }
        else if section == 1
        {
            sectionname =  "Upcoming"
        }
        else if section == 2
        {
            sectionname = "Past"
        }
        return sectionname
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        var header: UILabel = UILabel()
        if section == 0
        {
            header.text =  "Today"
        }
        else if section == 1
        {
            header.text = "Upcoming"
        }
        else if section == 2
        {
            header.text = "Past"
        }
        header.backgroundColor = UIColor.blackColor()
        header.textColor = UIColor.whiteColor()
        header.font = UIFont.boldSystemFontOfSize(18.0)
        header.textAlignment = NSTextAlignment.Center
        return header
    }


    
    override func viewWillDisappear(animated: Bool) {
      
    }
}
