//
//  NewsViewController.swift
//  Town of Holliston
//
//  Created by Thivakkar Mahendran on 10/29/14.
//  Copyright (c) 2014 Thivakkar Mahendran. All rights reserved.
//

import UIKit
import AVFoundation

var descPopup = ""
 var feedsNews = NSMutableArray()

class NewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSXMLParserDelegate {
    @IBOutlet weak var newsTableView: UITableView!

    var parser = NSXMLParser()
    var elements = NSMutableDictionary()
    var element = NSString()
    var ftitle = NSMutableString()
    var link = NSMutableString()
    var fdescription = NSMutableString()
    var voice = AVSpeechSynthesizer()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.toolbarHidden = true
        self.view.backgroundColor = UIColor.yellowColor()
        
        UIView.animateWithDuration(6.0, delay:0, options: .Repeat | .Autoreverse | .AllowUserInteraction, animations: {
            
            self.view.backgroundColor = UIColor.whiteColor()
            
            }, completion: nil)
        
     }
    
    
    func loadparserNews()
    {
        feedsNews = []
        var url: NSURL = NSURL(string: "http://www.townofholliston.us/node/111/news/feed")!
        parser = NSXMLParser (contentsOfURL: url)!
        parser.delegate = self
        parser.shouldProcessNamespaces = false
        parser.shouldReportNamespacePrefixes = false
        parser.shouldResolveExternalEntities = false
        parser.parse()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        
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
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if (elementName as NSString).isEqualToString("item") {
            if ftitle != "" {
                elements.setObject(ftitle, forKey: "title")
                
            }
            
            if (link != "") {
                elements.setObject(link, forKey: "link")
                
            }
            
            if (fdescription != "") {
                elements.setObject(fdescription, forKey: "description")
                
            }
            
            feedsNews.addObject(elements)
            
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
        
        //self.newsTableView.reloadData()
       
    }
    /////////////////
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return feedsNews.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return  1;
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: NewsTableViewCell = tableView.dequeueReusableCellWithIdentifier("Maincell") as! NewsTableViewCell
        cell.newscellTitle.text = feedsNews.objectAtIndex(indexPath.row).objectForKey ("title") as! NSString as String

        cell.newscellDesc.numberOfLines = 1
        var descE = feedsNews.objectAtIndex(indexPath.row).objectForKey("description") as! String
        let str = descE.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
        cell.newscellDesc.text = str
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        var link = feedsNews.objectAtIndex(indexPath.row).objectForKey ("link") as! NSString as String
        link = link.stringByReplacingOccurrencesOfString(" ", withString: "", options: .RegularExpressionSearch, range: nil)
        link = link.stringByReplacingOccurrencesOfString("\n", withString: "", options: .RegularExpressionSearch, range: nil)
        webviewurl =  link
        self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("webview") as! UIViewController, animated: true)
        
    }
    
   

    
}
