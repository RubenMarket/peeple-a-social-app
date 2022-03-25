//
//  AppDelegate.swift
//  People
//
//  Created by Ruben Mercado on 5/24/18.
//  Copyright © 2018 Sirius Awe. All rights reserved.
//

import UIKit
import RealmSwift
import AVFoundation
let app = App(id: "peeple-euckn")
@main
@available(iOS 13.0, *)
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate{
   
    var window: UIWindow?
//let locationManager = CLLocationManager()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        
        
//        UserDefaults.standard.set("no", forKey: "made")
//        let syncManager = app.syncManager
//        syncManager.logLevel = .debug
//        UserDefaults.standard.set(nil, forKey: "uid")
//        app.syncManager.errorHandler = { error, session in
//            let syncError = error as! SyncError
//            switch syncError.code {
//            case .clientResetError:
//                if let (path, clientResetToken) = syncError.clientResetInfo() {
////                    closeRealmSafely()
////                    saveBackupRealmPath(path)
////                    SyncSession.immediatelyHandleError(clientResetToken)
//                }
//            default:
//                // Handle other errors...
//                ()
//            }
//        }
        
//        window?.tintColor = .systemGray4
        
//        let now = Date()
//
//        let formatter = DateFormatter()
//        formatter.dateStyle = .none
//        formatter.timeStyle = .short
//
//        let datetime = formatter.string(from: now)
//        for c in datetime {
//            switch c {
//            case "7":
//                if datetime.contains("P") {
//                    UIScreen.main.brightness = 0.25
//                    break
//                } else {
//                    break
//                }
//            default :
//                break
//            }
//        }
        
        
//        print(datetime)
//        let configuration = AIDefaultConfiguration()
//        configuration.clientAccessToken = "1d2bfe9c66374ec0ac9456290d15d50e"
//
//        let apiai = ApiAI.shared()
//        apiai?.configuration = configuration
//
        
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
//        MusicPlayer.shared.stopBackgroundMusic()
    }

//    func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
//       return true
//    }
//
//    func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
//       return true
//    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//        let syncSession = syncedRealm.syncSession!
//        // Suspend synchronization
//        syncSession.suspend()
//        ImageCache.shared.removeAll()
    
    }
    
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        // 1. Convert device token to string
//        let tokenParts = deviceToken.map { data -> String in
//            return String(format: "%02.2hhx", data)
//        }
//        let token = tokenParts.joined()
//        // 2. Print device token to use for PNs payloads
//        print("Device Token: \(token)")
//    }
//    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
//        // 1. Print out error if PNs registration not successful
//        print("Failed to register for remote notifications with error: \(error)")
//    }
    
    


    
    

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
//        UIApplication.shared.applicationIconBadgeNumber = 0
//        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//        MusicPlayer.shared.startBackgroundMusic()
        
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
       
        
       
        
        
        
        
    }

   
    
    
    
    
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                willPresent notification: UNNotification,
//                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//
//        completionHandler([.alert, .sound])
//    }
//
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.notification.request.identifier == "Local Notification" {
            print("Handling notifications with the Local Notification Identifier")
        }
        
        completionHandler()
    }
    
    
    
    


}
