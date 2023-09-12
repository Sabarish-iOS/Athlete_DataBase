//
//  PrizeTableViewCell.swift
//  Athlete DataBase
//
//  Created by Apple8 on 12/09/23.
//

import UIKit

class PrizeTableViewCell: UITableViewCell {

    @IBOutlet weak var prizeNameLbl: UILabel!
    
    @IBOutlet weak var goldView: UIView!
    @IBOutlet weak var goldLbl: UILabel!
    
    @IBOutlet weak var bronzeView: UIView!
    @IBOutlet weak var bronzeLbl: UILabel!
    
    @IBOutlet weak var silverView: UIView!
    @IBOutlet weak var silverLbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
