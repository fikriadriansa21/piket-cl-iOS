//
//  NetworkManager.swift
//  piket-cl-ios
//
//  Created by Cahyanto Setya Budi on 16/11/19.
//  Copyright © 2019 Unikom Codelabs. All rights reserved.
//

import Foundation
import Moya

struct NetworkManager {
    let provider: MoyaProvider<APIManager> = MoyaProvider<APIManager>()
    
    func checkPassword(nim: String, completion: @escaping (Bool) -> Void) {
        provider.request(.checkPassword(nim: nim)) { (response) in
            switch response {
            case .success(let result):
                completion(true)
            case .failure(let error):
                completion(false)
            }
        }
    }
}
