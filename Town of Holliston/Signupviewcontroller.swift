//
//  Signupviewcontroller.swift
//  Town of Holliston
//
//  Created by Thivakkar Mahendran on 5/5/15.
//  Copyright (c) 2015 Thivakkar Mahendran. All rights reserved.
//

import Foundation


var name = ""
var email = ""
var blocked = false
class Signupviewcontroller: UITableViewController {
   
    @IBOutlet var namelabel: UITextField!
    @IBOutlet var emaillabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    self.navigationController?.toolbarHidden = true
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "mainmenu2.png")?.drawInRect(self.view.bounds)
        var image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func nextButton(sender: AnyObject)
    {
        name = namelabel.text
        email = emaillabel.text
        if((name != "") && (email != ""))
        {
            var Settings: SettingsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Settings") as! SettingsViewController
            self.presentViewController(Settings, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertView()
            alert.title = "Error"
            alert.message = "Your Name or Email field is empty"
            alert.addButtonWithTitle("Dismiss")
            alert.show()
        }
    }
    
       
}
