//
//  File.swift
//  Here ?
//
//  Created by AsMaa on 6/11/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import Foundation
class LocalStore{
static let sharedLocalStore = LocalStore()
    let userDefaults =  UserDefaults.standard
    var isLoggedIn : Bool {
        get {
            
            return userDefaults.bool(forKey: loggedInKey)
        }
        set {
            userDefaults.set(newValue, forKey: loggedInKey)
        }
    }
    var userEmail: String?{
        get{
            return userDefaults.value(forKey: userEmailKey) as? String
        }
        set{
            return userDefaults.set(newValue, forKey: userEmailKey)
        }
    }
    func saveAccessToken(token:String){
        userDefaults.set(token, forKey: accessToken)
        
    }
    
    func getAccessToken() -> String? {
        return  userDefaults.object(forKey: accessToken) as? String
        
    }
    func deleteAccessToken(){
        userDefaults.removeObject(forKey: accessToken)
    }
    
  
    
    
}
