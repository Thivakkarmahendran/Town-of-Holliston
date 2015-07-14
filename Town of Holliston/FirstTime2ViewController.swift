//
//  FirstTime2ViewController.swift
//  Town of Holliston
//
//  Created by Thivakkar Mahendran on 12/2/14.
//  Copyright (c) 2014 Thivakkar Mahendran. All rights reserved.
//

import UIKit
import CoreData

class FirstTime2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         ///
        let rect : CGRect = CGRectMake(0,0,self.view.frame.width,self.view.frame.height)
        var vista : UIView = UIView(frame: rect)
        let gradient : CAGradientLayer = CAGradientLayer()
        gradient.frame = vista.bounds
        let cor1 = UIColor.blueColor().CGColor
        let cor2 = UIColor.whiteColor().CGColor
        let arrayColors = [cor1, cor2]
        gradient.colors = arrayColors
        view.layer.insertSublayer(gradient, atIndex: 0)
        //
        
        let recognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeRight:")
        recognizer.direction = .Right
        self.view .addGestureRecognizer(recognizer)
        self.navigationController?.toolbarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func swipeRight (recognizer : UISwipeGestureRecognizer) {
    
    var FirstTime1: FirstTime1ViewController = self.storyboard?.instantiateViewControllerWithIdentifier("FirstTime1") as! FirstTime1ViewController
    self.presentViewController(FirstTime1, animated: true, completion: nil)
    }

    @IBAction func Admin(sender: AnyObject)
    {
        
        var signup: QRreaderviewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("QR") as! QRreaderviewcontroller
        self.presentViewController(signup, animated: true, completion: nil)
        
    }
}
