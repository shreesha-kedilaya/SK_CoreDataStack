//
//  AppDelegate.swift
//  SK_Core_Data_Stack
//
//  Created by Shreesha on 25/11/16.
//  Copyright © 2016 YML. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    static var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        SK_CoredataStack.coreDataConfig = SK_Configuration(sqlFileName: "SQLITEFILE", modelName: "TestCoreData", needMigration: true, mergePolicy: NSMergeByPropertyStoreTrumpMergePolicy, fileProtectionType: .completeUnlessOpen)

        SK_CoredataStack.errorHandler = { (error) in
            print("Error in Core data: \(error)")
        }
        SK_CoredataStack.begin()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func popToRootViewController(completion: @escaping () -> ()) {
        guard let rootViewController = window?.rootViewController as? UINavigationController else {
            window?.rootViewController?.dismiss(animated: true, completion: { 
                completion()
            })
            return
        }

        guard let presentedViewController = rootViewController.presentedViewController else {
            rootViewController.popToRootViewController(animated: true)
            return
        }

        presentedViewController.dismiss(animated: true) {
            rootViewController.popToRootViewController(animated: true)
            completion()
        }
    }
}

