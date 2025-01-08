//
//  TurkeyApp0_1SwiftApp.swift
//  TurkeyApp0.1Swift
//
//  Created by Furkan buğra karcı on 26.08.2024.
//

import SwiftUI
import Firebase

@main
struct TurkeyApp0_1SwiftApp: App {
    @StateObject private var authManager = AuthManager()
    @StateObject private var favoritesManager = FavoritesManager()
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            
            if authManager.isLoggedIn {
                ContentView()
                    .environmentObject(authManager)
                    .environmentObject(favoritesManager)
            } else {
                SignUpView()
                    .environmentObject(authManager)
            }
        }
    }
}
