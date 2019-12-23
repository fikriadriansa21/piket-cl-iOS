//
//  LisPiketTableViewCell.swift
//  piket-cl-ios
//
//  Created by Fikri Adriansa Yudha on 30/10/19.
//  Copyright © 2019 Unikom Codelabs. All rights reserved.
//

import UIKit
import Moya

class ListHariIniTableViewCell: UITableViewCell {
    var listTableViewController : ListPiketViewController?
    
    @IBOutlet weak var labelJobPiket: UILabel!
    @IBOutlet weak var labelNama: UILabel!
    @IBOutlet weak var buttonSelesaiPiket: UIButton!
    var actionBlock: (() -> Void)? = nil            
    
    @IBAction func btnSelesaiInAction(_ sender: UIButton) {        
        actionBlock?()
        deleteDataInRow()
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func deleteDataInRow(){
        listTableViewController!.moveTheCell(cell: self)
    }
}
