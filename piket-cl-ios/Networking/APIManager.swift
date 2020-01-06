//
//  APIManager.swift
//  piket-cl-ios
//
//  Created by Fikri Adriansa Yudha on 21/10/19.
//  Copyright © 2019 Unikom Codelabs. All rights reserved.
//

import Foundation
import Moya

let defToken = UserDefaults.standard

enum APIManager{
    case checkPassword(nim: String)
    case login(nim: String, password: String)
    case addPassword(nim: String, password: String)
    case listPiket
    case piketWithTgl(queryParams: String)
    
}
extension APIManager: TargetType, AccessTokenAuthorizable {
    var authorizationType: AuthorizationType{
        switch self {
        case .checkPassword:
            return .none
        case .login:
            return .none
        case .listPiket:
            return .basic
        case .addPassword:
            return .none
        case .piketWithTgl:
            return .basic
        }
    }
        
    var baseURL: URL {
        switch self {
        case .piketWithTgl(let tgl):
            let url = URL(string: "https://absensi-codelabs.herokuapp.com")?.appendParameters(params: queryParams)
        default:
            guard let url = URL(string: "https://absensi-codelabs.herokuapp.com") else {
                fatalError("Base url not configured properly")
            }
        }
        return url
    }
        
    var path: String {
        switch self {
        case .checkPassword:
            return "mobile/login/check-password"
        case .login:
            return "mobile/login"
        case .addPassword:
            return "mobile/login/add-password"
        case .listPiket:
            return "mobile/piket-hari-ini"
        case .piketWithTgl:
            return "mobile/cari-piket"
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
            case .piketWithTgl:
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
                return .requestParameters(parameters: param, encoding: JSONEncoding.default)
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
            case .piketWithTgl(let tgl):
                let queryParams: [String: String] = [
                        "tanggal": tgl
                ]
                return .requestParameters(parameters: queryParams, encoding: JSONEncoding.default)
            }
    }
    
    var headers: [String : String]? {
        switch self {
        case .listPiket:
            return [
                "token" : "\(defToken.string(forKey: "token") ?? "")"
            ]
        case .piketWithTgl(let tgl):
            return [
                "token" : "\(defToken.string(forKey: "token") ?? "")"
            ]
        default:
            return nil
            
        }
    }
}
