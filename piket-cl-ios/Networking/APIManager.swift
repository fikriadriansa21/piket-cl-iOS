//
//  APIManager.swift
//  piket-cl-ios
//
//  Created by Fikri Adriansa Yudha on 21/10/19.
//  Copyright © 2019 Unikom Codelabs. All rights reserved.
//

import Foundation
import Moya

private let apiKey = ""

enum APIManager{
    case checkPassword(nim: String)
    case login(nim: String, password: String)
    case addPassword(nim: String, password: String)
    case listPiket
    
}
extension APIManager: TargetType, AccessTokenAuthorizable {
    var authorizationType: AuthorizationType{
        switch self {
        case .checkPassword:
            return .none
        case .login:
            return .bearer
        case .listPiket:
            return .basic
        case .addPassword:
            return .none
        }
    }
        
    var baseURL: URL {
        return URL(string: "http://103.112.189.132:5227/")!
    }
        
    var path: String {
        switch self {
        case .checkPassword:
            return "mobile/login/check-password"
        case .login:
            return "login"
        case .addPassword:
            return "mobile/login/add-password"
        case .listPiket:
            return "mobile/piket-hari-ini"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .checkPassword:
                return .post
            case .login:
                return .post
            case .addPassword:
                return .post
            case .listPiket:
                return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
            case .checkPassword(let nim):
                let param = [
                    "nim": nim
                    ] as [String : Any]
                return .requestParameters(parameters: param, encoding: URLEncoding.default)
            case .login(let nim, let password):
                let param = [
                    "nim": nim,
                    "password": password
                ] as [String: Any]
                return .requestParameters(parameters: param, encoding: JSONEncoding.default)
            case .addPassword(let nim, let password):
                let param = [
                    "nim": nim,
                    "password": password
                ] as [String: Any]
                return .requestParameters(parameters: param, encoding: JSONEncoding.default)
            case .listPiket:
                return .requestPlain
            }
    }
    
    var headers: [String : String]? {
        return ["token": "Bearer \(apiKey)"]
    }
    
}
