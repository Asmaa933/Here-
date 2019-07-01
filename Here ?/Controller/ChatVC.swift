//
//  ChatVC.swift
//  Here ?
//
//  Created by AsMaa on 6/9/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var menuBtn: UIButton!
let findUser = FindUserByEmail()
    
    override func viewDidLoad() {
        super.viewDidLoad()
updateSlideMenu()
    }
    func updateSlideMenu(){
        menuBtn.addTarget(self.revealViewController(), action: #selector (SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        if LocalStore.sharedLocalStore.isLoggedIn{
          
            findUser.findUserByEmail { (success) in
               
                NotificationCenter.default.post(name: notifUserDataChange, object: nil)
            }
        }
        ChannelServices.instance.getAllChannels { (success) in
       
        }
    }
  

}
