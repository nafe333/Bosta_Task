//
//  Network Constants.swift
//  Bosta Task
//
//  Created by Nafea Elkassas on 03/03/2025.
//

import Foundation
struct APIConstants {
    static let baseURL = "https://jsonplaceholder.typicode.com"

    enum Endpoints {
        static let users = "/users"
        static let albums = "/albums"
        static let photos = "/photos"
    }
}
