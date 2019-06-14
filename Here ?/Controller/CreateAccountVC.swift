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
    var avatarName = "profileDefault"
    let register = RegisterServices()
    let addaccount = AddAccountServices()
    let avatarColor = "[0.5,0.5,0.5,1]"
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func closeBtnPressed(_ sender: UIButton) {
        performSegue(withIdentifier:unwindToChannelSegueID, sender: nil)
    }
  
    @IBAction func chooseAvatarBtnTapped(_ sender: UIButton) {
        performSegue(withIdentifier: avataPickerSegueID, sender: nil)
       
        }
    
    
    @IBAction func GenerateBGColorBtnTapped(_ sender: UIButton) {
    }
    @IBAction func createAccountTapped(_ sender: UIButton) {
        let registerParameters :[String : Any] = [
            "email" : emailTxt.text ?? "",
            "password" : passwordTxt.text ?? ""
        ]
        let accountParameters:[String : Any] = [
            "email" : emailTxt.text ?? "",
            "name" : userNameTxt.text ?? "",
            "avatarName" : avatarName,
            "avatarColor" : avatarColor
        ]
        register.registerUser(parameters: registerParameters) { (success) in
            if success {
                self.addaccount.createAccount(parameters: accountParameters, completion: { (success) in
                    if success{
                        print(UserDataModel.sharedUserData.avatarName)
                        self.performSegue(withIdentifier: unwindToChannelSegueID, sender: nil)
                    }
                })
            }
        }
    }
}
