//
//  LaunchViewController.swift
//  Town of Holliston
//
//  Created by Thivakkar Mahendran on 12/18/14.
//  Copyright (c) 2014 Thivakkar Mahendran. All rights reserved.
//

import UIKit
import MediaPlayer
import CoreData

var townNewsRss = NSMutableArray()
class LaunchViewController: UIViewController, NSXMLParserDelegate {
    
    var parser = NSXMLParser()
    var elements = NSMutableDictionary()
    var element = NSString()
    var ftitle = NSMutableString()
    var link = NSMutableString()
    var fdescription = NSMutableString()
    var moviePlayer : MPMoviePlayerController?
    var txtField: UITextField?
    var txtField1: UITextField?
    
    @IBOutlet weak var LoadingUpdateLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.toolbarHidden = true
       
        //news
        //var url = NSURL(string: "http://holliston.wickedlocal.com/news/community?template=rss&mime=xml")
        var url = NSURL(string: "http://www.rssmix.com/u/8129134/rss.xml")
        parser = NSXMLParser(contentsOfURL: url)!
        parser.shouldProcessNamespaces = true
        parser.shouldReportNamespacePrefixes = true
        parser.shouldResolveExternalEntities = true
        parser.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName: "Settings")
        if let fetchResults = context.executeFetchRequest(fetchRequest, error: nil) as? [Settings]
        {
            if fetchResults.isEmpty
            {
                var FirstTime1: FirstTime1ViewController = self.storyboard?.instantiateViewControllerWithIdentifier("FirstTime1") as! FirstTime1ViewController
                self.presentViewController(FirstTime1, animated: true, completion: nil)
                
            }
            else
            {
                
                start()
            }
        }

    }
    
    
    func start()
    {
        var url:NSURL = NSBundle.mainBundle().URLForResource("intro", withExtension: "mp4")!
        moviePlayer = MPMoviePlayerController(contentURL: url)
        moviePlayer!.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        self.view.addSubview(moviePlayer!.view)
        moviePlayer!.fullscreen = false
        moviePlayer?.scalingMode = MPMovieScalingMode.AspectFit
        moviePlayer!.controlStyle = MPMovieControlStyle.None
        moviePlayer?.play()
        
        txtField = UITextField(frame: CGRect(x: 10, y: view.frame.height - 35, width: view.frame.width - 10, height: 30.00));
        txtField!.borderStyle = UITextBorderStyle.Line
        txtField!.center = CGPointMake(self.view.frame.size.width/2, view.frame.height - 35);
        txtField!.sizeToFit()
        txtField!.text = "Copyright (c) Thivakkar Mahendran."
        txtField!.textColor = UIColor.whiteColor()
        txtField!.backgroundColor = UIColor.redColor()
        txtField!.layer.cornerRadius = 5.0;
        txtField!.layer.borderWidth = 1.5
        moviePlayer!.view.addSubview(txtField!)
        
        let currentInstallation:PFInstallation = PFInstallation.currentInstallation()
        name = String(stringInterpolationSegment: currentInstallation.objectForKey("Name"))
       name = name.stringByReplacingOccurrencesOfString("Optional(", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil);
        name = name.stringByReplacingOccurrencesOfString(")", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil);
        email = String(stringInterpolationSegment: currentInstallation.objectForKey("Email"))
        email = email.stringByReplacingOccurrencesOfString("Optional(", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil);
        email = email.stringByReplacingOccurrencesOfString(")", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil);
        
        submitData()
        txtField1 = UITextField(frame: CGRect(x: 10, y: 15, width: (view.frame.width - 10), height: 30.00));
        self.view.addSubview(txtField1!)
        self.txtField1!.center = CGPointMake(self.view.frame.size.width/2, 30);
        self.txtField1!.borderStyle = UITextBorderStyle.Line
        self.txtField!.sizeToFit()
        self.txtField1!.layer.cornerRadius = 5.0;
        self.txtField1!.layer.borderWidth = 1.5
        self.txtField1!.text = "Welcome Back \(name)"
        self.txtField1!.textColor = UIColor.whiteColor()
        self.txtField1!.backgroundColor = UIColor.blueColor()
        self.txtField1!.transform = CGAffineTransformMakeScale(0.01, 0.01);
        UIView.animateWithDuration(3.0, delay:0, options: .AllowUserInteraction, animations: {
            self.txtField1!.transform = CGAffineTransformMakeScale(1, 1);
            }, completion: nil)
        
        
        self.launchsetup()
    }

    /////news rss////
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject: AnyObject])
    {
        element = elementName
        
        if (element as NSString).isEqualToString("item") {
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
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqualToString("item") {
            if ftitle != "" {
                var ftitleString = String(ftitle)
                ftitleString = ftitleString.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
                ftitleString = ftitleString.stringByReplacingOccurrencesOfString("\n", withString: "", options: .RegularExpressionSearch, range: nil)
                ftitleString = ftitleString.stringByReplacingOccurrencesOfString("\t", withString: "", options: .RegularExpressionSearch, range: nil)
                elements.setObject(ftitleString, forKey: "title")
            }
            if (link != "") {
                var flinkString = String(link)
                flinkString = flinkString.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
                flinkString = flinkString.stringByReplacingOccurrencesOfString("\n", withString: "", options: .RegularExpressionSearch, range: nil)
                flinkString = flinkString.stringByReplacingOccurrencesOfString("\t", withString: "", options: .RegularExpressionSearch, range: nil)
                elements.setObject(flinkString, forKey: "link")
            }
            
            if (fdescription != "") {
                var fdescString = String(fdescription)
                fdescString = fdescString.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
                fdescString = fdescString.stringByReplacingOccurrencesOfString("\n", withString: "", options: .RegularExpressionSearch, range: nil)
                fdescString = fdescString.stringByReplacingOccurrencesOfString("\t", withString: "", options: .RegularExpressionSearch, range: nil)
                elements.setObject(fdescString, forKey: "description")
            }
            townNewsRss.addObject(elements)
        }
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        if element.isEqualToString("title"){
            ftitle.appendString(string!)
        }else if element.isEqualToString("link"){
            link.appendString(string!)
            
            
        }else if element.isEqualToString("description"){
            fdescription.appendString(string!)
            
        }
        
    }
    func parserDidEndDocument(parser: NSXMLParser) {
       
    }
    //////

    
    func launchsetup()
    {
        if Reachability.isConnectedToNetwork()
        {
            LoadingUpdateLabel.text = "Loading: Internet Connected"
            println("Loading: Internet Connected")
             parser.parse()
            PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground(nil, block: nil)
            var query = PFQuery(className:"Directory")
            
            query.findObjectsInBackgroundWithBlock({ (objects:[AnyObject]?, NSError) -> Void in
                self.LoadingUpdateLabel.text = "Loading: Downloading Directory"
                println("Loading: Downloading Directory")
                info.addObjectsFromArray(objects!)
                self.sortInfo()
            })
            
        }
        else
        {
            LoadingUpdateLabel.text = "Error: Internet Not Connected"
            let alert = UIAlertView()
            alert.title = "Internet Not Connected"
            alert.message = "Please connect to the internet to use this app"
            alert.addButtonWithTitle("Dismiss")
            alert.show()
        }

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func sortInfo(){
        
        if(moviePlayer?.duration == moviePlayer?.currentPlaybackTime)
        {
            txtField!.text = "Loading...."
        }
        LoadingUpdateLabel.text = "Loading: Downloading Weather"
        println("Loading: Sorting Info")
        var controllerEvents = EventsViewController()
        controllerEvents.loadParserEvents()
        var controllerNews = NewsViewController()
        controllerNews.loadparserNews()
        
        var i = 0
        do
        {
            if info.objectAtIndex(i).objectForKey("Department") as! NSString == "Accountant"
            {
                Accountant.addObject(info.objectAtIndex(i))
            }
            else if info.objectAtIndex(i).objectForKey("Department") as! NSString == "Animal Control"
            {
                AnimalControl.addObject(info.objectAtIndex(i))
            }
            else if info.objectAtIndex(i).objectForKey("Department") as! NSString == "Assessors Office"
            {
                AssessorsOffice.addObject(info.objectAtIndex(i))
            }
            else if info.objectAtIndex(i).objectForKey("Department") as! NSString == "Building"
            {
                Building.addObject(info.objectAtIndex(i))
            }
            else if info.objectAtIndex(i).objectForKey("Department") as! NSString == "Conservation"
            {
                Conservation.addObject(info.objectAtIndex(i))
            }
            else if info.objectAtIndex(i).objectForKey("Department") as! NSString == "DPW"
            {
                DPW.addObject(info.objectAtIndex(i))
            }
            else if info.objectAtIndex(i).objectForKey("Department") as! NSString == "Employment"
            {
                Employment.addObject(info.objectAtIndex(i))
            }
            else if info.objectAtIndex(i).objectForKey("Department") as! NSString == "Fire"
            {
                Fire.addObject(info.objectAtIndex(i))
            }
            else if info.objectAtIndex(i).objectForKey("Department") as! NSString == "Health"
            {
                Health.addObject(info.objectAtIndex(i))
            }
            else if info.objectAtIndex(i).objectForKey("Department") as! NSString == "Highway"
            {
                Highway.addObject(info.objectAtIndex(i))
            }
            else if info.objectAtIndex(i).objectForKey("Department") as! NSString == "Library"
            {
                Library.addObject(info.objectAtIndex(i))
            }
            else if info.objectAtIndex(i).objectForKey("Department") as! NSString == "Police"
            {
                Police.addObject(info.objectAtIndex(i))
            }
            else if info.objectAtIndex(i).objectForKey("Department") as! NSString == "Parks"
            {
                Parks.addObject(info.objectAtIndex(i))
            }
            else if info.objectAtIndex(i).objectForKey("Department") as! NSString == "Senior"
            {
                Senior.addObject(info.objectAtIndex(i))
            }
            else if info.objectAtIndex(i).objectForKey("Department") as! NSString == "Technology"
            {
                Technology.addObject(info.objectAtIndex(i))
            }
            else if info.objectAtIndex(i).objectForKey("Department") as! NSString == "Town Admin"
            {
                TownAdmin.addObject(info.objectAtIndex(i))
            }
            else if info.objectAtIndex(i).objectForKey("Department") as! NSString == "Town Clerk"
            {
                TownClerk.addObject(info.objectAtIndex(i))
            }
            else if info.objectAtIndex(i).objectForKey("Department") as! NSString == "Treasurer"
            {
                Treasurer.addObject(info.objectAtIndex(i))
            }
            else if info.objectAtIndex(i).objectForKey("Department") as! NSString == "Veteran"
            {
                Veteran.addObject(info.objectAtIndex(i))
            }
            else if info.objectAtIndex(i).objectForKey("Department") as! NSString == "Water"
            {
                Water.addObject(info.objectAtIndex(i))
            }
            else if info.objectAtIndex(i).objectForKey("Department") as! NSString == "Youth"
            {
                Youth.addObject(info.objectAtIndex(i))
            }
            else
            {
                println("error")
            }
            i = i + 1
            
        }while(i < info.count)
        
        txtField!.text = "Loading...."
        do{
        
        }while(moviePlayer?.duration != moviePlayer?.currentPlaybackTime)
        
        moviePlayer?.stop()
        var FirstTime1: Nav1 = self.storyboard?.instantiateViewControllerWithIdentifier("nav1") as! Nav1
        self.presentViewController(FirstTime1, animated: true, completion: nil)
    }


    func submitData()
    {
    }
}
