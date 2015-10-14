//
//  AppDelegate.swift
//  ParseAnalytics
//
//  Created by Nick Kibish on 13.10.15.
//  Copyright © 2015 Nick Kibish. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var layerClient = LayerAuthenticator()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        Parse.setApplicationId("qfxDSOF2zfhEbszwxAY61OxLGDT92omBZNE0I2wc",
            clientKey: "zwfS6od3YvqPVt3VUawfleYwUajAEiUFAmRnmSqn")
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        if application.applicationState != UIApplicationState.Background {
            applicationRegisterForRemoteNotificationsInBackground(application, launchOptions: launchOptions)
        }
        if application.respondsToSelector("registerUserNotificationSettings:") {
            let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        }
        
        layerClient.authenticate()
        
        return true
    }
    
    func applicationRegisterForRemoteNotificationsInBackground(application:UIApplication, launchOptions: [NSObject: AnyObject]?) {
        let preBackgroundPush = !application.respondsToSelector("backgroundRefreshStatus")
        let oldPushHandlerOnly = !self.respondsToSelector("application:didReceiveRemoteNotification:fetchCompletionHandler:")
        var pushPayload = false
        if let options = launchOptions {
            pushPayload = options[UIApplicationLaunchOptionsRemoteNotificationKey] != nil
        }
        if (preBackgroundPush || oldPushHandlerOnly || pushPayload) {
            PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        }
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let installation = PFInstallation.currentInstallation()
        installation.setDeviceTokenFromData(deviceToken)
        var token = NSString(format: "%@", deviceToken)
        token = token.stringByReplacingOccurrencesOfString("<", withString: "")
        token = token.stringByReplacingOccurrencesOfString(">", withString: "")
        token = token.stringByReplacingOccurrencesOfString(" ", withString: "")
        print(token)
        installation.saveInBackground()
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        if error.code == 3010 {
            print("Push notifications are not supported in the iOS Simulator.")
        } else {
            print("application:didFailToRegisterForRemoteNotificationsWithError: %@", error)
        }
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        PFPush.handlePush(userInfo)
        if application.applicationState == UIApplicationState.Inactive {
            PFAnalytics.trackAppOpenedWithRemoteNotificationPayload(userInfo)
        }
    }
}

