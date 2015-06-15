//
//  XMLParser.swift
//  WatchTower
//
//  Created by dana on 6/13/15.
//  Copyright (c) 2015 Dana Wolfe. All rights reserved.
//

import UIKit

@objc protocol XMLParserDelegate{
    func parsingWasFinished()
}

class XMLParser: NSObject, NSXMLParserDelegate {
    var arrParsedData = [Dictionary<String, String>]()
//    var currentDataDictionary = Dictionary<String, String>()
    var currentElement = ""
    var foundCharacters = ""
    var inEntry = false
    var delegate : XMLParserDelegate?
    
    func startParsingWithContentsOfURL(rssURL: NSURL) {

        var curElement: Element
        
        var config = NSURLSessionConfiguration.defaultSessionConfiguration()
        var userPasswordString = crmFeed.userUseridString! + ":" + crmFeed.userPasswordString!
        let userPasswordData = userPasswordString.dataUsingEncoding(NSUTF8StringEncoding)
        let base64EncodedCredential = userPasswordData!.base64EncodedStringWithOptions(nil)
        let authString = "Basic \(base64EncodedCredential)"
        config.HTTPAdditionalHeaders = ["Authorization" : authString]
        let session = NSURLSession(configuration: config)
        
        let url = rssURL
        let request = NSMutableURLRequest(URL: url)

        let task = session.dataTaskWithURL(url)  {
            (let data, let response, let error) in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                let dataString = NSString(data: data, encoding: NSUTF8StringEncoding)
                println(dataString)
            }
            
            let parser = NSXMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }
        
        task.resume()
        
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        // capture the name of the element
        currentElement = elementName
        
        
        
        if elementName == "link"{
            foundCharacters = attributeDict["href"]! as! String
            
        }
        
        
        if currentElement == "entry" {
            currentDataDictionary.removeAll()
            inEntry = true
        }
    }
    
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if !foundCharacters.isEmpty {
       
            currentDataDictionary[currentElement] = foundCharacters
            
            foundCharacters = ""
            
        }
        
        if elementName == "entry" {
            crmFeed.arrFeedItems.append(currentDataDictionary)
            // arrParsedData.append(currentDataDictionary)
        }
        
    }
    
    
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        if currentElement == "title" || currentElement == "id" || currentElement == "summary" || currentElement == "link" || currentElement == "updated"{
            foundCharacters += string!
        }
    }
    
    
    func parserDidEndDocument(parser: NSXMLParser) {
        delegate?.parsingWasFinished()
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        println(parseError.description)
    }
    
    
    func parser(parser: NSXMLParser, validationErrorOccurred validationError: NSError) {
        println(validationError.description)
    }
    
    
}