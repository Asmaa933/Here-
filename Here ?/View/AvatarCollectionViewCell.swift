//
//  AvatarCollectionViewCell.swift
//  Here ?
//
//  Created by AsMaa on 6/14/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import UIKit
enum AvatarMode{
    case dark
    case light
}
class AvatarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    override func awakeFromNib() {
            super.awakeFromNib()
        setupView()
    }
    
    func setupView (){
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
    }
    func confiureCell (index: Int , mode: AvatarMode){
        switch mode {
        case .dark:
            avatarImage.image = UIImage(named: "dark\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        case .light:
            avatarImage.image = UIImage(named: "light\(index)")
            self.layer.backgroundColor = UIColor.gray.cgColor
        }
    }
}
