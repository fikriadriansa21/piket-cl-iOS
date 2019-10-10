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
    let baseURL:String = "https://absensi-codelabs.herokuapp.com/mobile/check-password"
    var nimText = ""
    var detailText = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func buttonCheckPassword(_ sender: UIButton) {
        self.nimText = textFieldNim.text!
        performSegue(withIdentifier: "sendNim", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! LoginViewController
        vc.finalNimText = self.nimText        
    }
    
}

