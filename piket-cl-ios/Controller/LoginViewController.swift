//
//  NimCheckerViewController.swift
//  piket-cl-ios
//
//  Created by Fikri Adriansa Yudha on 08/10/19.
//  Copyright © 2019 Unikom Codelabs. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelNim.text = finalNimText
    }


}
