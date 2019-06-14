//
//  LoginVC.swift
//  Here ?
//
//  Created by AsMaa on 6/10/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let login = LogInServices()
    @IBOutlet weak var usernameTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
updateUI()
}
    func updateUI(){
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "UserName", attributes: [NSAttributedString.Key.foregroundColor : placeHolderColor])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : placeHolderColor])
    
        activityIndicator.isHidden = true
         HelpingMethods.checkEndEditing(viewController: LoginVC())
    }
    @IBAction func closeBtnTapped(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpBtnTapped(_ sender: UIButton) {
        performSegue(withIdentifier: createAccountSegueID, sender: nil)
        
    }
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        let parameters :[String : Any] = [
            "email" : usernameTxt.text?.lowercased() ?? "",
            "password" : passwordTxt.text ?? ""
                                          ]
        login.logInUser(parameters: parameters) { (success) in
            if success{
            self.activityIndicator.isHidden = false
                self.activityIndicator.stopAnimating()
                print("accessToken:")
    print(LocalStore.sharedLocalStore.getAccessToken() ?? "no access tokin")
            }
        }
    }
    
}
