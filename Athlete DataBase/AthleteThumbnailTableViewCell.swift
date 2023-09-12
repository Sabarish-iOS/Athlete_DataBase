//
//  AthleteThumbnailTableViewCell.swift
//  Athlete DataBase
//
//  Created by Apple8 on 11/09/23.
//

import UIKit
import Kingfisher

class AthleteThumbnailTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var AthleteFrontCollectionView: UICollectionView!
    @IBOutlet weak var noDataFoundLabel: UILabel!
    var valued = NSArray()
    var delegate: collectionViewCellClicked?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.AthleteFrontCollectionView.delegate = self
        self.AthleteFrontCollectionView.dataSource = self
        self.AthleteFrontCollectionView.showsHorizontalScrollIndicator = false
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: self.AthleteFrontCollectionView.frame.size.width / 3, height: 140)
        self.AthleteFrontCollectionView.collectionViewLayout = flowLayout
        print(self.valued)
        self.noDataFoundLabel.backgroundColor = .lightGray
        self.noDataFoundLabel.layer.cornerRadius = 10.0
        self.noDataFoundLabel.layer.masksToBounds = true
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return valued.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AthleteThumbnailCollectionViewCell", for: indexPath) as! AthleteThumbnailCollectionViewCell
        cell.athleteNameLabel.backgroundColor = .lightGray
        cell.athleteNameLabel.textColor = UIColor.white
        
        if valued.count == 0 {
            self.noDataFoundLabel.isHidden = false
            self.AthleteFrontCollectionView.isHidden = true
        }else{
            self.noDataFoundLabel.isHidden = true
            self.AthleteFrontCollectionView.isHidden = false
            let ImageID = ((valued.object(at: indexPath.item) as! NSDictionary).value(forKey: "adId") as! String)
            let url = URL(string: "https://ocs-test-backend.onrender.com/athletes/\(ImageID)/photo")
            cell.athleteProfileImage.kf.setImage(with: url)
            cell.athleteNameLabel.text = ((valued.object(at: indexPath.item) as! NSDictionary).value(forKey: "name") as! String)
        }
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.cellClicked(myIndex: Int(((valued.object(at: indexPath.item) as! NSDictionary).value(forKey: "adId") as! String))!)
    }
    
}
