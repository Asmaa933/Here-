//
//  ChannelTableViewCell.swift
//  Here ?
//
//  Created by AsMaa on 6/19/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import UIKit

class ChannelTableViewCell: UITableViewCell {

    @IBOutlet weak var channelName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected{
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        }else{
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
        
    }
        func configureCell(channel: ChannelModel){
            let title = channel.channelTitle
            channelName.text = "#\(title)"
        }
        
    

}
