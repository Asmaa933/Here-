//
//  LogInServices.swift
//  Here ?
//
//  Created by AsMaa on 6/11/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class LogInServices{
    func logInUser(parameters: [String:Any] , completion: @escaping CompletionHandler){
       
        Alamofire.request(loginURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if response.result.error == nil{
                guard let data = response.data else{return}
                do{
                    let json = try JSON(data: data)
                let token = json["token"].stringValue
     LocalStore.sharedLocalStore.saveAccessToken(token: token)

                let email = json["user"].stringValue
                    
            LocalStore.sharedLocalStore.userEmail = email
                }catch{}
              LocalStore.sharedLocalStore.isLoggedIn = true

                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
            }
        }

