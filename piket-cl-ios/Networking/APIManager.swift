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
//            print(response.response?.statusCode)
        }
    }
    
    public func loginUser(nim: String,password: String, completion: @escaping (Bool) -> Void){
        let param: Parameters = [
            "nim": nim,
            "password": password
        ]

        Alamofire.request(
            urlLogin, method: .post, parameters: param)
            .validate().responseJSON{ (response) in
                if(response.response?.statusCode == 200){
                    print("boleh login")
                    if let json = response.result.value {
                        print("JSON: \(json)")
                    }

//                    guard let data = response.data else { return }
//                    let json = try? JSON(data:data)
//                    if let token = json?["data"][0]["token"].string {
//                                    print(token)
//                    }
                    completion(true)
                }else{
                    print("gabisa login")
                    completion(false)
                }
        }

    }
    
}



