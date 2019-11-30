//
//  APIManager.swift
//  piket-cl-ios
//
//  Created by Fikri Adriansa Yudha on 21/10/19.
//  Copyright © 2019 Unikom Codelabs. All rights reserved.
//

import Foundation
import Moya

enum APIManager{
    case checkPassword(nim: String)
    case login(nim: String, password: String)
    case listPiket
}

extension APIManager: TargetType, AccessTokenAuthorizable{
    var authorizationType: AuthorizationType {
        switch self {
            case .checkPassword:
                return .none
            case .login:
                return .bearer
            case .listPiket:
                return .basic
            }
    }
            
    
    var baseURL: URL {
        guard let url = URL(string: "https://absensi-codelabs.herokuapp.com") else {
            fatalError("Base url not configured properly")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .checkPassword:
            return "/mobile/login/check-password"
        case .login:
            return "/mobile/login"
        case .listPiket:
            return "/mobile/piket-hari-ini"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .checkPassword:
            return .post
        case .login:
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
            ] as [String: Any]
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .login(let nim, let password):
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
            return ["Content-Type": "application/json"]
    }

}
