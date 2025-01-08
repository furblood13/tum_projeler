//
//  CryptoCurrency.swift
//  CryptoCrazySwiftUIMVVM
//
//  Created by Furkan buğra karcı on 12.08.2024.
//

import Foundation


struct CryptoCurrency : Decodable,Identifiable,Hashable{
    let id=UUID()
    let currency:String
    let price:String
    
    
    private enum CodingKeys: String,CodingKey{
        case currency="currency"
        case price="price"
    }
}
