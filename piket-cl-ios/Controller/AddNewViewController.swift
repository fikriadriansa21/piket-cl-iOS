//
//  AddNewViewController.swift
//  piket-cl-ios
//
//  Created by Fikri Adriansa Yudha on 23/10/19.
//  Copyright © 2019 Unikom Codelabs. All rights reserved.
//

import UIKit

class AddNewViewController: UIViewController {

    @IBOutlet weak var textNimAddPassword: UILabel!
    
    var textAddPassword: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textNimAddPassword.text = textAddPassword
        // Do any additional setup after loading the view.
    }

}
