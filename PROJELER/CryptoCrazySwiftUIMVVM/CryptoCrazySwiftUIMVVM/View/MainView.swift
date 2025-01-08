//
//  ContentView.swift
//  CryptoCrazySwiftUIMVVM
//
//  Created by Furkan buğra karcı on 12.08.2024.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var cryptoListViewModel : CryptoListViewModel
    
    init (){
        self.cryptoListViewModel = CryptoListViewModel()
    }
    var body: some View {
        NavigationView{
            List(cryptoListViewModel.cryptoList,id:\.id){crypto in
                VStack{
                    Text(crypto.currency)
                        .font( .title3)
                        .foregroundStyle(Color.black)
                    Text(crypto.price)
                        .foregroundStyle(Color.gray)
                }
            }.navigationTitle(Text("Crypto Crazy"))
        }.task {
            await cryptoListViewModel.downloadCryptosAsync(url: URL(string:"https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
        }
        
        
        
       /* .onAppear{
            
            //cryptoListViewModel.downloadCryptos(url : URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
        }*/
    }
}

#Preview {
    MainView()
}
