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

enum LoadDataPiket: Int {
    case PiketHariIni = 0,
    SudahPiketHariIni = 1,
    BelumPiketBulanan = 2
}

class ListPiketHariIniViewController: UIViewController {    
    var networkManager = NetworkManager()
    var piket = [Piket]()
    var sudahPiket = [SudahPiket]()
    var belumPiketBulanan = [BelumPiket]()
    let defToken = UserDefaults.standard
    var nimAuth:String = ""
    
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var calendarWeekPiket: FSCalendar!{
        didSet{
            calendarWeekPiket.scope = .week
            calendarWeekPiket.appearance.headerMinimumDissolvedAlpha = 0.0            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataPiket()
    }
    
    func getDataPiket(dataPiket: [Piket]){
        self.piket = dataPiket
    }
    
    func getDataSudah(dataPiket: [SudahPiket]){
        self.sudahPiket = dataPiket
    }
    
    func getDataBelum(dataPiket: [BelumPiket]){
        self.belumPiketBulanan = dataPiket
    }
    
    public func loadDataPiket(){
        networkManager.getListPiket(){(listPiket) in
            if let data = listPiket{
                self.getDataPiket(dataPiket: data)
                self.tableView?.reloadData()
            }
        }
        
        networkManager.getSudahPiketHariIni{(listSudahPiket) in
            if let data = listSudahPiket{
                self.getDataSudah(dataPiket: data)
                self.tableView?.reloadData()
            }
        }
        
        networkManager.getBelumPiketBulanan{(belumPiketBulanan) in
            if let data = belumPiketBulanan{
                self.getDataBelum(dataPiket: data)
                self.tableView?.reloadData()
            }
        }
    }
    
}

extension ListPiketHariIniViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.piket.count
     }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = .lightGray
            if section == 0 {
                label.text = "Belum Piket"
            }else if section == 1{
                label.text = "Sudah Piket"
            }else{
                label.text = "Belum Piket Bulanan"
            }
        return label
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cellJadwalPiket", for: indexPath) as! LisPiketTableViewCell
        
        let eachPiket = piket[indexPath.row]
        
        if indexPath.section == LoadDataPiket.PiketHariIni.rawValue{
            cell.backgroundColor = .green
        }else if indexPath.section == LoadDataPiket.SudahPiketHariIni.rawValue{
            cell.backgroundColor = .blue
        }else if indexPath.section == LoadDataPiket.BelumPiketBulanan.rawValue {
            cell.backgroundColor = .red
        }else{
            cell.backgroundColor = .white
        }
        
        cell.labelNama?.text = eachPiket.nama_anggota
        cell.labelJobPiket?.text = eachPiket.jenis_piket
        
        if(eachPiket.nim == nimAuth){
            print(defToken.string(forKey: "token") as Any)
            cell.buttonSelesaiPiket.setTitle(eachPiket.status, for: .normal)
            cell.buttonSelesaiPiket.isHidden = false
        }else{
            cell.buttonSelesaiPiket.isHidden = true
        }
      return cell
     }
}
