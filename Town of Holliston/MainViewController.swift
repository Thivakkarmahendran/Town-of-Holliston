//
//  MainViewController.swift
//  Town of Holliston
//
//  Created by Thivakkar Mahendran on 10/29/14.
//  Copyright (c) 2014 Thivakkar Mahendran. All rights reserved.
//

import UIKit
import Foundation





//////weather variable//////
var currenttemp = 0.0;
var sunrise = " ";
var sunset = " ";
var humidity = 0.0;
var winddescp = " "
var skydescp = " "
var weatherimage = "0"
var weekweather = NSMutableArray()

class MainViewController: UIViewController, NSXMLParserDelegate, UICollectionViewDataSource, UICollectionViewDelegate  {
    @IBOutlet weak var currenttemplabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    var parser = NSXMLParser()
    
    @IBOutlet var pagecontrol: UIPageControl!
    @IBOutlet var weatherview1: UIView!
    @IBOutlet var weatherview2: UIView!
    
    //////////////////
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "mainmenu1.jpg")?.drawInRect(self.view.bounds)
        var image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        
        self.navigationController?.toolbarHidden = true
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "methodOfReceivedNotification:", name:"NotificationIdentifier", object: nil)
        
        

        
    }
    
    override func viewWillAppear(animated: Bool) {
           loadWeather()

    }
    
    
    func methodOfReceivedNotification(notification: NSNotification){
        println("came here")
    }
  ////////weather
    
    func loadWeather()
    {
        //weather
        //var url = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=01746&mode=xml&units=imperial")
        var url = NSURL(string: "http://weather.yahooapis.com/forecastrss?w=2423210&u=f")
        parser = NSXMLParser(contentsOfURL: url)!
        parser.delegate = self
        parser.parse()
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject: AnyObject])
    {
        
        if (elementName as NSString).isEqualToString("yweather:condition")
        {
            var ctemp: (AnyObject?) = (attributeDict["temp"])
            var ctemp2 = ctemp as! String
            var cmyNSString = NSString(string: ctemp2)
            currenttemp = cmyNSString.doubleValue
            
            var ctemp3: (AnyObject?) = (attributeDict["code"])
            weatherimage = ctemp3 as! String
            
            var ctemp4: (AnyObject?) = (attributeDict["text"])
            skydescp = ctemp4 as! String
            
        }
        
        else if (elementName as NSString).isEqualToString("yweather:atmosphere")
        {
            var ctemp: (AnyObject?) = (attributeDict["humidity"])
            var ctemp2 = ctemp as! String
            var cmyNSString = NSString(string: ctemp2)
            humidity = cmyNSString.doubleValue
        }
        else if (elementName as NSString).isEqualToString("yweather:wind")
        {
            var ctemp: (AnyObject?) = (attributeDict["speed"])
            winddescp = ctemp as! String
        }
        
        else if (elementName as NSString).isEqualToString("yweather:astronomy")
        {
            var ctemp: (AnyObject?) = (attributeDict["sunrise"])
            sunrise = ctemp as! String
            
            var ctemp2: (AnyObject?) = (attributeDict["sunset"])
            sunset = ctemp2 as! String
        }
        else if (elementName as NSString).isEqualToString("yweather:forecast")
        {
            weekweather.addObject(attributeDict)
        }
    }
    
     func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        weatherview2.hidden = true
        weatherview1.hidden = false
    }
    
    @IBAction func pagecontrol(sender: AnyObject) {
        var page = pagecontrol.currentPage
        if(page == 1)
        {
            weatherview2.hidden = false
            weatherview1.hidden = true
        }
        if(page == 0)
        {
            weatherview2.hidden = true
            weatherview1.hidden = false
        }
    }
    
    
    //////////////end weather///////
    
    override func viewDidAppear(animated: Bool)
    {
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0))
            {
                let currentInstallation:PFInstallation = PFInstallation.currentInstallation()
                currentInstallation.fetch()
                blocked = (currentInstallation.objectForKey("Blocked")) as! Bool
            }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return townNewsRss.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! collectioncell
        
        cell.Title.text = townNewsRss.objectAtIndex(indexPath.row).objectForKey ("title") as! NSString as String
        var descE = townNewsRss.objectAtIndex(indexPath.row).objectForKey("description") as! String
        
        descE = descE.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
        descE = descE.stringByReplacingOccurrencesOfString("&nbsp;", withString: " ", options: .RegularExpressionSearch, range: nil)
        descE = descE.stringByReplacingOccurrencesOfString("&rsquo;s", withString: " ", options: .RegularExpressionSearch, range: nil)
        descE = descE.stringByReplacingOccurrencesOfString("&rsquo;s", withString: " ", options: .RegularExpressionSearch, range: nil)
        descE = descE.stringByReplacingOccurrencesOfString("&gt;", withString: " ", options: .RegularExpressionSearch, range: nil)
        descE = descE.stringByReplacingOccurrencesOfString("&frac12;", withString: " ", options: .RegularExpressionSearch, range: nil)
        descE = descE.stringByReplacingOccurrencesOfString("&ldquo;", withString: " ", options: .RegularExpressionSearch, range: nil)
        descE = descE.stringByReplacingOccurrencesOfString("&mdash;", withString: " ", options: .RegularExpressionSearch, range: nil)
        descE = descE.stringByReplacingOccurrencesOfString("&ndash;", withString: " ", options: .RegularExpressionSearch, range: nil)
        cell.Description.text = descE
       cell.layer.cornerRadius = 10.0;
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {

      
        if(view.frame.height == 480)
        {
             return CGSizeMake(225, 175)
        }
        else if(view.frame.height == 667)
        {
            return CGSizeMake(225, 300)
        }
        else if(view.frame.height == 736)
        {
            return CGSizeMake(225, 375)
        }
        else
        {
          return CGSizeMake(233, 240)
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        webviewurl = townNewsRss.objectAtIndex(indexPath.row).objectForKey ("link") as! NSString as String
        self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("webview") as! UIViewController, animated: true)
         
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        cell.layer.transform = CATransform3DMakeRotation(-90.0, 0.0, 0.7, 0.4)
        cell.layer.shadowOffset = CGSizeMake(10, 10)
        UIView.animateWithDuration(0.5, delay:0, options: .AllowUserInteraction, animations: {
            
            cell.layer.transform = CATransform3DMakeRotation(0.0, 0.0, 0.0, 0.0)
            cell.layer.shadowOffset = CGSizeMake(0, 0)
            }, completion: nil)
    }
    
}
