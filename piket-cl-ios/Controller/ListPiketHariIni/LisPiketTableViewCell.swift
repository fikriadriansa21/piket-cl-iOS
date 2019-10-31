//
//  LisPiketTableViewCell.swift
//  piket-cl-ios
//
//  Created by Fikri Adriansa Yudha on 30/10/19.
//  Copyright © 2019 Unikom Codelabs. All rights reserved.
//

import UIKit

class LisPiketTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelJobPiket: UILabel!
    @IBOutlet weak var labelNama: UILabel!
    @IBOutlet weak var buttonSelesaiPiket: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
