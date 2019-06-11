//
//  LoginVC.swift
//  Here ?
//
//  Created by AsMaa on 6/10/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
let login = LogInServices()
    @IBOutlet weak var usernameTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

}
    
    @IBAction func closeBtnTapped(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpBtnTapped(_ sender: UIButton) {
        performSegue(withIdentifier: createAccountSegueID, sender: nil)
        
    }
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        let parameters :[String : Any] = [
            "email" : usernameTxt.text ?? "",
            "password" : passwordTxt.text ?? ""
                                          ]
        login.logInUser(parameters: parameters) { (success) in
            if success{
                print("accessToken:")
                print(LocalStore.sharedLocalStore.getAccessToken() ?? "no access tokin")
            }
        }
    }
    
}
