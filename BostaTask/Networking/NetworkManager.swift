//
//  NetworkManager.swift
//  Bosta Task
//
//  Created by Nafea Elkassas on 03/03/2025.
//

import Foundation
import Moya
import RxSwift

class NetworkManager{
    // Singleton
    static let shared = NetworkManager()
    private let provider = MoyaProvider<APIService>()
    
    private init() {}
    
    func fetchUser(userId: Int) -> Single<User> {
        return provider.rx.request(.getUser(userId: userId)).map(User.self)
    }
    func fetchAlbums(userId: Int) -> Single<[Album]> {
           return provider.rx.request(.getAlbums(userId: userId))
               .map([Album].self) // Decode into an array of albums
       }

       func fetchPhotos(albumId: Int) -> Single<[Photo]> {
           return provider.rx.request(.getPhotos(albumId: albumId))
               .map([Photo].self) // Decode into an array of photos
       }
}
