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
let dataStringToken = defaultsToken.string(forKey: "token")
let authPlugin = AccessTokenPlugin { dataStringToken! }
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
//                if response.statusCode == 200 {
//                    print(try? JSONSerialization.jsonObject(with: response.data, options: []))
//                    completion(true)
//                }else if response.statusCode == 401 {
//                    print(try? JSONSerialization.jsonObject(with: response.data, options: []))
//                    completion(false)
//                } else {
//                    completion(false)
//                }
            case .failure(let error):
                print("Error: \(error)")
            }
        
        }
    }
    
    public func login(nim: String, password: String, completion: @escaping (String?) -> Void){
        
        provider.request(.login(nim: nim, password: password)){result in
            switch result{
            case .success(let response):
                do {
                    print(try? JSONSerialization.jsonObject(with: response.data, options: []))
                    let decoder = JSONDecoder()
                    let post = try decoder.decode(ResponseToken.self, from: response.data)
                    completion(post.data?.token)
                    self.stringToken = (post.data?.token)!
                    defaultsToken.set(self.stringToken, forKey: "token")
                    self.tokenString = defaultsToken.string(forKey: "token")!
                } catch (let error) {
                    print(try? JSONSerialization.jsonObject(with: response.data, options: []))
                    print("error \(error)")
                }
                print(self.tokenString)
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
                    print(nim+" - "+password)
                    print(try? JSONSerialization.jsonObject(with: response.data, options: []))
                    completion(true)
                } else {
                    print(nim+" & "+password)
                    print(try? JSONSerialization.jsonObject(with: response.data, options: []))
                    completion(false)
                }
                case .failure(let error):
                            completion(false)
                    print("Error: \(error)")
                }
        }
    }

    
    func getListPiket(completion: @escaping (Piket)->Void){
        provider.request(.listPiket){(response) in
        switch response{
        case .success(let value):
            print(value.statusCode)
             do {
                let decoder = JSONDecoder()
//                let post = try decoder.decode(ResponsePiket.self, from: value.data)
//                print(post)
             } catch {
               print("data tidak ditampilkan")
            }
        case .failure( _):
             print("gagal dalam menampilkan data")
         }

        }
    }
}
