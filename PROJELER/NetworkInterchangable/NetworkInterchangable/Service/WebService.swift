//
//  WebService.swift
//  NetworkInterchangable
//
//  Created by Furkan buğra karcı on 15.08.2024.
//

import Foundation

enum NetworkError: Error{
    
    case invalidURL
    case invalidServerResponse
}

class WebService : NetworkService{
    var type: String = "Webservice"
    
    
    
    
    func download (_ resource:String) async throws ->[User]{
        guard let url = URL(string: resource) else{
            throw NetworkError.invalidURL
        }
        let (data,responce) = try await URLSession.shared.data(from: url)
        
        guard let httpResponce=responce as? HTTPURLResponse,httpResponce.statusCode==200 else{
            throw NetworkError.invalidServerResponse
        }
        return try JSONDecoder().decode([User].self, from: data)
    }
}
