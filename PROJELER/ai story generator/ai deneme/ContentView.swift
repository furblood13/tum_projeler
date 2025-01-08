//
//  ContentView.swift
//  ai deneme
//
//  Created by Furkan buğra karcı on 14.11.2024.
//

import SwiftUI

struct ContentView: View {
    @State var prompt = " "
    @StateObject private var viewModel = ViewModel()
    @StateObject private var apikey = APIKey()
    var body: some View {
        ZStack{
            LinearGradient(colors: [.blue,.black], startPoint: .topLeading, endPoint: .bottomTrailing)
            
            ScrollView{
                VStack {
                    Text(viewModel.fetchedText)
                        .foregroundStyle(.white)
                        
                }
                
                .frame(maxWidth: .infinity)
                
                
            }
            
            .frame(maxWidth: .infinity,maxHeight: 500)
            .padding(.bottom,180)
            VStack() {
                Spacer()
                Text("Please enter your prompt:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(width: 300,height: 1)
                    .foregroundColor(.white)
                    .bold()
                    .font(.title2)
                TextField("", text: $prompt)
                    .frame(width: 330,height: 100)
                    .foregroundStyle(.secondary)
                    .textFieldStyle(.roundedBorder)
                    
                    
                Button(action: {
                    Task{
                        let newprompt = "bana içinde \(prompt) geçen bir hikaye yaz 2000 kelime olsun "
                        await viewModel.fetchData(prompt:newprompt)
                    }
                }) {
                    Text("SEND")
                        .bold()
                        .frame(width: 180, height: 55)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.linearGradient(colors: [.black, .blue],
                                      startPoint: .top,
                                      endPoint: .bottom))
                        )
                        .foregroundColor(.white)
                }
                .padding(20)
                
            }
            
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom, 20)
        }
        
        .navigationTitle("awe")
        .ignoresSafeArea()
        
    }
}
    
#Preview {
    ContentView()
}
