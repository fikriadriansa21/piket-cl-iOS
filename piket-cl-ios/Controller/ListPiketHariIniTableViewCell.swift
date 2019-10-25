//
//  ListPiketHariIniTableViewCell.swift
//  piket-cl-ios
//
//  Created by Fikri Adriansa Yudha on 25/10/19.
//  Copyright © 2019 Unikom Codelabs. All rights reserved.
//

import UIKit

class ListPiketHariIniTableViewCell: UITableViewCell {

    @IBOutlet weak var labelJobPiket: UILabel!
    @IBOutlet weak var labelNama: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
