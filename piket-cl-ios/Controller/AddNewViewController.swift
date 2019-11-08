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
    
    let api = APIManager()
    var textAddPassword: String = ""
    var pass = ""
    
    @IBOutlet weak var tfAddPassword: UITextField!
    @IBOutlet weak var tfConfirmPass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func buttonSave(_ sender: UIButton) {
        let password: String = tfAddPassword.text!
        let confirmPass: String = tfConfirmPass.text!
        let alert = UIAlertController(title: "Warning", message: "Silahkan masukkan password dan konfirmasi password", preferredStyle: .actionSheet)
        let alert2 = UIAlertController(title: "Warning", message: "Password dan Konfirmasi Password tidak sama", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            print("Silahkan isi Password-mu")
        }))
        alert2.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            print("Silahkan masukan ulang password")
        }))
        let nim = textAddPassword
        pass = tfAddPassword.text!
        
        if password.isEmpty {
            self.present(alert, animated: true)
            print("Password harus diisi")
        } else if confirmPass.isEmpty {
            self.present(alert, animated: true)
            print("Konfirmasi password harus diisi")
        } else {
            if password != confirmPass {
                self.present(alert2, animated: true)
            } else {
                api.addPassword(nim: nim, password: pass){
                    (success) in
                    print("Moving")
                    let navigationController = self.presentingViewController as? UINavigationController

                    self.dismiss(animated: true) {
                        let _ = navigationController?.popToRootViewController(animated: true)
                    }
                }
            
            }

        }
        
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
