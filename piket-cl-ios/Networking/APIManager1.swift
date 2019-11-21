//
//  APIManager1.swift
//  piket-cl-ios
//
//  Created by Codelabs Division on 21/11/19.
//  Copyright © 2019 Unikom Codelabs. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIManager1{
    let urlCheck: String = "https://absensi-codelabs.herokuapp.com/mobile/login/check-password"
    let urlLogin: String = "https://absensi-codelabs.herokuapp.com/mobile/login"
    let piketHariIni: String = "https://absensi-codelabs.herokuapp.com/mobile/piket-hari-ini"
    let urlAddPass: String = "https://absensi-codelabs.herokuapp.com/mobile/login/add-password"
//    var detailText = ""
    var status: Bool = false
    var dataVal = [Piket]()
    var tokenValue: String = ""
        
    
    public func checkPassword(nim: String, completion: @escaping (Bool) -> Void) {
        Alamofire.request(urlCheck, method: .post, parameters: ["nim": nim]).validate().responseJSON { response in
            if(response.response?.statusCode == 200){
                self.status = true
//                self.detailText = "Silahkan login"
                completion(true)
                
            }else{
//                self.detailText = "Anda belum punya password"
                self.status = false
                completion(false)
            }
            print(response.response?.statusCode as Any)
        }
    }
    
    public func loginUser(nim: String,password: String, completion: @escaping (String) -> Void){
        let param: Parameters = [
            "nim": nim,
            "password": password
        ]
        Alamofire.request(
            urlLogin, method: .post, parameters: param)
            .validate().responseJSON{ response in
                if(response.response?.statusCode == 200){
                    print("boleh login")
                    
                    guard let data = response.data else {
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        let responseToken = try decoder.decode(ResponseToken.self, from: data)
                        print(responseToken.data!)
                        self.tokenValue = (responseToken.data?.token)!
                        completion(self.tokenValue)
                    } catch let error {
                        print(error)
                    }
                }else{
                    print("gabisa login")
                }
        }
    }
    
    public func addPassword(nim: String,password: String, completion: @escaping (String) -> Void){
        let param: Parameters = [
            "nim": nim,
            "password": password
        ]
        Alamofire.request(urlAddPass, method: .post, parameters: param)
        .validate().responseJSON{
            response in
            if(response.response?.statusCode == 200) {
                print("Mengirim Data Berhasil")
            }else{
                print("Gagal Mengirim Data")
            }
        }
    }
    
    public func getListPiket(completion: @escaping ([Piket]) -> Void) {
//        let getTokenValue: String = self.lo
        let headers = [
            "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1hIjoiRmlrcmkgQWRyaWFuc2EiLCJuaW0iOiIxMDExNzEyOCIsImJpZGFuZ19yaXNldCI6Ik1vYmlsZSIsImlkX3NpZGlramFyaSI6IjEwIiwiaWF0IjoxNTcyMDExMzIxfQ.HlQhGxcN2cAksciBiIbeh5Z7bgYf8plHV5K7W5-KVHM"
        ]
        Alamofire.request(piketHariIni, method: .get, headers: headers).validate().responseJSON { response in
            
            if(response.response?.statusCode == 200){
                print("boleh dapet akses token")
                
                guard let data = response.data else {
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let responseList = try decoder.decode(Response.self, from: data)

                    self.dataVal = responseList.data!
                    print(self.dataVal)
                    completion(self.dataVal)
                } catch let error {
                    print(error)
                }
            }else{
                print("gabisa dapet akses token")
            }
        }
    }
    
    
}
