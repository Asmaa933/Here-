//
//  AddChannelService.swift
//  Here ?
//
//  Created by AsMaa on 6/30/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

//Listens for a new chat message
//client.on('newChannel', function(name, description) {
//    //Create channel
//    let newChannel = new Channel({
//        name: name,
//        description: description,
//    });

//Save it to database
//newChannel.save(function(err, channel){
//    //Send message to those connected in the room
//    console.log('new channel created');
//    io.emit("channelCreated", channel.name, channel.description, channel.id);
//});
//});
import Foundation
class AddChannelService {
    var message = MessageServices()
    
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
        SocketService.sharedSocket.socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
//    func addChannel(channelName: String , channelDescription :String, completion: @escaping CompletionHandler){
//       SocketService.sharedSocket.socket.emit("newChannel", channelName, channelDescription)
//        completion(true)
//
//
//    }
    
//    func getChannel(completion: @escaping CompletionHandler){
//
//        SocketService.sharedSocket.socket.on("channelCreated") { (dataArray, ack) in
//            if !dataArray.isEmpty{
//            guard let channelName = dataArray[0] as? String else {return}
//              guard let channelDesc = dataArray[1] as? String else {return}
//              guard let channelID  = dataArray[2] as? String else {return}
//            let newChannel = ChannelModel(channelTitle: channelName, channelDescription: channelDesc, id: channelID)
//            self.message.channels.append(newChannel)
//            completion(true)
//            }else{
//                print("empty array")
//                completion(false)
//            }
//
//        }
//    }
        func getChannel(completion: @escaping CompletionHandler) {
           SocketService.sharedSocket.socket.on("channelCreated") { (dataArray, ack) in
                guard let channelName = dataArray[0] as? String else { return }
                guard let channelDesc = dataArray[1] as? String else { return }
                guard let channelId = dataArray[2] as? String else { return }
                
                let newChannel = ChannelModel(channelTitle: channelName, channelDescription: channelDesc, id: channelId)
                self.message.channels.append(newChannel)
                completion(true)
            }
        }
}
//}
