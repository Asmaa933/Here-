//
//  CreateAccountVC.swift
//  Here ?
//
//  Created by AsMaa on 6/10/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    @IBOutlet weak var activityInd: UIActivityIndicatorView!
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    var avatarName = "profileDefault"
    let register = RegisterServices()
    let addaccount = AddAccountServices()
    let login = LogInServices()
    var avatarColor: [CGFloat] = [0.5,0.5,0.5,1]
    var bgColor : UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
updateUI()
    }
    func updateUI(){
        // change font color of placeholder 
        userNameTxt.attributedPlaceholder = NSAttributedString(string: "UserName", attributes: [NSAttributedString.Key.foregroundColor: placeHolderColor])
          passwordTxt.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: placeHolderColor])
          emailTxt.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: placeHolderColor])
    activityInd.isHidden = true
        let tap  = UITapGestureRecognizer(target: self, action: #selector (CreateAccountVC.handleTap))
        view.addGestureRecognizer(tap)
    }
    @objc func handleTap(){
        view.endEditing(true)
    }
    override func viewDidAppear(_ animated: Bool) {
        if UserDataModel.sharedUserData.avatarName != ""{
    userImage.image = UIImage(named: UserDataModel.sharedUserData.avatarName)
            if avatarName.contains("light") && bgColor == nil{
                userImage.backgroundColor = UIColor.lightGray
            }
        }
    }

    @IBAction func closeBtnPressed(_ sender: UIButton) {
        performSegue(withIdentifier:unwindToChannelSegueID, sender: nil)
    }
  
    @IBAction func chooseAvatarBtnTapped(_ sender: UIButton) {
        performSegue(withIdentifier: avataPickerSegueID, sender: nil)
       avatarName = UserDataModel.sharedUserData.avatarName
        }
    
    
    @IBAction func GenerateBGColorBtnTapped(_ sender: UIButton) {
        let randomR = CGFloat(arc4random_uniform(255)) / 255
          let randomG = CGFloat(arc4random_uniform(255)) / 255
          let randomB = CGFloat(arc4random_uniform(255)) / 255
        bgColor = UIColor(red: randomR, green: randomG, blue: randomB, alpha: 1)
        avatarColor = [randomR,randomG,randomB,1]
        UserDataModel.sharedUserData.setRGBColor(avatarColorRGB: avatarColor)
        UIView.animate(withDuration: 0.2) {
            self.userImage.backgroundColor = self.bgColor

        }
        
       
    }
    @IBAction func createAccountTapped(_ sender: UIButton) {
        activityInd.isHidden = false
        activityInd.startAnimating()
        let registerParameters :[String : Any] = [
            "email" : emailTxt.text?.lowercased() ?? "",
            "password" : passwordTxt.text ?? ""
        ]
        let accountParameters:[String : Any] = [
            "email" : emailTxt.text?.lowercased() ?? "",
            "name" : userNameTxt.text ?? "",
            "avatarName" : avatarName,
            "avatarColor" : "\(avatarColor)"
        ]
        register.registerUser(parameters: registerParameters) { (success) in
            if success {
                self.login.logInUser(parameters: registerParameters, completion: { (success) in
                    if success{
                        self.addaccount.createAccount(parameters: accountParameters, completion: { (succcess) in
                            if success{
                                self.activityInd.isHidden = true
                                self.activityInd.stopAnimating()
                                
                                
                                self.performSegue(withIdentifier: unwindToChannelSegueID, sender: nil)
                                NotificationCenter.default.post(name: notifUserDataChange, object: nil)
                            }
                        })
                    }
                })
               
            }
        }
    }
}
