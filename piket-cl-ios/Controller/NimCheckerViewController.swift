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
    var nimText = ""
    var textBuatAddPassword = ""
    var networkManager = NetworkManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
    }
    
    @IBAction func buttonCheckPassword(_ sender: UIButton) {
        guard let nim = textFieldNim.text, !nim.isEmpty else {
            self.alertEmptyNim()
            return
        }
        
        networkManager.checkPassword(nim: nimText){(isRegistered) in
            if isRegistered{
                self.nimText = nim
                self.performSegue(withIdentifier: "sendNim", sender: nil)
            }else{
                
            }
        }
    }
    
    private func alertEmptyNim(){
        let alert = UIAlertController(title: "Warning", message: "NIM must be filled", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            print("Silahkan isi NIM-mu")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "sendNim"){
            let vcLogin = segue.destination as! LoginViewController
            vcLogin.finalNimText = self.nimText
            print("ngirim nim")
        }
//        if(segue.identifier == "dontHavePassword"){
//            let vcAddPassword = segue.destination as! AddNewViewController
//            vcAddPassword.textAddPassword = self.nimText
//        }
    }
    
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
