//
//  HelpingMethods.swift
//  Here ?
//
//  Created by AsMaa on 6/14/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import Foundation

 func alertMessage(message: String) ->UIAlertController{
    let alert = UIAlertController(title: "Alert!", message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alert.addAction(action)
    return alert
}

