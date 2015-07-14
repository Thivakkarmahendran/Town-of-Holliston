//
//  Notification.swift
//  Town of Holliston
//
//  Created by Thivakkar Mahendran on 12/3/14.
//  Copyright (c) 2014 Thivakkar Mahendran. All rights reserved.
//

import Foundation
import CoreData

@objc(Notification)
class Notification: NSManagedObject {

    @NSManaged var police: NSString
    @NSManaged var fire: NSString
    @NSManaged var school: NSString
    @NSManaged var town: NSString

}
