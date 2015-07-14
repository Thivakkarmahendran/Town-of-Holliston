//
//  ENSideMenuNavigationController.swift
//  Town of Holliston
//
//  Created by Thivakkar Mahendran on 10/29/14.
//  Copyright (c) 2014 Thivakkar Mahendran. All rights reserved.
//

import UIKit

class ENSideMenuNavigationController: UINavigationController, ENSideMenuProtocol {
    internal var sideMenu : ENSideMenu?
    internal var sideMenuAnimationType : ENSideMenuAnimation = .Default

    override func viewDidLoad() {
        self.navigationController?.toolbarHidden = true
        super.viewDidLoad()
    }
    
    init( menuTableViewController: UITableViewController, contentViewController: UIViewController?) {
        super.init(nibName: nil, bundle: nil)
        
        if (contentViewController != nil) {
            self.viewControllers = [contentViewController!]
        }
        
        sideMenu = ENSideMenu(sourceView: self.view, menuTableViewController: menuTableViewController, menuPosition:.Left)
        view.bringSubviewToFront(navigationBar)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setContentViewController(contentViewController: UIViewController) {
        
        self.sideMenu?.toggleMenu()
        switch sideMenuAnimationType {
        case .None:
            self.viewControllers = [contentViewController]
            break
        default:
            contentViewController.navigationItem.hidesBackButton = true
            self.setViewControllers([contentViewController], animated: true)
            break
        }
        
    }

    
}
