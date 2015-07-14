//
//  Nav1.swift
//  Town of Holliston
//
//  Created by Thivakkar Mahendran on 10/29/14.
//  Copyright (c) 2014 Thivakkar Mahendran. All rights reserved.
//

import UIKit

class Nav1: ENSideMenuNavigationController, ENSideMenuDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        sideMenu = ENSideMenu(sourceView: self.view, menuTableViewController: MyMenuTableViewController(), menuPosition:.Left)
        sideMenu?.delegate = self //optional
        sideMenu?.menuWidth = 180.0 // optional, default is 160
        //sideMenu?.bouncingEnabled = false
        
        // make navigation bar showing over side menu
        view.bringSubviewToFront(navigationBar)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func sideMenuWillOpen() {
        println("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
        println("sideMenuWillClose")
    }

}
