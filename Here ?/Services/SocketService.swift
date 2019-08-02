//
//  SocketService.Swift
//  Here ?
//
//  Created by AsMaa on 6/23/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import UIKit
    import SocketIO
class SocketService: NSObject {

 static let sharedSocket = SocketService()
    let manager = SocketManager(socketURL: URL(string: baseURL)!, config: [.log(true), .compress])
    lazy var socket = manager.defaultSocket
    override init() {
        super.init()
    }
    
    func establishConnection(){
        socket.connect()
    }
    func closeConnection(){
        socket.disconnect()
    }
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
        SocketService.sharedSocket.socket.emit("newChannel", channelName, channelDescription)
        completion(true)
}
    func getChannel(completion: @escaping CompletionHandler) {
        SocketService.sharedSocket.socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDesc = dataArray[1] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            
            let newChannel = ChannelModel(channelTitle: channelName, channelDescription: channelDesc, id: channelId)
            ChannelServices.instance.channels.append(newChannel)
            completion(true)
        }
}
    func addMessage(messageBody : String, userId : String, channelId : String, completion : @escaping CompletionHandler) {
        let user =  UserDataModel.sharedUserData
        socket.emit("newMessage", messageBody , userId, channelId , user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
    func getMessages(_ completion: @escaping (_ newMessage: MessageModel) -> Void){
        socket.on("messageCreated") { [weak self] (dataArray, ack) in
            if let newMessage = self?.getMessageData(dataArray: dataArray){
            completion(newMessage)
                }
            }
        }
      
    
    fileprivate func getMessageData( dataArray: [Any]) -> MessageModel {
        guard let msgBody = dataArray[0] as? String else {return MessageModel()}
        guard let channelId = dataArray[2] as? String else {return MessageModel()}
        guard let userName = dataArray[3] as? String else {return MessageModel()}
        guard let userAvatar = dataArray[4] as? String else {return MessageModel()}
        guard let userAvatarColor = dataArray[5] as? String else {return MessageModel()}
        guard let id = dataArray[6] as? String else {return MessageModel()}
        guard let timeStamp = dataArray[7] as? String else {return MessageModel()}
        let newMessage =  MessageModel(message: msgBody, userName: userName, channelID: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
            return newMessage
        }
    
    func getTypingUser(_ completion: @escaping (_ typingUser: [String:String]) -> Void){
        socket.on("userTypingUpdate") { (dataArray, ack) in
            guard let typingUsers = dataArray[0] as? [String:String] else {return}
            completion(typingUsers)
        }
        
    }
}

