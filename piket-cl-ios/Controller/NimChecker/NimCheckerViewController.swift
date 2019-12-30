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
    
    @IBOutlet weak var textFieldNim: UITextField!{
        didSet{
            textFieldNim.keyboardType = UIKeyboardType.numberPad
        }
    }
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
        
        networkManager.checkPassword(nim: nimString){(statusCode) in
            if statusCode == 200{
                print(statusCode)
                self.nimText = nimString
                self.performSegue(withIdentifier: "sendNim", sender: nil)                
            }else if statusCode == 401{
                print(statusCode)
                self.nimText = nimString
                self.performSegue(withIdentifier: "pass_baru", sender: nil)
            }else {
                print(statusCode)
                self.alertNotFound()
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
    
    private func alertNotFound(){
        let alert = UIAlertController(title: "Warning", message: "Pengguna ini ga ada di Codelabs loh!!", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            print("Pengguna ini ga ada di Codelabs loh!!")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "sendNim"){
            let vcLogin = segue.destination as! LoginViewController
            vcLogin.finalNimText = self.nimText
            print("ngirim nim")
        }else if(segue.identifier == "pass_baru"){
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
