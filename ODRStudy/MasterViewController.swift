//
//  MasterViewController.swift
//  ODR
//
//  Created by Noritaka Kamiya on 2015/12/04.
//  Copyright © 2015年 Noritaka Kamiya. All rights reserved.
//

import UIKit
var MasterViewControllerObservingContext = "MasterViewControllerObservingContext"

class MasterViewController: UITableViewController {
    var request: NSBundleResourceRequest!
    var data: CompoundData! {
        didSet {
            title = data.name
        }
    }
    
    @IBOutlet weak var progressView: UIProgressView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        request = NSBundleResourceRequest(tags: Set([data.tag]))
        request.beginAccessingResourcesWithCompletionHandler { error in
            guard error == nil else {
                NSLog("error")
                return
            }

            dispatch_async(dispatch_get_main_queue()) {
                self.request.progress.removeObserver(self, forKeyPath: "fractionCompleted")
                self.progressView.progress = Float(1.0)
                NSNotificationCenter.defaultCenter().postNotificationName("OnDemandResourcesLoaded", object: nil)
            }
        }
        
        request.progress.addObserver(self, forKeyPath: "fractionCompleted", options: .New, context: &MasterViewControllerObservingContext)
        print("loading")
    }
    
    func showProgress () {
        dispatch_async(dispatch_get_main_queue()) {
            self.progressView.progress = Float(self.request.progress.fractionCompleted)
        }
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if context == &MasterViewControllerObservingContext {
            dispatch_async(dispatch_get_main_queue()) {
                self.showProgress()
            }
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.children.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")!
        cell.textLabel!.text = data.children[indexPath.row].name
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let detailViewController = segue.destinationViewController as? DetailViewController else {
            fatalError("Unknown ViewController")
        }
        detailViewController.data = data.children[(tableView.indexPathForSelectedRow?.row)!]
    }
}
