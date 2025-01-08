//
//  ContentView.swift
//  NetworkInterchangable
//
//  Created by Furkan buğra karcı on 15.08.2024.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var userlistVM:UserListViewModel
    init(){
        self.userlistVM=UserListViewModel(service: LocalService())
    }
    var body: some View {
        List(userlistVM.userlist,id: \.id){
            user in
            VStack{
                Text(user.name)
                    .font(.title2)
                    .foregroundStyle(Color.black)
                    .frame(maxWidth: .infinity,alignment: .leading)
                Text(user.username)
                    .font(.title3)
                    .foregroundStyle(Color.gray)
                    .frame(maxWidth: .infinity,alignment: .leading)
                Text(user.email)
                    .font(.title3)
                    .foregroundStyle(Color.gray)
                    .frame(maxWidth: .infinity,alignment: .leading)
             
            }
        }.task {
           await userlistVM.downloadUsers()
        }
    }
}

#Preview {
    ContentView()
}
