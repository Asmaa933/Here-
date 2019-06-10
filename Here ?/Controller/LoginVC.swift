//
//  LoginVC.swift
//  Here ?
//
//  Created by AsMaa on 6/10/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

}
    
    @IBAction func closeBtnTapped(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccountBtnTapped(_ sender: UIButton) {
        performSegue(withIdentifier: createAccountSegueID, sender: nil)
        
    }
}
