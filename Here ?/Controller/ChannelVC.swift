//
//  ChannelVC.swift
//  Here ?
//
//  Created by AsMaa on 6/9/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var loginBtn: UIButton!
    @IBAction func prepareForWind (segue: UIStoryboardSegue){}
    override func viewDidLoad() {
        super.viewDidLoad()
self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector (ChannelVC.userDataDidChange(_:)), name: notifUserDataChange, object: nil)
    }
    @objc func userDataDidChange(_ notif : Notification){
        if LocalStore.sharedLocalStore.isLoggedIn{
            loginBtn.setTitle(UserDataModel.sharedUserData.name, for: .normal)
            userImage.image = UIImage(named: UserDataModel.sharedUserData.avatarName)
            let avatarColor = UserDataModel.sharedUserData.avatarColorRGB
          userImage.backgroundColor = UIColor(red: avatarColor[0], green: avatarColor[1], blue: avatarColor[2], alpha: 1)
        }else{
            loginBtn.setTitle("Login", for: .normal)
            userImage.image = UIImage(named: "menuProfileIcon")
            userImage.backgroundColor = UIColor.clear
        }
    }
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        if LocalStore.sharedLocalStore.isLoggedIn{
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        }else{
        performSegue(withIdentifier: loginSegueID, sender: nil)
    }
    }
}
