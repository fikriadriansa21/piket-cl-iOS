//
//  NetworkManager.swift
//  piket-cl-ios
//
//  Created by Fikri Adriansa Yudha on 17/11/19.
//  Copyright © 2019 Unikom Codelabs. All rights reserved.
//

import Foundation
import Moya

let defaultsToken = UserDefaults.standard
let dataStringToken: String = defaultsToken.string(forKey: "token") ?? ""
let authPlugin = AccessTokenPlugin { dataStringToken }
let provider = MoyaProvider<APIManager>(plugins: [authPlugin])

class NetworkManager{
    var stringToken: String = ""
    var tokenString: String = ""
    
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
}
