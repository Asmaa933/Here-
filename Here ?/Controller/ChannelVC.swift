//
//  ChannelVC.swift
//  Here ?
//
//  Created by AsMaa on 6/9/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
       
    }
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        performSegue(withIdentifier: loginSegueID, sender: nil)
    }
    
}
