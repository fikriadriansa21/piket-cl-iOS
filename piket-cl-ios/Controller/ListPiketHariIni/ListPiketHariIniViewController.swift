//
//  ListJadwalPiketViewController.swift
//  piket-cl-ios
//
//  Created by Fikri Adriansa Yudha on 22/10/19.
//  Copyright © 2019 Unikom Codelabs. All rights reserved.
//

import UIKit
import Foundation
import FSCalendar
import Alamofire

class ListPiketHariIniViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView?
//    let api = APIManager()
    @IBOutlet weak var calendarWeekPiket: FSCalendar!{
        didSet{
            calendarWeekPiket.scope = .week
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        api.getListPiket(){(success) in
//            self.tableView?.reloadData()
//            print(self.api.piket)
//        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
      let cell = tableView.dequeueReusableCell(withIdentifier: "cellJadwalPiket", for: indexPath) as! LisPiketTableViewCell
//        if self.api.piket.count > 0 {
//            let eachPiket = self.api.piket[indexPath.row]
//            cell.labelNama?.text = eachPiket["nama_anggota"] as? String
//            cell.labelJobPiket?.text = eachPiket["jenis_piket"] as? String
//        }
      return cell
    }

}
