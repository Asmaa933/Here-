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
    let findUser = FindUserByEmail()
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
        let tap  = UITapGestureRecognizer(target: self, action: #selector (LoginVC.handleTap))
        view.addGestureRecognizer(tap)
    }
    @objc func handleTap(){
        view.endEditing(true)
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
        guard let email = usernameTxt.text?.lowercased() , usernameTxt.text != nil else {return}
         guard let password = passwordTxt.text, passwordTxt.text != nil else {return}
        let parameters :[String : Any] = [
                                "email" : email,
                                "password" : password
                                        ]
        login.logInUser(parameters: parameters) { (success) in
            if success{
                self.findUser.findUserByEmail(completion: { (success) in
                    if success{
                       NotificationCenter.default.post(name: notifUserDataChange, object: nil)
                        self.activityIndicator.isHidden = false
                        self.activityIndicator.stopAnimating()
                    
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
}
