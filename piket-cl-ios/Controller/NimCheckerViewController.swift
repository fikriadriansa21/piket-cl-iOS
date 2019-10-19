//
//  ViewController.swift
//  piket-cl-ios
//
//  Created by Fikri Adriansa Yudha on 03/10/19.
//  Copyright © 2019 Unikom Codelabs. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class NimCheckerViewController: UIViewController {
    
    @IBOutlet weak var textFieldNim: UITextField!
    let baseURL:String = "https://absensi-codelabs.herokuapp.com/mobile/login/check-password"
    var nimText = ""
    var detailText: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func checkPassword(nim: String, completion: @escaping (Bool) -> Void) {

        Alamofire.request(baseURL, method: .post, parameters: ["nim": nim]).validate().responseJSON { response in
            print(response.response?.statusCode)
            completion(true)
        }
    }
    
    @IBAction func buttonCheckPassword(_ sender: UIButton) {
        let nim: String = textFieldNim.text!
        
        if nim.isEmpty {
            print("nim harus diisi")
        }
                
        self.nimText = textFieldNim.text!
        checkPassword(nim: nimText) { (success) in
            print("Halloooo")
        }
        
//        performSegue(withIdentifier: "sendNim", sender: self)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let vc = segue.destination as! LoginViewController
//        vc.finalNimText = self.nimText
////        vc.responseText = self.detailText
//    }
    
}


