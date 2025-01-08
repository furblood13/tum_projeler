//
//  Root.swift
//  ai deneme
//
//  Created by Furkan buğra karcı on 19.11.2024.
//

import Foundation
//
//  RootView.swift
//  KpssPuanHesaplama
//
//  Created by Furkan buğra karcı on 30.09.2024.
//

import SwiftUI

struct Root: View {
    //alttaki tabbar da hangisi seçili diye ayarlamak için
    @State private var selectionItem = 0
    var body: some View {
        TabView(selection:$selectionItem)
        {
            ContentView()
                .tabItem {
                    Label("Başlangıç", systemImage: "house")
                        .environment(\.symbolVariants, selectionItem == 0 ? .fill : .none)
                }
                .tag(0)
            
            SavedStoriesView()
                .tabItem { Label("Geçmiş hesaplamalar", systemImage: "arrow.counterclockwise.circle")
                        .environment(\.symbolVariants, selectionItem == 1 ? .fill : .none)
                }
                .tag(1)
        }
     
            
        
        
    }
}

#Preview {
    Root()
}
