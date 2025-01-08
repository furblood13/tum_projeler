//
//  ContentView.swift
//  FirstSwiftUIApp
//
//  Created by Furkan buğra karcı on 6.08.2024.
//

import SwiftUI

struct ContentView: View {
    
    let myArray=["Ali","veli","furkan","berat"]
    var body: some View {
        
            
            List(myArray,id: \.self){ element in
                HStack {
                Image("araba1").resizable().aspectRatio(contentMode: .fit)
                        .frame(width: 30,height: 40.0)
                Text(element).font(.largeTitle)}
        }
        
        
    }
}

#Preview {
    ContentView()
}
