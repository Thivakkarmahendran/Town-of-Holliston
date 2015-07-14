//
//  SearchTimelineViewController.swift
//  Town of Holliston
//
//  Created by Thivakkar Mahendran on 5/19/15.
//  Copyright (c) 2015 Thivakkar Mahendran. All rights reserved.
//

import Foundation
import UIKit
import TwitterKit


var myURLString = "https://twitter.com/hollistonfd"
class SearchTimelineViewController: UITableViewController, TWTRTweetViewDelegate {
    
    let tweetTableReuseIdentifier = "TweetCell"
    // Hold all the loaded Tweets
    var tweets: [TWTRTweet] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var tweetIDs = ["600843995158323200"]
    
    override func viewDidLoad() {
        
        if let myURL = NSURL(string: myURLString) {
            var error: NSError?
            var  myHTMLString = NSString(contentsOfURL: myURL, encoding: NSUTF8StringEncoding, error: &error)!
           var fullNameArr = myHTMLString.componentsSeparatedByString("stream-item-tweet-")
    
            for i in 1...fullNameArr.count - 1
            {
                var fullNameArr1 = fullNameArr[i].componentsSeparatedByString("\"")
                tweetIDs.append(fullNameArr1[0] as! String)
            }
        }
        tweetIDs.removeAtIndex(0)
        
        TWTRTweetView.appearance().theme = .Dark
        
        
        Twitter.sharedInstance().logInGuestWithCompletion { guestSession, error in
            if (guestSession != nil)
            {
                
                Twitter.sharedInstance().APIClient.loadTweetsWithIDs(self.tweetIDs) { tweets, error in
                    if let ts = tweets as? [TWTRTweet]
                    {
                        self.tweets = ts
                    }
                    else
                    {
                        println("Failed to load tweets: \(error.localizedDescription)")
                    }
                }
            }
        }
        // Setup the table view
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension // Explicitly set on iOS 8 if using automatic row height calculation
        tableView.allowsSelection = false
        tableView.registerClass(TWTRTweetTableViewCell.self, forCellReuseIdentifier: tweetTableReuseIdentifier)
        
    }
    
    // MARK: UITableViewDelegate Methods
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tweet = tweets[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(tweetTableReuseIdentifier, forIndexPath: indexPath) as! TWTRTweetTableViewCell
        cell.tweetView.delegate = self
        cell.configureWithTweet(tweet)
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let tweet = tweets[indexPath.row]
        return TWTRTweetTableViewCell.heightForTweet(tweet, width: CGRectGetWidth(self.view.bounds))
    }
}


