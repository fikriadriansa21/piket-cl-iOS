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
    @IBOutlet weak var calendarWeekPiket: FSCalendar!{
        didSet{
            calendarWeekPiket.scope = .week
        }
    }
    var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataTable()
    }
    
    public func loadDataTable(){
        networkManager.getListPiket(){(listPiket) in
            self.tableView?.reloadData()
            print("disini buat reload data api tablenya")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
//        return self.api.piket.count
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
