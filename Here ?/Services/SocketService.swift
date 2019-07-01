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
}
