//
//  NetworkManager.swift
//  piket-cl-ios
//
//  Created by Codelabs Division on 21/11/19.
//  Copyright © 2019 Unikom Codelabs. All rights reserved.
//


import Foundation
import Moya

let defaultsToken = UserDefaults.standard
var dataStringToken: String? =  defaultsToken.string(forKey: "token")
let authPlugin = AccessTokenPlugin{ (dataStringToken ?? "") }
let provider = MoyaProvider<APIManager>(plugins: [authPlugin])

class NetworkManager {
    
    var stringToken: String = ""
    var tokenString: String = ""
    var status: Int = 0
    public func checkPassword(nim: String, completion: @escaping (Int) -> Void) {
        provider.request(.checkPassword(nim: nim)){result in
            switch result{
            case .success(let response):
                self.status = response.statusCode
                completion(response.statusCode)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    public func login(nim: String, password: String, completion: @escaping (String?) -> Void){
        
        provider.request(.login(nim: nim, password: password)){(response) in
            print(nim+" - "+password)
            switch response.result{
            case .success(let value):
                do {
                    let decoder = JSONDecoder()
                    let post = try decoder.decode(ResponseToken.self, from: value.data)
                    completion(post.data?.token)
                    self.stringToken = (post.data?.token)!
                    defaultsToken.set(self.stringToken, forKey: "token")
                    self.tokenString = defaultsToken.string(forKey: "token")!
                } catch (let error) {
                    print("error \(error)")
                }
            case .failure( _):
                print("gabisa bisa dapet token")
            }
        }
    }

    func addPassword(nim: String, password: String, completion: @escaping (Bool) -> Void){
        provider.request(.addPassword(nim: nim, password: password)){result in
            switch result{
                case .success(let response):
                if response.statusCode == 200 {
                    completion(true)
                } else {
                    completion(false)
                }
                case .failure(let error):
                    completion(false)
                    print("Error: \(error)")
            }
        }
    }

    func getListPiket(completion: @escaping ([Piket]?)->Void){
        provider.request(.listPiket){(response) in
            switch response{
            case .success(let value):
                 do {
                    let decoder = JSONDecoder()
                    let post = try decoder.decode(ResponsePiket.self, from: value.data)
                    completion(post.data)
                 } catch {
                   print("data tidak ditampilkan")
            }
            case .failure( _):
                 print("gagal dalam menampilkan data")
            }
        }
    }
    func getListPiketWithTgl(tgl: String, completion: @escaping ([Piket]?)->Void){
        provider.request(.piketWithTgl(tgl: tgl)){(response) in
            switch response{
            case .success(let value):
                 do {
                    let decoder = JSONDecoder()
                    let post = try decoder.decode(ResponsePiket.self, from: value.data)
                    completion(post.data)
                 } catch {
                   print("data tidak ditampilkan")
            }
            case .failure( _):
                 print("gagal dalam menampilkan data")
            }
        }
    }
}
