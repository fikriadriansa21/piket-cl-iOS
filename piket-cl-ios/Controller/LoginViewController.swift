//
//  ViewController.swift
//  piket-cl-ios
//
//  Created by Fikri Adriansa Yudha on 03/10/19.
//  Copyright © 2019 Unikom Codelabs. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var textFieldPassword: UITextField!{
        didSet {
        textFieldPassword.isSecureTextEntry = true
//            textFieldPassword
//            textFieldPassword.tintColor = UIColor.lightGray
//            textFieldPassword.setIcon(#imageLiteral(resourceName: "remove_red_eye-24px"))
//            textFieldPassword.isSecureTextEntry = true
//            textFieldPassword.isSecureTextEntry.toggle()
        }
    }
    
    @IBOutlet weak var labelKeteranganPassword: UILabel!
    @IBOutlet weak var labelNim: UILabel!
    var finalNimText: String = ""
    var responseText = ""
    var passwordText = ""
    var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.labelNim.text = finalNimText
    }
    
    
    @IBAction func loginAction(_ sender: UIButton) {
        
        guard let passwordString = textFieldPassword.text, !passwordString.isEmpty else {
            self.alertEmptyPassword()
            return
        }
        networkManager.login(nim: finalNimText, password: passwordString){
            (canLogin) in
                self.passwordText = passwordString
                self.performSegue(withIdentifier: "sendPassword", sender: nil)
                print("lanjut logiinn")
        }
    }
    
    public func alertEmptyPassword(){
        let alert = UIAlertController(title: "Warning", message: "Password must be filled", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            print("Silahkan isi Password-mu")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}


