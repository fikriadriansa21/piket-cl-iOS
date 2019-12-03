//
//  AddNewViewController.swift
//  piket-cl-ios
//
//  Created by Fikri Adriansa Yudha on 23/10/19.
//  Copyright © 2019 Unikom Codelabs. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class AddNewViewController: UIViewController {

    @IBOutlet weak var tfAddPassword: UITextField!{
        didSet {
            tfAddPassword.tintColor = UIColor.lightGray
            tfAddPassword.setIcon(#imageLiteral(resourceName: "remove_red_eye-24px"))
            tfAddPassword.isSecureTextEntry = true
        }
    }
    @IBOutlet weak var tfConfirmPass: UITextField!{
        didSet {
            tfConfirmPass.tintColor = UIColor.lightGray
            tfConfirmPass.setIcon(#imageLiteral(resourceName: "remove_red_eye-24px"))
            tfConfirmPass.isSecureTextEntry = true
        }
    }
    
    var networkManager = NetworkManager()
    var finalNimText: String = ""
    var password = ""
    var nim = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func buttonSave(_ sender: UIButton) {
        
        guard let password = tfAddPassword.text, !password.isEmpty
            else {
                self.alertEmptyPassword()
                return
        }
        
        guard let confirmPass = tfConfirmPass.text, !confirmPass.isEmpty
            else {
                self.alertEmptyPassword()
                return
        }
        
        let alert2 = UIAlertController(title: "Warning", message: "Password and Password Confirmation are not the same", preferredStyle: .actionSheet)
        alert2.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            print("")
        }))

        if password != confirmPass {
            self.present(alert2, animated: true)
        } else {
            self.nim = finalNimText
            self.password = password
            networkManager.addPassword(nim: nim, password: password){
                (success) in
                let navigationController = self.presentingViewController as? UINavigationController
                self.dismiss(animated: true) {
                    let _ = navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    }
    
    public func alertEmptyPassword(){
        let alert = UIAlertController(title: "Warning", message: "Password must be filled", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
