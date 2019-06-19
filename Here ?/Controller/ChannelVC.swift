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
    override func viewDidAppear(_ animated: Bool) {
        setupUserData()
    }
    @objc func userDataDidChange(_ notif : Notification){
       setupUserData()
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
    func setupUserData(){
        if LocalStore.sharedLocalStore.isLoggedIn{
            loginBtn.setTitle(UserDataModel.sharedUserData.name, for: .normal)
            userImage.image = UIImage(named: UserDataModel.sharedUserData.avatarName)
            let avatarColor = UserDataModel.sharedUserData.returnUIColor(components: UserDataModel.sharedUserData.avatarColor)
            userImage.backgroundColor = avatarColor
        }else{
            loginBtn.setTitle("Login", for: .normal)
            userImage.image = UIImage(named: "menuProfileIcon")
            userImage.backgroundColor = UIColor.clear
        }
    }
}
