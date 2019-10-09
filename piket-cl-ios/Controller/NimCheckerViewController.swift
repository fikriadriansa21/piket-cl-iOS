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
    @IBOutlet weak var imageLogoCL: UIImageView!
    @IBOutlet weak var textFieldNim: UITextField!
    @IBOutlet weak var buttonCheckPassword: UIButton!
    
    let baseURL = "https://absensi-codelabs.herokuapp.com/mobile/check-password"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func checkPassword(nim: String) {
        
    }
}

