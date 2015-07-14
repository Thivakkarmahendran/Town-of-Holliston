//
//  weatherView1Controller.swift
//  Town of Holliston
//
//  Created by Thivakkar Mahendran on 5/13/15.
//  Copyright (c) 2015 Thivakkar Mahendran. All rights reserved.
//

import Foundation

class weatherView1Controller: UIViewController{
    
    @IBOutlet var currenttemplabel: UILabel!
    @IBOutlet var weatherimagelabel: UIImageView!
    @IBOutlet var weatherdecp: UILabel!
   
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
          start()
    }
    
    
    func start()
    {
        currenttemplabel.text = String(Int(currenttemp)) + "°"
        weatherdecp.text = "Humidty: " + String(Int(humidity)) + "% \nWind: " + winddescp + " MPH\nClouds: " + skydescp
        weatherdecp.sizeToFit()
        sortweathericons()
    }
    
    func sortweathericons()
    {
        var logoImages = []
        logoImages = NSBundle.mainBundle().pathsForResourcesOfType("png", inDirectory: "/\(weatherimage)")
        var animated = Array<UIImage>()
        for i in 0...logoImages.count - 1
        {
            var test = ""
            test = logoImages[i] as! String
            animated.append(UIImage(contentsOfFile: test)!)
        }
        weatherimagelabel.animationImages = animated
        weatherimagelabel.startAnimating()
        
    }
}