//
//  ProfileVC.swift
//  Here ?
//
//  Created by AsMaa on 6/15/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var nameTxt: UILabel!
    
    @IBOutlet weak var emailTxt: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
updateUI()
    }
    func updateUI(){
        userImage.image = UIImage(named: UserDataModel.sharedUserData.avatarName)
        //let bgColor = UserDataModel.sharedUserData.avatarColorRGB
       // userImage.backgroundColor = UIColor(red: bgColor[0], green: bgColor[1], blue: bgColor[2], alpha: 1)
        nameTxt.text = UserDataModel.sharedUserData.name
        emailTxt.text = UserDataModel.sharedUserData.email
         let closeTap = UIGestureRecognizer(target: self, action: #selector(ProfileVC.closeView(_:)))
        view.addGestureRecognizer(closeTap)
    }
    @objc func closeView(_ recognizer : UIGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
 
    @IBAction func closeModalTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func logOutBtnTapped(_ sender: UIButton) {
    UserDataModel.sharedUserData.logOutUser()
        
        NotificationCenter.default.post(name: notifUserDataChange,object: nil)

        
    dismiss(animated: true, completion: nil)
        
    }
  
}