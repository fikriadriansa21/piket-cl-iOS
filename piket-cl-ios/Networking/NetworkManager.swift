//
//  NetworkManager.swift
//  piket-cl-ios
//
//  Created by Fikri Adriansa Yudha on 17/11/19.
//  Copyright © 2019 Unikom Codelabs. All rights reserved.
//

import Foundation
import Moya

struct NetworkManager {
    let provider: MoyaProvider<APIManager> = MoyaProvider<APIManager>()
    
    func checkPassword(nim: String, completion: @escaping (Bool) -> Void) {
        provider.request(.checkPassword(nim: nim)){(response) in
            switch response{
            case .success(_):
                completion(true)
            case .failure(_):
                completion(false)
            }
        }
    }
    
    func login(nim: String, password: String, completion: @escaping (String) -> Void){
        provider.request(.login(nim: nim, password: password)){(response) in
        

    }
    
    func getListPiket(completion: @escaping (Piket)->Void){
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
}

//           switch response{
//           case .success(let response):
//            do {
//              // 4
//                print(try response.mapJSON())
//
//            } catch {
//              print("error")
//            }
//
//           case .failure(_):
//            completion("error")
//            }


//var tokenValue = ""
//            guard let data = response.value?.data else {
//                return
//            }
//            do {
//                let decoder = JSONDecoder()
//                let responseToken = try decoder.decode(ResponseToken.self, from: data)
//                print((responseToken.data?.token)!)
//                tokenValue = ((responseToken.data?.token)!)
//                completion(tokenValue)
//            } catch let error {
//                print(error)
//            }
