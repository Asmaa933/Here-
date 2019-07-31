//
//  ChatVC.swift
//  Here ?
//
//  Created by AsMaa on 6/9/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var messageTxt: UITextField!
    let findUser = FindUserByEmail()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        updateSlideMenu()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap)
        messageTableView.tableFooterView = UIView()
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
    @objc func handleTap(){
        view.endEditing(true)
    }
    @objc func channelSelected(_ notif : Notification){
        
    updateWithChannel()
    }
  
    func getChannelsAndMessages(){
        ChannelServices.instance.getAllChannels { [weak self] (success) in
            if success{
            if ChannelServices.instance.channels.count > 0 {
                ChannelServices.instance.selectedChannel = ChannelServices.instance.channels[0]
                self?.updateWithChannel()
            }else{
                self?.channelLabel.text = "create channel first"
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
            self.messageTableView.reloadData()
            
        }
    }

    @IBAction func sendBtnTapped(_ sender: UIButton) {
       if LocalStore.sharedLocalStore.isLoggedIn{
        guard let channelId = ChannelServices.instance.selectedChannel?.id else {return}
        guard let message = messageTxt.text else {return}
        SocketService.sharedSocket.addMessage(messageBody: message, userId: UserDataModel.sharedUserData.id, channelId: channelId) { [weak self] (success) in
            self?.messageTxt.text = ""
            self?.messageTxt.resignFirstResponder()
        }
        }
    
    }
}
extension ChatVC :  UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell =  tableView.dequeueReusableCell(withIdentifier: messageCellID, for: indexPath) as? MessageCell{
            let message = MessageService.instance.messages[indexPath.row]
        cell.configureCell(message: message)
            return cell
       
        }else{
            return UITableViewCell()
        }
        
    }
    
    
}
