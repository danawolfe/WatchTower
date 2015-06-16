//
//  MasterViewController.swift
//  WatchTower
//
//  Created by dana on 6/8/15.
//  Copyright (c) 2015 Dana Wolfe. All rights reserved.
//

import UIKit

let crmFeed = Feed()

class MasterViewController: UITableViewController, XMLParserDelegate {

   
    var detailViewController: DetailViewController? = nil
    var objects = NSMutableArray()
    var xmlParser : XMLParser!

    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }
        
        let url = NSURL(string: crmFeed.urlString!)
        xmlParser = XMLParser()
        xmlParser.delegate = self
        xmlParser.startParsingWithContentsOfURL(url!)
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let dictionary = xmlParser.arrParsedData[indexPath.row] as Dictionary<String, String>
                let urlString = dictionary["link"]
                
                //let urlString = myFeed.siteAddresses?[indexPath.row]
                
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                
                controller.detailItem = urlString
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return xmlParser.arrParsedData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        let currentDictionary = xmlParser.arrParsedData[indexPath.row] as Dictionary<String, String>
        cell.textLabel!.text = currentDictionary["title"]
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }

    
    func parsingWasFinished() {
        self.tableView.reloadData()
    }
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let dictionary = xmlParser.arrParsedData[indexPath.row] as Dictionary<String, String>
//        let updateLink = dictionary["link"]
//        
//        let boViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("idBOViewController") as! BOViewController
//        
//        boViewController.tutorialURL = NSURL(string: BOLink!)
//        
//        showDetailViewController(boViewController, sender: self)

    

//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            objects.removeAtIndex(indexPath.row)
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        } else if editingStyle == .Insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//        }
//    }


}

