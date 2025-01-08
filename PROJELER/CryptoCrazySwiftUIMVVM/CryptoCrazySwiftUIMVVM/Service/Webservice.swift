//
//  Webservice.swift
//  CryptoCrazySwiftUIMVVM
//
//  Created by Furkan buğra karcı on 12.08.2024.
//

import Foundation


class Webservice{
    
    func downloadCurreniesAsync(url:URL) async throws -> [CryptoCurrency]{
        let (data,_)=try await URLSession.shared.data(from: url)
        
        let currenies=try? JSONDecoder().decode([CryptoCurrency].self, from: data)
        return currenies ?? []
    }
    
    
    
    
    /*
    func downloadCurrencies(url:URL,completion:@escaping(Result<[CryptoCurrency]?,DownloadError>)->Void){
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error=error{
                print(error.localizedDescription )
                
            }
            
            guard let data=data,error == nil else{
                return completion(.failure(.noData))
            }
            guard let currencies=try? JSONDecoder().decode([CryptoCurrency].self, from:data) else{
                return completion(.failure(.dataParseError))
            }
            completion(.success(currencies))
        }.resume()
    }*/
}

enum DownloadError:Error{
    case noData
    case badUrl
    case dataParseError
}


