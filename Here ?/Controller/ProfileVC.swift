//
//  ProfileVC.swift
//  Here ?
//
//  Created by AsMaa on 6/15/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameTxt: UILabel!
    @IBOutlet weak var emailTxt: UILabel!
    
    override func viewDidLoad() {
       super.viewDidLoad()
        updateUI()
    }
    
    func updateUI(){
        userImage.image = UIImage(named: UserDataModel.instance.avatarName)
        let avatarColor = UserDataModel.instance.returnUIColor(components: UserDataModel.instance.avatarColor)
        userImage.backgroundColor = avatarColor
        nameTxt.text = UserDataModel.instance.name
        emailTxt.text = UserDataModel.instance.email
        let closeTap = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeView(_:)))
        bgView.addGestureRecognizer(closeTap)
    }
    
    @objc func closeView(_ recognizer : UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
    @IBAction func closeModalTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func logOutBtnTapped(_ sender: UIButton) {
        UserDataModel.instance.logOutUser()
        NotificationCenter.default.post(name: notifUserDataChange,object: nil)
        dismiss(animated: true, completion: nil)
    }
}
