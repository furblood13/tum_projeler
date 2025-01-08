//
//  NetworkService.swift
//  NetworkInterchangable
//
//  Created by Furkan buğra karcı on 15.08.2024.
//

import Foundation

protocol NetworkService{
    func download(_ resource:String) async throws ->[User]
    var type : String{get}
}
