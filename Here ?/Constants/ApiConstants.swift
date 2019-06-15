//
//  ApiConstants.swift
//  Here ?
//
//  Created by AsMaa on 6/11/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ success : Bool) -> ()

let baseURL = "https://herechatt.herokuapp.com/v1/"
let authURL = "\(baseURL)account/register"
let loginURL = "\(baseURL)account/login"
let createAccountURL = "\(baseURL)user/add"

let accessToken = "token"

let userEmailKey = "userEmail"
let loggedInKey = "loggedIn"
