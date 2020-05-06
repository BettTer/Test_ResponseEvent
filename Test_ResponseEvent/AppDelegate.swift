//
//  AppDelegate.swift
//  Test_ResponseEvent
//
//  Created by Young Robine on 2020/4/26.
//  Copyright © 2020 Young Robine. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    /// 后台任务三分钟保活
    var backgroundTaskIdentifier: UIBackgroundTaskIdentifier?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        backgroundTaskIdentifier = application.beginBackgroundTask(expirationHandler: {
            // * 你自己的任务
            
        })
        
    }


}

