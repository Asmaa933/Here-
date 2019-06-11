//
//  CreateAccountServices.swift
//  Here ?
//
//  Created by AsMaa on 6/11/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import Foundation
import Alamofire
class CreateAccountServices{
    func createAccount(parameters: [String: Any] , completion: @escaping CompletionHandler){
        let header = [
            "Authorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjU5MGJiYmIwNWRkMDgzM2IzNmNmMThiMyIsImlhdCI6MTQ5Mzk0MTE4OCwiZXhwIjoxNTAxNzE3MTg4fQ.6Uw4gqeZcj1xpLfkm-zI3rfr5q11WvvgjGypCMlbc-E",
            "Content-Type":"application/json"
                      ]
        
        Alamofire.request(createAccountURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if response.result.error == nil{
                //////// parse json here
                
              completion(true)
            }else{
                completion(false)
                print(response.result.error as Any)
            }
        }
        
    }
}
