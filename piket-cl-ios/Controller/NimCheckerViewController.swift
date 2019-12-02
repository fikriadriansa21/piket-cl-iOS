//
//  NimCheckerViewController.swift
//  piket-cl-ios
//
//  Created by Fikri Adriansa Yudha on 08/10/19.
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
        
        networkManager.checkPassword(nim: nim){result in
            if result == 200 {
                self.nimText = nim
                self.performSegue(withIdentifier: "sendNim", sender: nil)
                print(nim)
            } else if result == 401 {
                self.nimText = nim
                self.performSegue(withIdentifier: "pass_baru", sender: nil)
                print(nim+" - ")
            } else {
                self.alertEmptyNim()
            }
        }
        
    }
    
    private func alertEmptyNim(){
        let alert = UIAlertController(title: "Warning", message: "NIM must be filled or Your NIM is not registered ", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "sendNim"){
            let vcLogin = segue.destination as! LoginViewController
            vcLogin.finalNimText = self.nimText
        }
        if(segue.identifier == "pass_baru"){
            let vcAddPassword = segue.destination as! AddNewViewController
            vcAddPassword.finalNimText = self.nimText
            textFieldNim.text = ""
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
