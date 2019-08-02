//
//  MessageService.swift
//  Here ?
//
//  Created by AsMaa on 7/1/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class MessageService{
    static let instance = MessageService()
    var messages = [MessageModel]()
    
    func findMessagesForChannel(channelId: String , completion: @escaping CompletionHandler){
        Alamofire.request("\(messageURL)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: bearerHeader).validate().responseJSON { [weak self](response) in
            if response.result.error == nil{
                self?.clearMessages()
                guard let data = response.data else{return}
                do{
                    if let json = try JSON(data: data).array{
                        for item in json{
                            let messageBody = item["messageBody"].stringValue
                            let userName = item["userName"].stringValue
                            let channelID = item["channelId"].stringValue
                            let userAvatar = item["userAvatar"].stringValue
                            let userAvatarColor = item["userAvatarColor"].stringValue
                            let id = item["_id"].stringValue
                            let timeStamp = item["timeStamp"].stringValue
                            
                            let message = MessageModel(message: messageBody, userName: userName, channelID: channelID, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                            self?.messages.append(message)
                        }
                    }
                }catch{}
                completion(true)
            }else{
                print(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    func clearMessages(){
        messages.removeAll()
    }
}
