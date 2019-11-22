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
    var passwordText = ""
//    var textAddPassword: String = ""
//    var pass = ""

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
        networkManager.addPassword(nim: finalNimText, password: password){
            (canLogin) in
            self.passwordText = password
            self.performSegue(withIdentifier: "pass_baru", sender: nil)
            print("Kembali ke halaman sebelumnya")
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
