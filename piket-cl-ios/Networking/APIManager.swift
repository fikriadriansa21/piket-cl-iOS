//
//  APIManager.swift
//  piket-cl-ios
//
//  Created by Fikri Adriansa Yudha on 21/10/19.
//  Copyright © 2019 Unikom Codelabs. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIManager{
    let urlCheck: String = "https://absensi-codelabs.herokuapp.com/mobile/login/check-password"
    let urlLogin: String = "https://absensi-codelabs.herokuapp.com/mobile/login"
    let piketHariIni: String = "https://absensi-codelabs.herokuapp.com/mobile/piket-hari-ini"
    var detailText = ""
    var status: Bool = false
    var tokenText = ""
    var tokenVal = [Token]()
    
    
    public func checkPassword(nim: String, completion: @escaping (Bool) -> Void) {
        Alamofire.request(urlCheck, method: .post, parameters: ["nim": nim]).validate().responseJSON { response in
            if(response.response?.statusCode == 200){
                self.status = true
                self.detailText = "Silahkan login"
                completion(true)
                
            }else{
                self.detailText = "Anda belum punya password"
                self.status = false
                completion(false)
            }
            print(response.response?.statusCode as Any)
        }
    }
    
    public func loginUser(nim: String,password: String, completion: @escaping ([Token]) -> Void){
        
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
                        self.tokenVal = [responseToken.data]
                        print(self.tokenVal)
                        completion(self.tokenVal)
//                        self.detailText = tokenVal.self
//                    completion(true)
//                        self.tokenText = self.tokenVal
//                        completion(self.tokenText)
                    } catch let error {
                        print(error)
//                        completion(self)
                    }
                }else{
                    print("gabisa login")
                }
        }
    }
    
    public func getListPiket(token: String, completion: @escaping (Bool) -> Void) {
        let headers: HTTPHeaders = [
            "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1hIjoiRmlrcmkgQWRyaWFuc2EiLCJuaW0iOiIxMDExNzEyOCIsImJpZGFuZ19yaXNldCI6Ik1vYmlsZSIsImlkX3NpZGlramFyaSI6IjEwIiwiaWF0IjoxNTcyMDExMzIxfQ.HlQhGxcN2cAksciBiIbeh5Z7bgYf8plHV5K7W5-KVHM",
          "Accept": "application/json"
        ]
        Alamofire.request(piketHariIni, method: .get, headers: headers).validate().responseJSON { response in
            
            guard let data = response.data else{ return }
            do{
                let decoder = JSONDecoder()
                let responseListPiket = try decoder.decode(Response.self, from: data)
                print(responseListPiket.data as Any)
            }catch let error{
                print(error)
            }

            print(response.response?.statusCode as Any)
        }
    }
    
    
}
        






