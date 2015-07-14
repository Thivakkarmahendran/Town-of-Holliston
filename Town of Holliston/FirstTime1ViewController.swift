//
//  FirstTime1ViewController.swift
//  Town of Holliston
//
//  Created by Thivakkar Mahendran on 12/2/14.
//  Copyright (c) 2014 Thivakkar Mahendran. All rights reserved.
//

import UIKit
import QuartzCore

class FirstTime1ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /////////////////
        let rect : CGRect = CGRectMake(0,0,self.view.frame.width,self.view.frame.height)
        var vista : UIView = UIView(frame: rect)
        let gradient : CAGradientLayer = CAGradientLayer()
        gradient.frame = vista.bounds
        let cor1 = UIColor.yellowColor().CGColor
        let cor2 = UIColor.orangeColor().CGColor
        let arrayColors = [cor1, cor2]
        gradient.colors = arrayColors
        view.layer.insertSublayer(gradient, atIndex: 0)
       ////////////
        
        let recognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeLeft:")
        recognizer.direction = .Left
        self.view .addGestureRecognizer(recognizer)
        self.navigationController?.toolbarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func swipeLeft(recognizer : UISwipeGestureRecognizer) {
        
        var FirstTime2: FirstTime2ViewController = self.storyboard?.instantiateViewControllerWithIdentifier("FirstTime2") as! FirstTime2ViewController
        self.presentViewController(FirstTime2, animated: true, completion: nil)
    }
    
}
