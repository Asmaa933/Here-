//
//  MessageCell.swift
//  Here ?
//
//  Created by AsMaa on 7/31/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var messageBodyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureCell(message: MessageModel){
        messageBodyLabel.text = message.message
        userNameLabel.text = message.userName
        userImage.image = UIImage(named: message.userAvatar)
        userImage.backgroundColor = UserDataModel.instance.returnUIColor(components: message.userAvatarColor)
        let time = message.timeStamp
        let convertedTime = time.convertStringToDate(withFormat: apiDateFormat)
        let convertedTime2 = convertedTime.convertDateToString(format: convertDateFormat)
        timeLabel.text = convertedTime2
    }
}
