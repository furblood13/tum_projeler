//
//  KpssPuanHesaplamaApp.swift
//  KpssPuanHesaplama
//
//  Created by Furkan buğra karcı on 30.09.2024.
//

import SwiftUI
import GoogleMobileAds
import SwiftData

@main
struct KpssPuanHesaplamaApp: App {
    //başlığın ve altındaki yerlerin kaymaması için görünüm ile alakalı
    init () {
        let apparenceNav = UINavigationBarAppearance()
        apparenceNav.configureWithOpaqueBackground()
        UINavigationBar.appearance().standardAppearance = apparenceNav
        UINavigationBar.appearance().scrollEdgeAppearance = apparenceNav
        
        let apparenceTab = UITabBarAppearance()
        apparenceTab.configureWithOpaqueBackground()
        UITabBar.appearance().scrollEdgeAppearance=apparenceTab
        UITabBar.appearance().standardAppearance=apparenceTab
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
    }
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        //bunu yazarak bu modelin swiftdata ile çalışabilmesine olanak sağlıyoruz
        .modelContainer(for:Result.self)
    }
}
