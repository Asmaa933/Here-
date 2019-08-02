//
//  MessageServices.swift
//  Here ?
//
//  Created by AsMaa on 6/19/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//
import Foundation
import Alamofire
import SwiftyJSON
class ChannelServices{
    
    static let instance =  ChannelServices()
    var channels = [ChannelModel]()
    var selectedChannel: ChannelModel?
    var unreadChannels =  [String]()
    
    func getAllChannels(completion: @escaping CompletionHandler){
        Alamofire.request(channelURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: bearerHeader).validate().responseJSON { [weak self] (response) in
            if response.result.error == nil{
                guard let data = response.data else {return}
                do{
                    if let json = try JSON(data: data).array{
                        for item in json{
                            let name = item["name"].stringValue
                            let channelDesc =  item["description"].stringValue
                            let id = item["_id"].stringValue
                            let channel = ChannelModel(channelTitle: name, channelDescription: channelDesc, id: id)
                            self?.channels.append(channel)}
                    }
                }catch{}
                NotificationCenter.default.post(name: notiChannelLoaded, object: nil)
                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    func clearChannels (){
        channels.removeAll()
    }
}
