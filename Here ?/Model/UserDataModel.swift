//
//  UserDataModel.swift
//  Here ?
//
//  Created by AsMaa on 6/14/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import Foundation
class UserDataModel{
    static var sharedUserData = UserDataModel()
    public private(set) var name = ""
    public private(set) var email = ""
    public private(set) var avatarName = ""
    public private(set) var avatarColor = ""
    public private(set) var id = ""
    public private(set) var avatarColorRGB :[CGFloat] = []
    
    func setUserData(name:String , email: String , avatarName: String, avatarColor:String, id : String){
        self.name = name
        self.email = email
        self.avatarName = avatarName
        self.avatarColor = avatarColor
        self.id = id
        
    }
    func setAvatarName(avatarName: String){
    self.avatarName = avatarName
    }
    func setRGBColor(avatarColorRGB: [CGFloat]){
        self.avatarColorRGB = avatarColorRGB
    }
}
