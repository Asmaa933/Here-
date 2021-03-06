//
//  ApiConstants.swift
//  Here ?
//
//  Created by AsMaa on 6/11/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ success : Bool) -> ()
//URLs
let baseURL = "https://herechatt.herokuapp.com/v1/"
let authURL = "\(baseURL)account/register/"
let loginURL = "\(baseURL)account/login/"
let createAccountURL = "\(baseURL)user/add/"
let findUserByEmailURL = "\(baseURL)user/byEmail/"
let channelURL = "\(baseURL)channel/"
let messageURL = "\(baseURL)message/byChannel/"
//Headers
let header  = ["Content-Type" : "application/json"]
let bearerHeader = ["Authorization" : "Bearer \(LocalStore.instance.getAccessToken() ?? "")",
    "Content-Type": "application/json"
                   ]

let accessToken = "token"
let userEmailKey = "userEmail"
let loggedInKey = "loggedIn"
