//
//  NetworkManager.swift
//  piket-cl-ios
//
//  Created by Fikri Adriansa Yudha on 17/11/19.
//  Copyright © 2019 Unikom Codelabs. All rights reserved.
//

import Foundation
import Moya

//protocol Networkable {
//    var provider: MoyaProvider<APIManager> { get }
//
//    func checkPassword(nim : String, completion: @escaping (Bool) -> Void)
//    func login(nim: String, password: String, completion: @escaping(Bool) -> Void)
//    func getListPiket(completion: @escaping (Piket?)->Void)
//
//}

struct storeKeys {
    static let tokenUser = ""
}
class NetworkManager{
//    var provider = MoyaProvider<APIManager>(plugins: [NetworkLoggerPlugin(verbose: true)])
    let provider = MoyaProvider<APIManager>()
    var stringToken: String = ""
    let defaults = UserDefaults.standard
    
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
                    self.stringToken = (post.data?.token)!
                    
                } catch (let error) {
                    print("error \(error)")
                }
                
                self.defaults.set(self.stringToken, forKey: storeKeys.tokenUser)
            case .failure( _):
                print("gabisa bisa dapet token")
            }
        }
    }
    
    func getListPiket(completion: @escaping (Piket?)->Void){
        provider.request(.listPiket){(response)in
            switch response{
            case .success(let response):
                 do {
                   // 4
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
