//
//  AddChannelVC.swift
//  Here ?
//
//  Created by AsMaa on 6/19/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {
    var addChannel = AddChannelService()
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var nameTxt: UITextField!
    
    @IBOutlet weak var descTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

updateUI()
        
    }
    func updateUI(){
        let closeTap =  UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTap)
        nameTxt.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor : placeHolderColor])

        descTxt.attributedPlaceholder = NSAttributedString(string: "Description", attributes: [NSAttributedString.Key.foregroundColor : placeHolderColor])

    }
    @objc func closeTap(_ recognizer: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
    @IBAction func closeBtnTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
   
    @IBAction func createChannelBtnTapped(_ sender: UIButton) {
        guard let channelName = nameTxt.text , nameTxt.text != "" else {return}
        guard let channelDesc = descTxt.text , descTxt.text != "" else {return}
        addChannel.addChannel(channelName: channelName, channelDescription: channelDesc) { (success) in
            if success{
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
