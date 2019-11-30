//
//  NetworkManager.swift
//  piket-cl-ios
//
//  Created by Fikri Adriansa Yudha on 17/11/19.
//  Copyright © 2019 Unikom Codelabs. All rights reserved.
//

import Foundation
import Moya

var stringToken: String = ""
let defaultsToken = UserDefaults.standard

let provider = MoyaProvider<APIManager>()

class NetworkManager{
    
    func checkPassword(nim: String, completion: @escaping (Bool) -> Void) {
        provider.request(.checkPassword(nim: nim)){(response) in
            switch response{
            case .success(let value):
                if value.statusCode == 200 {
                    completion(true)
                }
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    
    public func login(nim: String, password: String, completion: @escaping (String?) -> Void){
        provider.request(.login(nim: nim, password: password)){(response) in
            switch response.result{
            case .success(let value):
                do {
                    let decoder = JSONDecoder()
                    let post = try decoder.decode(ResponseToken.self, from: value.data)
                    print(post.data?.token as Any)                    
                    completion(post.data?.token)
                    stringToken = (post.data?.token)!
                    defaultsToken.set(stringToken, forKey: "token")                    
                } catch (let error) {
                    print("error \(error)")
                }
            case .failure( _):
                print("gabisa bisa dapet token")
            }
        }
    }
    
    
    func getListPiket(completion: @escaping (Piket?)->Void){
        provider.request(.listPiket){(response) in
            switch response{
            case .success(let response):
                print(response.statusCode)
                 do {
                   print(try response.mapJSON())
                 } catch {
                   print("data tidak ditampilkan")
                }
            case .failure( _):
                 print("gagal dalam menampilkan data")
             }

            }

    }
}
