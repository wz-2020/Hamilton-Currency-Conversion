//
//  AppDelegate.swift
//  Hamilton-Currency-Conversion
//
//  Created by Wanchun Zhang on 02/08/2022.
//

import UIKit
import BackgroundTasks

@main

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var backgroundUpdateTask: UIBackgroundTaskIdentifier!

    var backgroundTaskTimer:Timer! = Timer()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // first time run the app, load all exchange rate, call api
        let firstLoad = UserDefaults.standard.bool(forKey: "FirstLoad")
        if !firstLoad {
            refreshExchangeRate()
            UserDefaults.standard.set(true, forKey: "FirstLoad")
        }
        
        return true
    }
    
    func doBackgroundTask() {
        DispatchQueue.global(qos: .default).async {
            self.beginBackgroundTask()

            if self.backgroundTaskTimer != nil {
                self.backgroundTaskTimer.invalidate()
                self.backgroundTaskTimer = nil
            }

            // Call API every 5 hours
            self.backgroundTaskTimer = Timer.scheduledTimer(timeInterval: 18000, target: self, selector: #selector(self.refreshExchangeRate), userInfo: nil, repeats: true)
            RunLoop.current.add(self.backgroundTaskTimer, forMode: .default)
            RunLoop.current.run()

            self.endBackgroundTask()
        }
    }
    
    func beginBackgroundTask() {
        self.backgroundUpdateTask = UIApplication.shared.beginBackgroundTask(withName: "Refresh Exchange Rate", expirationHandler: {
            self.endBackgroundTask()
        })
    }

    func endBackgroundTask() {
        UIApplication.shared.endBackgroundTask(self.backgroundUpdateTask)
        self.backgroundUpdateTask = UIBackgroundTaskIdentifier.invalid
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        if self.backgroundTaskTimer != nil {
            self.backgroundTaskTimer.invalidate()
            self.backgroundTaskTimer = nil
        }
    }
 
    @objc func refreshExchangeRate () {
        let currencies = fetchAvailableCurrency()
        for currency in currencies {
            ExchangeRateManager.exchangeRate(currency: currency) { exchangeRate in
                
            }
        }
    }
    
    func fetchAvailableCurrency() -> [String] {
        var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml
        var plistData: [String: AnyObject] = [:]
        let plistPath: String? = Bundle.main.path(forResource: "settings", ofType: "plist")!
        let plistXML = FileManager.default.contents(atPath: plistPath!)!
        do {//convert the data to a dictionary and handle errors.
            plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as! [String:AnyObject]
            if let currencyArray = plistData["supported_currency"] as? [String] {
                 return currencyArray
            } else {
                return []
            }
        } catch {
            return []
        }
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

