//
//  NimCheckerViewController.swift
//  piket-cl-ios
//
//  Created by Fikri Adriansa Yudha on 08/10/19.
//  Copyright © 2019 Unikom Codelabs. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var textFieldPassword: UITextField!{
        didSet {
            textFieldPassword.tintColor = UIColor.lightGray
            textFieldPassword.setIcon(#imageLiteral(resourceName: "remove_red_eye-24px"))
            textFieldPassword.isSecureTextEntry = true
        }
    }
    @IBOutlet weak var labelKeteranganPassword: UILabel!
    @IBOutlet weak var labelNim: UILabel!
    var finalNimText = ""
    var responseText = ""
    var passwordText = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        labelKeteranganPassword.text = responseText
        
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.labelNim.text = finalNimText
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Warning", message: "Password must be filled", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            print("Silahkan isi Password-mu")
        }))  
        passwordText = textFieldPassword.text!
        
//            api.loginUser(nim: finalNimText, password: passwordText){(success) in
//                self.performSegue(withIdentifier: "sendPassword", sender: self)
//            }
//            api.getListPiket(){(success) in
//                print("list piket")
//            }
        
    }
    
}
