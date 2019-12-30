//
//  NimCheckerViewController.swift
//  piket-cl-ios
//
//  Created by Fikri Adriansa Yudha on 08/10/19.
//  Copyright © 2019 Unikom Codelabs. All rights reserved.
//

import UIKit
import Alamofire
import HideShowPasswordTextField

class LoginViewController: UIViewController {

    @IBOutlet weak var textFieldPassword: UITextField!{
        didSet {
            textFieldPassword.tintColor = UIColor.lightGray
            textFieldPassword.isSecureTextEntry = true            
        }
    }
    @IBOutlet weak var labelKeteranganPassword: UILabel!
    @IBOutlet weak var labelNim: UILabel!
    var sendNimText:String = ""
    var finalNimText: String = ""
    var responseText = ""
    var passwordText = ""
    var networkManager = NetworkManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.sendNimText = self.finalNimText
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
                self.sendNimText = self.finalNimText
                self.passwordText = passwordString
                self.performSegue(withIdentifier: "sendPassword", sender: nil)
                print("lanjut logiinn")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "sendPassword"){
            let nav = segue.destination as! UINavigationController
            let vcListPiket = nav.topViewController as! ListPiketViewController
            vcListPiket.nimAuth = self.finalNimText
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
