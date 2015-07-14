//
//  streetlighttableview.swift
//  Town of Holliston
//
//  Created by Thivakkar Mahendran on 3/27/15.
//  Copyright (c) 2015 Thivakkar Mahendran. All rights reserved.
//

import Foundation
import UIKit


class streetlighttableview: UITableViewController, UIPickerViewDelegate{
    @IBOutlet var streettableview: UITableView!
    @IBOutlet weak var pickerview: UIPickerView!
    var channel = ["The street light is out","New light to be installed","Light is cycling on/off","Light is on during the day"]
    var channelchoosen = ""
    
    @IBOutlet weak var textbox1: UITextField!
    @IBOutlet weak var textbox2: UITextField!
    @IBOutlet weak var textbox3: UITextField!
    @IBOutlet weak var textbox4: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.toolbarHidden = true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return channel.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        return channel[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(row == 0)
        {
            channelchoosen = "The street light in my neighborhood is out"
        }
        else if (row == 1)
        {
            channelchoosen = "I would like a new light to be installed"
        }
        else if (row == 2)
        {
            channelchoosen = "The street light is cycling on/off"
        }
        else
        {
            channelchoosen = "The street light on during the day"
        }
    }
    
    @IBAction func submitbutton(sender: AnyObject) {
        var text1 = textbox1.text
        var text2 = textbox2.text
        var text3 = textbox3.text
        var text4 = textbox4.text
        
         text1 = text1.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil);
         text2 = text2.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil);
         text3 = text3.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil);
         text4 = text4.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil);
         channelchoosen = channelchoosen.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil);
        
        var urlsetup = "https://docs.google.com/forms/d/14-2OzfiTFxzVEbNdEVyzmMekQjAgPwuk4fqKIOhpGEk/formResponse?ifq&entry.2046549075=\(channelchoosen)&entry.190366679=\(text1)&entry.142856131=\(text2)&entry.801566737=\(text3)&entry.1038912165=\(text4)&submit=Submit"
        
        let url = NSURL(string: urlsetup)
        let request = NSMutableURLRequest(URL: url!)
        
        request.HTTPMethod = "HEAD"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 10.0
        
        NSURLConnection.sendAsynchronousRequest(request, queue:NSOperationQueue.mainQueue(), completionHandler:
        {(response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
        })
        
        let alertController = UIAlertController(title: "Alert", message: "The report has been submitted", preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "Dismiss", style: .Default) { (action) in
        }
        alertController.addAction(OKAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
}