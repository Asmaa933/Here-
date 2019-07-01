//
//  LoginServices.swift
//  Here ?
//
//  Created by AsMaa on 6/11/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import Foundation
import Alamofire
class RegisterServices{
    func registerUser(parameters: [String: Any], completion: @escaping CompletionHandler){
       
        
   
        Alamofire.request(authURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header).responseString { (response) in
            if  response.result.error == nil{

                completion (true)
            }else{
                completion (false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    
}
