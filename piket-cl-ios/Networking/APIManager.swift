//
//  APIManager.swift
//  piket-cl-ios
//
//  Created by Cahyanto Setya Budi on 16/11/19.
//  Copyright © 2019 Unikom Codelabs. All rights reserved.
//

import Foundation
import Moya

enum APIManager {
    case checkPassword(nim: String)
    case login(nim: String, password: String)
    case getListPiket
}

extension APIManager: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://absensi-codelabs.herokuapp.com/") else {
            fatalError("Base url not configured properly")
        }
        
        return url
    }
    
    var path: String {
        switch self {
        case .checkPassword:
            return "mobile/login/check-password"
        case .login:
            return "mobile/login"
        case .getListPiket:
            return "mobile/piket-hari-ini"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .checkPassword:
            return .post
        case .login:
            return .post
        case .getListPiket:
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
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case .login(let nim, let password):
            let param = [
                "nim": nim,
                "password": password
            ] as [String: Any]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case .getListPiket:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
