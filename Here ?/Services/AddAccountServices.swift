//
//  CreateAccountServices.swift
//  Here ?
//
//  Created by AsMaa on 6/11/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class AddAccountServices{
    
    func createAccount(parameters: [String: Any] , completion: @escaping CompletionHandler){
        Alamofire.request(createAccountURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: bearerHeader).validate().responseJSON { (response) in
            if response.result.error == nil{
                guard let data = response.data else {return}
                do{
                    let json = try JSON(data: data)
                    let name = json["name"].stringValue
                    let email = json["email"].stringValue
                    let avatarName = json["avatarName"].stringValue
                    let avatarColor = json["avatarColor"].stringValue
                    let id = json["_id"].stringValue
                    UserDataModel.instance.setUserData(name: name, email: email, avatarName: avatarName, avatarColor: avatarColor, id: id)
                }catch{}
                completion(true)
            }else{
                completion(false)
                print(response.result.error as Any)
            }
        }
    }
}
