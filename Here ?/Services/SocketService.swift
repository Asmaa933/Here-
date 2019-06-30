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
}
