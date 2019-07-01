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
    
    @IBOutlet weak var channelTableView: UITableView!
   
    let addchannel  = AddChannelService()
    @IBAction func prepareForWind (segue: UIStoryboardSegue){}
    override func viewDidLoad() {
        super.viewDidLoad()
self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector (ChannelVC.userDataDidChange(_:)), name: notifUserDataChange, object: nil)
        channelTableView.tableFooterView = UIView()
        addchannel.getChannel{ (success) in
            if success{
                self.channelTableView.reloadData()
                print("reload")
            }else{
                print("error")
            }

        
        
        // updateChannels()
    }
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
      
              print("sss\(MessageServices.instance.channels[3].channelTitle)")
        }else{
            loginBtn.setTitle("Login", for: .normal)
            userImage.image = UIImage(named: "menuProfileIcon")
            userImage.backgroundColor = UIColor.clear
        }
    }
    
    @IBAction func addChannelBtnTapped(_ sender: UIButton) {
        let addChannel = AddChannelVC()
        addChannel.modalPresentationStyle = .custom
        present(addChannel, animated: true, completion: nil)
    }
    func updateChannels(){
        addchannel.getChannel { (success) in
            if success{
                self.channelTableView.reloadData()
        
            }
        }
    }
}
extension ChannelVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageServices.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: channelCellID, for: indexPath) as? ChannelTableViewCell{
            let channel = MessageServices.instance.channels[indexPath.row]
         
            cell.configureCell(channel: channel)
        return cell
        }
        return UITableViewCell()
    }
    
    
    
}
