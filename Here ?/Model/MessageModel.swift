
//
//  MessageModel.swift
//  Here ?
//
//  Created by AsMaa on 7/1/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import Foundation
class MessageModel{
    public private(set) var message = ""
    public private(set) var userName = ""
    public private(set) var channelID = ""
    public private(set) var userAvatar = ""
    public private(set) var userAvatarColor = ""
    public private(set) var id = ""
    public private(set) var timeStamp = ""
    init() {
    }
    init (message: String,userName: String,channelID: String,userAvatar: String,userAvatarColor: String,id: String,timeStamp: String){
        self.message = message
        self.userName = userName
        self.channelID = channelID
        self.userAvatar = userAvatar
        self.userAvatarColor = userAvatarColor
        self.id = id
        self.timeStamp = timeStamp
    }
}
