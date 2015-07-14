//
//  urlwebbrowser.swift
//  Town of Holliston
//
//  Created by Thivakkar Mahendran on 5/5/15.
//  Copyright (c) 2015 Thivakkar Mahendran. All rights reserved.
//

import Foundation

var webviewurl = ""
class urlwebbrowser: UIViewController{

    @IBOutlet var webview: UIWebView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        var url1 = NSURL(string: webviewurl as String)
        var req = NSURLRequest(URL:url1!)
        webview.loadRequest(req)


        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}