//
//  DetailViewController.swift
//  WatchTower
//
//  Created by dana on 6/8/15.
//  Copyright (c) 2015 Dana Wolfe. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var detailDescriptionLabel: UILabel!


    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: AnyObject = detailItem {
            
            if let myWebview = webView {
                let url = NSURL(string: detailItem as! String)
                let request = NSURLRequest(URL: url!)
                myWebview.scalesPageToFit = true
                myWebview.loadRequest(request)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let userAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/600.6.3 (KHTML, like Gecko) Version/8.0.6 Safari/600.6.3"
        NSUserDefaults.standardUserDefaults().registerDefaults(["UserAgent" : userAgent])
        
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

