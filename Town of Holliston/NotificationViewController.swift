//
//  NotificationViewController.swift
//  Town of Holliston
//
//  Created by Thivakkar Mahendran on 12/4/14.
//  Copyright (c) 2014 Thivakkar Mahendran. All rights reserved.
//

import UIKit
import LocalAuthentication

class NotificationViewController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate{
    @IBOutlet weak var PickerView: UIPickerView!
    @IBOutlet weak var message: UITextField!
    var channel = ["","Police","Fire","School","Town"]
    var channelchoosen = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        message.delegate = self
        self.navigationController?.toolbarHidden = true
         
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        channelchoosen = channel[row]
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func Send(sender: AnyObject) {
        if channelchoosen != "" && message.text != ""
        {
            let alertController = UIAlertController(title: "Warning!!", message: "Are you sure you want to send this notification?", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "No", style: .Cancel) { (action) in
            }
            alertController.addAction(cancelAction)
            
            let OKAction = UIAlertAction(title: "Yes", style: .Default) { (action) in
                var push:PFPush = PFPush()
                push.setChannel(self.channelchoosen)
                push.setMessage(self.message.text)
                push.sendPushInBackgroundWithTarget(nil, selector: nil)
                
                let alertController = UIAlertController(title: "Message", message:
                    "Notification Sent!!", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
                
            }
            alertController.addAction(OKAction)
           presentViewController(alertController, animated: true, completion: nil)
        }
        else
        {
            let alertController = UIAlertController(title: "Error", message: "Your message is empty or did not choose a notification type", preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "Ok", style: .Default) { (action) in
            }
            alertController.addAction(OKAction)
            presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
}
