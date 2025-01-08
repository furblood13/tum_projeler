//
//  RootView.swift
//  KpssPuanHesaplama
//
//  Created by Furkan buğra karcı on 30.09.2024.
//

import SwiftUI
import AppTrackingTransparency
struct RootView: View {
    //alttaki tabbar da hangisi seçili diye ayarlamak için
    @State private var selectionItem = 0
    var body: some View {
        TabView(selection:$selectionItem)
        {
            MainView()
                .tabItem {
                    Label("Başlangıç", systemImage: "house")
                        .environment(\.symbolVariants, selectionItem == 0 ? .fill : .none)
                }
                .tag(0)
            
            ResultView(selectionTabItem: $selectionItem)
                .tabItem { Label("Geçmiş hesaplamalar", systemImage: "arrow.counterclockwise.circle")
                        .environment(\.symbolVariants, selectionItem == 1 ? .fill : .none)
                }
                .tag(1)
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)){ _ in ATTrackingManager.requestTrackingAuthorization(completionHandler: {status in })
        }
            
        
        .tint(.main)
    }
}

#Preview {
    RootView()
}
