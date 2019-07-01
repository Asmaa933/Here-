//
//  ChatVC.swift
//  Here ?
//
//  Created by AsMaa on 6/9/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var channelLabel: UILabel!
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

        NotificationCenter.default.addObserver(self, selector: #selector (ChatVC.userDataDidChange(_:)), name: notifUserDataChange, object: nil)
NotificationCenter.default.addObserver(self, selector: #selector (ChatVC.channelSelected(_:)), name: notiChannelSelected, object: nil)
        
        if LocalStore.sharedLocalStore.isLoggedIn{
          
            findUser.findUserByEmail { (success) in
               
                NotificationCenter.default.post(name: notifUserDataChange, object: nil)
                
            }
            
        }else {
                let alert = alertMessage(message: "Please Login")
                self.present(alert, animated: true, completion: nil)
            }
        
     
    }
    @objc func userDataDidChange(_ notif : Notification){
        if LocalStore.sharedLocalStore.isLoggedIn{
        getChannelsAndMessages()
        }else{
            let alert = alertMessage(message: "Please Login")
            present(alert, animated: true, completion: nil)
            
        }
    }
    @objc func channelSelected(_ notif : Notification){
        
    updateWithChannel()
    }
  
    func getChannelsAndMessages(){
        ChannelServices.instance.getAllChannels { (success) in
            if success{
            if ChannelServices.instance.channels.count > 0 {
                ChannelServices.instance.selectedChannel = ChannelServices.instance.channels[0]
                self.updateWithChannel()
            }else{
                self.channelLabel.text = "create channel first"
                }
            }
        }
    }
        func updateWithChannel(){
            let channel = ChannelServices.instance.selectedChannel?.channelTitle ?? "Here?"
            channelLabel.text = "#\(channel)"
        }
    func getMessage(){
        guard let channelId = ChannelServices.instance.selectedChannel?.id else {return}
        MessageService.instance.findMessagesForChannel(channelId: channelId) { (success) in
            
        }
    }

}
