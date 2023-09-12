//
//  BioTableViewCell.swift
//  Athlete DataBase
//
//  Created by Apple8 on 12/09/23.
//

import UIKit

class BioTableViewCell: UITableViewCell {

    @IBOutlet weak var bioLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
