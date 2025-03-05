//
//  ApiCaller.swift
//  Bosta Task
//
//  Created by Nafea Elkassas on 03/03/2025.
//

import Foundation
import Moya
enum APIService {
    case getUser(userId: Int)
    case getAlbums(userId: Int)
    case getPhotos(albumId: Int)
}

extension APIService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getUser(let userId):
            return "\(APIConstants.Endpoints.users)/\(userId)"
        case .getAlbums:
            return APIConstants.Endpoints.albums
        case .getPhotos:
            return APIConstants.Endpoints.photos
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
                case .getUser:
                    return .requestPlain
                case .getAlbums(let userId):
                    return .requestParameters(parameters: ["userId": userId], encoding: URLEncoding.default)
                case .getPhotos(let albumId):
                    return .requestParameters(parameters: ["albumId": albumId], encoding: URLEncoding.default)
                }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    
}
