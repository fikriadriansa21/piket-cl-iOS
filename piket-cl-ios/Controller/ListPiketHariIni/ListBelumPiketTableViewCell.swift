//
//  ListBelumPiketTableViewCell.swift
//  piket-cl-ios
//
//  Created by Fikri Adriansa Yudha on 12/12/19.
//  Copyright © 2019 Unikom Codelabs. All rights reserved.
//

import UIKit

class ListBelumPiketTableViewCell: UITableViewCell {

    @IBOutlet weak var labelNama: UILabel!
    @IBOutlet weak var labelJenisPiket: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
