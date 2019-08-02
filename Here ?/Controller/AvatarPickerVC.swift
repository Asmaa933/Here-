//
//  AvatarPickerVC.swift
//  Here ?
//
//  Created by AsMaa on 6/14/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController {
    @IBOutlet weak var modeSegmentControl: UISegmentedControl!
    @IBOutlet weak var avatarCollectionView: UICollectionView!
    
    var avatarMode =  AvatarMode.dark
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func segmentControlChanged(_ sender: UISegmentedControl) {
        if modeSegmentControl.selectedSegmentIndex == 0{
            avatarMode = .dark
        }else{
            avatarMode = .light
        }
        avatarCollectionView.reloadData()
    }
}
extension AvatarPickerVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: avatarCellID, for: indexPath) as? AvatarCollectionViewCell{
            cell.confiureCell(index:indexPath.item, mode: avatarMode)
            return cell
        }
        return AvatarCollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarMode == .dark{
            UserDataModel.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
        }else {
            UserDataModel.instance.setAvatarName(avatarName: "light\(indexPath.item)")
        }
        self.dismiss(animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var numbersOfColumns: CGFloat = 3
        if UIScreen.main.bounds.width > 320{
            numbersOfColumns = 4
        }
        let spacebetweenCells :CGFloat = 10
        let padding :CGFloat = 40
        let cellDimentions = ((avatarCollectionView.bounds.width - padding) - (numbersOfColumns - 1 ) * spacebetweenCells) / numbersOfColumns
        return CGSize(width: cellDimentions, height: cellDimentions)
    }
}
