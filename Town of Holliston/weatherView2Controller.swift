//
//  weatherView2Controller.swift
//  Town of Holliston
//
//  Created by Thivakkar Mahendran on 5/14/15.
//  Copyright (c) 2015 Thivakkar Mahendran. All rights reserved.
//

import Foundation

class weatherView2Controller: UIViewController{

    @IBOutlet var ImageDay1: UIImageView!
    @IBOutlet var ImageDay2: UIImageView!
    @IBOutlet var ImageDay3: UIImageView!
    @IBOutlet var ImageDay4: UIImageView!
    @IBOutlet var ImageDay5: UIImageView!
    
    @IBOutlet var LabelDay1: UILabel!
    @IBOutlet var LabelDay2: UILabel!
    @IBOutlet var LabelDay3: UILabel!
    @IBOutlet var LabelDay4: UILabel!
    @IBOutlet var LabelDay5: UILabel!
    
    @IBOutlet var WeatherDescDay1: UILabel!
    @IBOutlet var WeatherDescDay2: UILabel!
    @IBOutlet var WeatherDescDay3: UILabel!
    @IBOutlet var WeatherDescDay4: UILabel!
    @IBOutlet var WeatherDescDay5: UILabel!
 
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        weatherimage()
        DayLabel()
        weatherdec()
    }
    
    func weatherimage()
    {
        var day1image = Array<UIImage>()
        var day2image = Array<UIImage>()
        var day3image = Array<UIImage>()
        var day4image = Array<UIImage>()
        var day5image = Array<UIImage>()
        
        for i in 0...4
        {
            var weathercode = weekweather.objectAtIndex(i).objectForKey ("code") as! NSString as String
            var logoImages = []
            logoImages = NSBundle.mainBundle().pathsForResourcesOfType("png", inDirectory: "/\(weathercode)")
            for a in 0...logoImages.count - 1
            {
                var test = ""
                test = logoImages[a] as! String
                if(i == 0)
                {
                day1image.append(UIImage(contentsOfFile: test)!)
                }
                else if(i == 1)
                {
                    day2image.append(UIImage(contentsOfFile: test)!)
                }
                else if(i == 2)
                {
                    day3image.append(UIImage(contentsOfFile: test)!)
                }
                else if(i == 3)
                {
                    day4image.append(UIImage(contentsOfFile: test)!)
                }
                else if(i == 4)
                {
                    day5image.append(UIImage(contentsOfFile: test)!)
                }
            }
            
        }
        
        ImageDay1.animationImages = day1image
        ImageDay2.animationImages = day2image
        ImageDay3.animationImages = day3image
        ImageDay4.animationImages = day4image
        ImageDay5.animationImages = day5image
        ImageDay1.startAnimating()
        ImageDay2.startAnimating()
        ImageDay3.startAnimating()
        ImageDay4.startAnimating()
        ImageDay5.startAnimating()
    }
    
    func DayLabel()
    {
      LabelDay1.text = weekweather.objectAtIndex(0).objectForKey ("day") as! NSString as String
      LabelDay2.text = weekweather.objectAtIndex(1).objectForKey ("day") as! NSString as String
      LabelDay3.text = weekweather.objectAtIndex(2).objectForKey ("day") as! NSString as String
      LabelDay4.text = weekweather.objectAtIndex(3).objectForKey ("day") as! NSString as String
      LabelDay5.text = weekweather.objectAtIndex(4).objectForKey ("day") as! NSString as String
    }
    
    func weatherdec()
    {
      var dayhigh = weekweather.objectAtIndex(0).objectForKey ("high") as! NSString as String
      var daylow = weekweather.objectAtIndex(0).objectForKey ("low") as! NSString as String
      var daytext = weekweather.objectAtIndex(0).objectForKey ("text") as! NSString as String
      var daydesc = "High: \(dayhigh)°F\nLow: \(daylow)°F\n\(daytext)"
      WeatherDescDay1.text = daydesc
        
      dayhigh = weekweather.objectAtIndex(1).objectForKey ("high") as! NSString as String
      daylow = weekweather.objectAtIndex(1).objectForKey ("low") as! NSString as String
      daytext = weekweather.objectAtIndex(1).objectForKey ("text") as! NSString as String
      daydesc = "High: \(dayhigh)°F\nLow: \(daylow)°F\n\(daytext)"
      WeatherDescDay2.text = daydesc
        
        dayhigh = weekweather.objectAtIndex(2).objectForKey ("high") as! NSString as String
        daylow = weekweather.objectAtIndex(2).objectForKey ("low") as! NSString as String
        daytext = weekweather.objectAtIndex(2).objectForKey ("text") as! NSString as String
        daydesc = "High: \(dayhigh)°F\nLow: \(daylow)°F\n\(daytext)"
        WeatherDescDay3.text = daydesc
        
        dayhigh = weekweather.objectAtIndex(3).objectForKey ("high") as! NSString as String
        daylow = weekweather.objectAtIndex(3).objectForKey ("low") as! NSString as String
        daytext = weekweather.objectAtIndex(3).objectForKey ("text") as! NSString as String
        daydesc = "High: \(dayhigh)°F\nLow: \(daylow)°F\n\(daytext)"
        WeatherDescDay4.text = daydesc
        
        dayhigh = weekweather.objectAtIndex(4).objectForKey ("high") as! NSString as String
        daylow = weekweather.objectAtIndex(4).objectForKey ("low") as! NSString as String
        daytext = weekweather.objectAtIndex(4).objectForKey ("text") as! NSString as String
        daydesc = "High: \(dayhigh)°F\nLow: \(daylow)°F\n\(daytext)"
        WeatherDescDay5.text = daydesc
    }

}