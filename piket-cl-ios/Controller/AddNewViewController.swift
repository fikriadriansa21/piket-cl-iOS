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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
