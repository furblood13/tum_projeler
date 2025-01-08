//
//  EczaneDenemeUygulamas_App.swift
//  EczaneDenemeUygulaması
//
//  Created by Furkan buğra karcı on 16.08.2024.
//

import SwiftUI
import GoogleMobileAds
import Firebase
class AppDelegate:NSObject,UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        GADMobileAds.sharedInstance().start()
        FirebaseApp.configure()
        
        return true
    }
}


@main
struct EczaneDenemeUygulamas_App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
    }
    
    var body: some Scene {
        WindowGroup {
            IlilceView()
        }
    }
}

