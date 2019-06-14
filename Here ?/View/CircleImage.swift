//
//  RoundedImage.swift
//  Here ?
//
//  Created by AsMaa on 6/14/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import UIKit
@IBDesignable
class CircleImage: UIImageView {
        @IBInspectable var cornerRadius: CGFloat = 3.0{
            didSet{
            self.layer.cornerRadius = cornerRadius

}
    }
            override func awakeFromNib() {
                super.awakeFromNib()
           setupview()
                
    }
    func setupview(){
        self.layer.cornerRadius = self.frame.width / 2
    self.clipsToBounds = true
    }
    override func prepareForInterfaceBuilder() {
        setupview()
    }

    }
