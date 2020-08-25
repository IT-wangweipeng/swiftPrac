//
//  AppDelegate.swift
//  youliao
//
//  Created by Apple on 2020/3/16.
//  Copyright © 2020 com.qujie.tech. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        
        window?.rootViewController = BaseTabBarController()
        window?.makeKeyAndVisible()
        
        return true
    }

    
    
    
    


}

