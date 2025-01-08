//
//  UserViewModel.swift
//  NetworkInterchangable
//
//  Created by Furkan buğra karcı on 15.08.2024.
//

import Foundation


class UserListViewModel:ObservableObject{
    
    @Published var userlist = [UserViewModel]()
    
    private var service:NetworkService
    init(service:NetworkService){
        self.service = service
    }
    func downloadUsers ()async{
        
        var resource : String
        if service.type == "Webservice"{
            resource = Constants.urls.userExtension
        }else{
            resource=Constants.Paths.baseUrl
        }
        
        do{
            let users=try await service.download(resource)
            DispatchQueue.main.async {
                self.userlist=users.map(UserViewModel.init)
            }
        }catch{
            print(error)
        }
        
        
    }
}




struct UserViewModel {
    let user : User
    
    var id:Int{
        user.id
    }
    
    var username:String{
        user.username
    }
    var name : String{
        user.name
    }
    var email:String{
        user.email
    }
}
