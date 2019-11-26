//
//  NetworkManager.swift
//  piket-cl-ios
//
//  Created by Codelabs Division on 21/11/19.
//  Copyright © 2019 Unikom Codelabs. All rights reserved.
//


import Foundation
import Moya

struct NetworkManager {
//    let provider: MoyaProvider<APIManager> = MoyaProvider<APIManager>()
    let provider = MoyaProvider<APIManager.MyProvider>()
    
    public func checkPassword(nim: String, completion: @escaping (Bool) -> Void) {
        provider.request(.checkPassword(nim: nim)){result in
            switch result{
            case .success(let response):
                if response.statusCode == 200 {
                    completion(true)
                    print("Berhasil request")
                } else {
                    print(try? JSONSerialization.jsonObject(with: response.data, options: []))
                }
//                print(try? JSONSerialization.jsonObject(with: response.data, options: []))
            case .failure(let error):
                completion(false)
                print("Error: \(error)")
            }
        
        }
    }
    
    func login(nim: String, password: String, completion: @escaping (String) -> Void){
        provider.request(.login(nim: nim, password: password)){(response) in
    }
    }

    func addPassword(nim: String, password: String, completion: @escaping (String) -> Void){
        provider.request(.addPassword(nim: nim, password: password)){
            (response) in
            switch response{
                case .success(_):
                    print("Sukses add password")
                case .failure(_):
                    print("Gagal add password")
            }
        }
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
