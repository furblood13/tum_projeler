//
//  LocalService.swift
//  NetworkInterchangable
//
//  Created by Furkan buğra karcı on 15.08.2024.
//

import Foundation


class LocalService : NetworkService{
    var type: String = "LocalService"
    func download (_ resource:String) async throws ->[User]{
        guard let path = Bundle.main.path(forResource: resource, ofType: "json") else{
            fatalError("RECOURSE NOT FOUND")
        }
        
      let data = try Data(contentsOf: URL(filePath: path))
        
       return try JSONDecoder().decode([User].self, from: data)
        
    }
    
}
