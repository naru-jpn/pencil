//
//  AppDelegate.swift
//  PencilExample
//
//  Created by naru on 2016/09/21.
//  Copyright © 2016年 naru. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    struct Constants {
        static let ApplicationStateURL: URL = Directory.Documents!.append(path: "application_state.data")
    }
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = self.tabBarController
        self.window?.makeKeyAndVisible()
        
        if let applicationState = ApplicationState.value(from: Constants.ApplicationStateURL) {
            self.tabBarController.selectedIndex = applicationState.tabIndex
        }
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        ApplicationState(tabIndex: self.tabBarController.selectedIndex).write(to: Constants.ApplicationStateURL)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        ApplicationState(tabIndex: self.tabBarController.selectedIndex).write(to: Constants.ApplicationStateURL)
    }

    // MARK: Elements
    
    lazy var tabBarController: UITabBarController = {
        
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -16.0)
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 13.0)], for: .normal)
        
        let viewControllers: [(instance: UIViewController, title: String)] = [
            (ViewController(), "One"),
            (ViewController(), "Two"),
            (ViewController(), "Three")
        ]
        
        let tabBarController: UITabBarController = UITabBarController()
        tabBarController.viewControllers = viewControllers.map { (viewController: UIViewController, title: String) in
            viewController.title = title
            return viewController
        }
        return tabBarController
    }()
}

