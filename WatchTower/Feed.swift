//
//  Feed.swift
//  WatchTower
//
//  Created by dana on 6/9/15.
//  Copyright (c) 2015 Dana Wolfe. All rights reserved.
//

import Foundation

class Feed {
    
    var siteNames: [String]?
    var siteAddresses: [String]?
    
    init(){
        siteNames = ["CRM","Yahoo", "Google", "Apple", "eBookFrenzy"]
        siteAddresses = ["http://idesdc2.danawolfe.com:8000/sap/bc/bsp/sap/crm_ui_start", "http://www.yahoo.com", "http://www.google.com", "http://www.apple.com", "http://www.ebookfrenzy.com"]
    }
    
}