//
//  ViewController.swift
//  piket-cl-ios
//
//  Created by Fikri Adriansa Yudha on 03/10/19.
//  Copyright © 2019 Unikom Codelabs. All rights reserved.
//

import UIKit
import SwiftyJSON


class NimCheckerViewController: UIViewController {
    
    @IBOutlet weak var textFieldNim: UITextField!
    var nimText:String = ""
    var textBuatAddPassword = ""
    var networkManager = NetworkManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
    }
    
    @IBAction func buttonCheckPassword(_ sender: UIButton) {
        guard let nimString = textFieldNim.text, !nimString.isEmpty else {
            self.alertEmptyNim()
            return
        }
        
        networkManager.checkPassword(nim: nimString){(isRegistered) in
            if isRegistered{
                self.nimText = nimString
                self.performSegue(withIdentifier: "sendNim", sender: nil)                
                print(self.nimText)
            }else{
                print("belum terdaftar")
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
