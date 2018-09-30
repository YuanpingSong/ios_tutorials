//
//  AppDelegate.swift
//  StoreSearch
//
//  Created by imac on 2017/7/15.
//  Copyright © 2017年 songyp. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func customizeAppearance() {
        let barTintColor = UIColor(red: 20/225, green: 160/225, blue: 160/225, alpha: 1)
        UISearchBar.appearance().barTintColor = barTintColor
        window!.tintColor = UIColor(red: 10/255, green: 80/255, blue: 80/255, alpha: 1)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        customizeAppearance()
        return true
    }
}

