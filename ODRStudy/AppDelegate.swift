//
//  AppDelegate.swift
//  ODRStudy
//
//  Created by Noritaka Kamiya on 2015/12/12.
//  Copyright © 2015年 Noritaka Kamiya. All rights reserved.
//

import Foundation
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let firstViewController = storyboard.instantiateInitialViewController() as! MasterViewController
        firstViewController.data = CompoundData(tag: "town", name: "Town", children: [Data(name: "town0"), Data(name: "town1")])
        
        let secondViewController = storyboard.instantiateInitialViewController() as! MasterViewController
        secondViewController.data = CompoundData(tag: "park", name: "Park", children: [Data(name: "park0"), Data(name: "park1"), Data(name: "park2"), Data(name: "park3")])
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [UINavigationController(rootViewController: firstViewController), UINavigationController(rootViewController: secondViewController)]

        window!.rootViewController = tabBarController
        window!.makeKeyAndVisible()
        
        return true
    }
}