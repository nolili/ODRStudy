//
//  DetailViewController.swift
//  ODRStudy
//
//  Created by Noritaka Kamiya on 2015/12/12.
//  Copyright © 2015年 Noritaka Kamiya. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var data: Data!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showImage()
        
        NSNotificationCenter.defaultCenter().addObserverForName("OnDemandResourcesLoaded", object: nil, queue: nil) { [weak self] _ in
            self?.showImage()
        }
    }
    
    func showImage() {
        let image = UIImage(named: data.name)
        self.imageView.image = image
    }

}