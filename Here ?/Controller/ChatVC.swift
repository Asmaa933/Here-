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
    
    @IBOutlet weak var sendBtn: UIButton!
    
    @IBOutlet weak var typingUserLabel: UILabel!
    let findUser = FindUserByEmail()
    var isTyping = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateSlideMenu()
        updateUI()
        NotificationCenter.default.addObserver(self, selector: #selector (ChatVC.userDataDidChange(_:)), name: notifUserDataChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector (ChatVC.channelSelected(_:)), name: notiChannelSelected, object: nil)
        
        
    }
    
    func updateSlideMenu(){
        menuBtn.addTarget(self.revealViewController(), action: #selector (SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
    }
    func updateUI(){
        sendBtn.isHidden = true
        view.bindToKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap)
        messageTableView.tableFooterView = UIView()
        messageTableView.estimatedRowHeight = 80
        messageTableView.rowHeight = UITableView.automaticDimension
        if LocalStore.sharedLocalStore.isLoggedIn{
            findUser.findUserByEmail { (success) in
                NotificationCenter.default.post(name: notifUserDataChange, object: nil)
            }
        }else {
            let alert = alertMessage(message: "Please Login")
            self.present(alert, animated: true, completion: nil)
        }
        SocketService.sharedSocket.getMessages { [weak self] (NewMessage) in
            if NewMessage.channelID == ChannelServices.instance.selectedChannel?.id && LocalStore.sharedLocalStore.isLoggedIn{
                MessageService.instance.messages.append(NewMessage)
                self?.messageTableView.reloadData()
                if MessageService.instance.messages.count > 0 {
                    let endIndex = IndexPath(row: MessageService.instance.messages.count - 1 , section: 0)
                    self?.messageTableView.scrollToRow(at: endIndex, at: .bottom , animated: false)
                }
                
            }
        }
        
        
        SocketService.sharedSocket.getTypingUser {[weak self] (typingUsers) in
            self?.handleTyping(typingUsers: typingUsers)
        }
    }
    fileprivate func handleTyping(typingUsers: [String:String]){
        guard let channelId = ChannelServices.instance.selectedChannel?.id else {return}
        var names = ""
        var numbersOfTypers = 0
        for (typingUser , channel) in typingUsers{
            if typingUser != UserDataModel.sharedUserData.name && channel == channelId{
                if names == ""{
                    names = typingUser
                }else{
                    names = "\(names), \(typingUser)"
                }
                numbersOfTypers += 1
            }
        }
        if numbersOfTypers > 0 && LocalStore.sharedLocalStore.isLoggedIn == true{
            var verb = "is"
            if numbersOfTypers > 1 {
                verb = "are"
            }
            typingUserLabel.text = "\(names) \(verb) typing a message "
        }else{
            typingUserLabel.text = ""
        }
    }
    
    @objc func userDataDidChange(_ notif : Notification){
        if LocalStore.sharedLocalStore.isLoggedIn{
            getChannelsAndMessages()
        }else{
            messageTableView.reloadData()
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
        getMessage()
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
            guard let message = messageTxt.text , messageTxt.text != nil else {return}
            SocketService.sharedSocket.addMessage(messageBody: message, userId: UserDataModel.sharedUserData.id, channelId: channelId) { [weak self] (success) in
                self?.messageTxt.text = ""
                self?.messageTxt.resignFirstResponder()
                SocketService.sharedSocket.socket.emit("stopType",UserDataModel.sharedUserData.name, channelId)
            }
        }
        
    }
    @IBAction func textFieldEditing(_ sender: UITextField) {
        guard let channelId = ChannelServices.instance.selectedChannel?.id else {return}
        if messageTxt.text == ""{
            
            isTyping = false
            sendBtn.isHidden = true
            SocketService.sharedSocket.socket.emit("stopType",UserDataModel.sharedUserData.name, channelId)
        }else{
            if isTyping == false{
                sendBtn.isHidden = false
                SocketService.sharedSocket.socket.emit("startType",UserDataModel.sharedUserData.name, channelId)
            }
            isTyping = true
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
