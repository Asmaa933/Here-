//
//  CreateAccountVC.swift
//  Here ?
//
//  Created by AsMaa on 6/10/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var userImage: UIImageView!
let register = RegisterServices()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func closeBtnPressed(_ sender: UIButton) {
        performSegue(withIdentifier:unwindToChannelSegueID, sender: nil)
    }
  
    @IBAction func chooseAvatarBtnTapped(_ sender: UIButton) {
        
       
        }
    
    
    @IBAction func GenerateBGColorBtnTapped(_ sender: UIButton) {
    }
    @IBAction func createAccountTapped(_ sender: UIButton) {
        let parameters :[String : Any] = [
            "email" : emailTxt.text ?? "",
            "password" : passwordTxt.text ?? ""
        ]
        register.registerUser(parameters: parameters) { (success) in
            print("registered !")
        }
    }
}
