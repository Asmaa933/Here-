//
//  ChannelModel.swift
//  
//
//  Created by AsMaa on 6/19/19.
//

import Foundation
class ChannelModel{
    public private(set) var channelTitle : String = ""
    public private(set) var channelDescription: String = ""
    public private(set) var id:String = ""
    
    init(channelTitle:String , channelDescription : String , id : String){
        self.channelTitle = channelTitle
        self.channelDescription = channelDescription
        self.id = id
    }
}
