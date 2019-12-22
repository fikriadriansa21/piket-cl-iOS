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
    case sudahPiketHariIni
    case belumPiketBulanan
    case listPiket
    case permohonanSelesaiPiket(id: Int)
    case konfirmasiPiket(id: Int)    
}

extension APIManager: TargetType, AccessTokenAuthorizable{
    
    var authorizationType: AuthorizationType {
        switch self {
            case .checkPassword:
                return .none
            case .login:
                return .none
            case .listPiket:
                return .bearer
            case .sudahPiketHariIni:
                return .bearer
            case .addPassword:
                return .none
            case .belumPiketBulanan:
                return .bearer
            case .permohonanSelesaiPiket:
                return .bearer
            case .konfirmasiPiket:
                return .bearer
        }
    }
            
    var baseURL: URL {
        guard let url = URL(string: "http://103.112.189.132:5227") else {
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
            case .addPassword:
                return "/mobile/login/add-password"
            case .sudahPiketHariIni:
                return "/mobile/sudah-piket-hari-ini"
            case .belumPiketBulanan:
                return "/mobile/belum-piket"
            case .permohonanSelesaiPiket:
                return "/mobile/selesai-piket"
            case .konfirmasiPiket:
                return "/mobile/inspeksi-piket"
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
        case .sudahPiketHariIni:
            return .get
        case .belumPiketBulanan:
            return .get
        case .permohonanSelesaiPiket:
            return .post
        case .konfirmasiPiket:
            return .post
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
        case .addPassword(let nim, let password):
            let param = [
                "nim": nim,
                "password": password
            ] as [String: Any]
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .listPiket:
            return .requestPlain
        case .sudahPiketHariIni:
            return .requestPlain
        case .belumPiketBulanan:
            return .requestPlain
        case .permohonanSelesaiPiket(let id):
            let param = [
                "id": id
            ] as [String: Any]
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .konfirmasiPiket(let id):
            let param = [
                "id": id
            ] as [String: Any]
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .listPiket:
            return [
                "token" : "\(defToken.string(forKey: "token") ?? "")"
            ]
        case .sudahPiketHariIni:
            return [
                "token" : "\(defToken.string(forKey: "token") ?? "")"
            ]
        case .belumPiketBulanan:
            return [
                "token" : "\(defToken.string(forKey: "token") ?? "")"
            ]
        case .permohonanSelesaiPiket:
            return [
                "token" : "\(defToken.string(forKey: "token") ?? "")"
            ]
        case .konfirmasiPiket:
            return [
                "token" : "\(defToken.string(forKey: "token") ?? "")"
            ]
        default:
            return nil
        }

    }
}

