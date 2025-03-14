//
//  UserModel.swift
//  Bosta Task
//
//  Created by Nafea Elkassas on 03/03/2025.
//

import Foundation
struct User: Decodable {
    let id: Int
    let name: String
    let address: Address
}
struct Address: Decodable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
 
    
    var fullAddress: String {
        return "\(street), \(suite), \(city), \(zipcode)"
    }
}

struct Album: Decodable {
    let id: Int
    let title: String
    let userId: Int
}

struct Photo: Decodable {
    let id: Int
    let title: String
    let url: String
}
