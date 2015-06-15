//
//  Feed.swift
//  WatchTower
//
//  Created by dana on 6/9/15.
//  Copyright (c) 2015 Dana Wolfe. All rights reserved.
//

import Foundation

class Element: NSObject {
    var name: String?
    var value: String?
    var attributes = Dictionary<String,String>()
    var arrElements = [Element]()
    
    override init() {
        super.init()
        
    }
    
    init( name: String? ) {
        super.init()
        
        self.name = name
    }
    
    func push( newElement: String){
        self.arrElements.append(Element(name: newElement))
    }
    
}

class Feed: NSObject {
    
    var urlString: String?
    var userPasswordString: String?
    var userUseridString: String?
    var feedProperties = Dictionary<String, String>()
    var arrFeedItems = [Dictionary<String, String>]()
    var observer: NSObjectProtocol?
    var rootElement: Element
    
    // Read Settings to set local values
    func setValuesFromSettings(){
        urlString = NSUserDefaults.standardUserDefaults().stringForKey("url")
        userPasswordString = NSUserDefaults.standardUserDefaults().stringForKey("password")
        userUseridString = NSUserDefaults.standardUserDefaults().stringForKey("userid")
        
    }
    
    // Listen for Settings changes and update local values
    
    override init(){

        rootElement = Element(name: "root")
        // Call super's init
        super.init()
        
        self.setValuesFromSettings()
        // Listen for Settings changes and update local values
        observer = NSNotificationCenter.defaultCenter().addObserverForName(NSUserDefaultsDidChangeNotification,
            object: nil, queue: nil) { _ in
               self.setValuesFromSettings()
            
        }
        

        
    }
        
        deinit {
            NSNotificationCenter.defaultCenter().removeObserver(observer!)
        }
    
    
    
}