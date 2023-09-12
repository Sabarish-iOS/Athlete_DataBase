//
//  AthleteThumbnailCollectionViewCell.swift
//  Athlete DataBase
//
//  Created by Apple8 on 11/09/23.
//

import UIKit

protocol collectionViewCellClicked{
    func cellClicked(myIndex: Int)
}

class AthleteThumbnailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var athleteProfileImage: UIImageView!
    
    @IBOutlet weak var athleteNameLabel: UILabel!
    
}
