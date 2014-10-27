//
//  FeedItem.swift
//  ExchangeAGram
//
//  Created by alvaro on 27/10/14.
//  Copyright (c) 2014 Alvaro. All rights reserved.
//

import Foundation
import CoreData

@objc (FeedItem)
class FeedItem: NSManagedObject {

    @NSManaged var caption: String
    @NSManaged var image: NSData

}
