//
//  RoundedButton.swift
//  Here ?
//
//  Created by AsMaa on 6/11/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    @IBInspectable var cornerRadius : CGFloat = 3.0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
}
}
