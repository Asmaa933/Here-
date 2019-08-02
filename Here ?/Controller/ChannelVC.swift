//
//  ChannelVC.swift
//  Here ?
//
//  Created by AsMaa on 6/9/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
    //Outlets
    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var addChannelBtn : UIButton!
    @IBOutlet weak var channelTableView: UITableView!
    @IBAction func prepareForWind (segue: UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector (ChannelVC.userDataDidChange(_:)), name: notifUserDataChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector (ChannelVC.channelLoaded(_:)), name: notiChannelLoaded, object: nil)
        channelTableView.tableFooterView = UIView()
        SocketService.instance.getChannel{ [weak self] (success) in
            if success{
                self?.channelTableView.reloadData()
            }
        }
        SocketService.instance.getMessages { [weak self] (newMessage) in
            if newMessage.channelID != ChannelServices.instance.selectedChannel?.id && LocalStore.instance.isLoggedIn{
                ChannelServices.instance.unreadChannels.append(newMessage.channelID)
                self?.channelTableView.reloadData()
            }
        }
    }
    @objc func userDataDidChange(_ notif : Notification){
        setupUserData()
    }
    
    @objc func channelLoaded(_ notif : Notification){
        channelTableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        setupUserData()
    }
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        if LocalStore.instance.isLoggedIn{
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        }else{
            performSegue(withIdentifier: loginSegueID, sender: nil)
        }
    }
    
    func setupUserData(){
        if LocalStore.instance.isLoggedIn{
            addChannelBtn.isEnabled = true
            loginBtn.setTitle(UserDataModel.instance.name, for: .normal)
            userImage.image = UIImage(named: UserDataModel.instance.avatarName)
            let avatarColor = UserDataModel.instance.returnUIColor(components: UserDataModel.instance.avatarColor)
            userImage.backgroundColor = avatarColor
        }else{
            addChannelBtn.isEnabled = false
            loginBtn.setTitle("Login", for: .normal)
            userImage.image = UIImage(named: "menuProfileIcon")
            userImage.backgroundColor = UIColor.clear
            channelTableView.reloadData()
        }
    }
    
    @IBAction func addChannelBtnTapped(_ sender: UIButton) {
        if LocalStore.instance.isLoggedIn{
            let addChannel = AddChannelVC()
            addChannel.modalPresentationStyle = .custom
            present(addChannel, animated: true, completion: nil)
        }
    }
}
extension ChannelVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ChannelServices.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: channelCellID, for: indexPath) as? ChannelTableViewCell{
            let channel = ChannelServices.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = ChannelServices.instance.channels[indexPath.row]
        if ChannelServices.instance.unreadChannels.count > 0 {
            ChannelServices.instance.unreadChannels = ChannelServices.instance.unreadChannels.filter{$0 != channel.id}
        }
        let index = IndexPath(row: indexPath.row, section: 0)
        channelTableView.reloadRows(at: [index], with: .none)
        channelTableView.selectRow(at: index, animated: false, scrollPosition: .none)
        ChannelServices.instance.selectedChannel = channel
        NotificationCenter.default.post(name: notiChannelSelected, object: nil)
        self.revealViewController()?.revealToggle(self)
    }
}
