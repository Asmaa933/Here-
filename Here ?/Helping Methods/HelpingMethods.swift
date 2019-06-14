//
//  HelpingMethods.swift
//  Here ?
//
//  Created by AsMaa on 6/14/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import Foundation
import UIKit
class HelpingMethods{
   static func checkEndEditing(viewController:UIViewController){
        let tap  = UITapGestureRecognizer(target: viewController, action: #selector (HelpingMethods.handleTap(VC:)))
            viewController.view.addGestureRecognizer(tap)
}
    
@objc static func handleTap(VC:UIViewController){
    VC.view.endEditing(true)
}
}
