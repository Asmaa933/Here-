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
    func getAllChannels(completion: @escaping CompletionHandler){
    
        
        Alamofire.request(channelURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: bearerHeader).validate().responseJSON { (response) in
            if response.result.error == nil{
                guard let data = response.data else {return}
                do{
                  if let json = try JSON(data: data).array{
                    for item in json{
                        let name = item["name"].stringValue
                        let channelDesc =  item["description"].stringValue
                        let id = item["_id"].stringValue
                    
                   let channel = ChannelModel(channelTitle: name, channelDescription: channelDesc, id: id)
                        self.channels.append(channel)}
                    }
                }catch{}
                print(self.channels[3].channelTitle)
                completion(true)
            
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
}
