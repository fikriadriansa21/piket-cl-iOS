//
//  AddNewViewController.swift
//  piket-cl-ios
//
//  Created by Fikri Adriansa Yudha on 23/10/19.
//  Copyright © 2019 Unikom Codelabs. All rights reserved.
//

import UIKit

class AddNewViewController: UIViewController {
//    @IBOutlet weak var textfieldAddPassword: UITextField! {
//        didSet {
//            textfieldAddPassword.tintColor = UIColor.lightGray
////            textfieldAddPassword.setIcon( imageLiteral(resourceName: "remove_red_eye-24px"))
//            textfieldAddPassword.isSecureTextEntry = true
//        }
//    }
//    @IBOutlet weak var textfieldConfirmPassword: UITextField! {
//        didSet {
//            textfieldConfirmPassword.tintColor = UIColor.lightGray
////            textfieldConfirmPassword.setIcon( imageLiteral(resourceName: "remove_red_eye-24px"))
//            textfieldConfirmPassword.isSecureTextEntry = true
//        }
//    }
    
    @IBAction func textfieldAddPassword(_ sender: Any) {
    }
    
    @IBAction func textfieldConfirmPassword(_ sender: Any) {
    }
    @IBAction func buttonSavePassword(_ sender: Any) {
    }
    let api = APIManager()
    var textAddPassword: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
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
