//
//  ListViewCell.swift
//  MedicalReminder
//
//  Created by Niklas Lindell on 2018-12-13.
//  Copyright © 2018 Niklas Lindell. All rights reserved.
//

import UIKit

class ListViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var totalQuantityLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var warningSign: UIButton!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
