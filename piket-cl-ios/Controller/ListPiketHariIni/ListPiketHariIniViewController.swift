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
    var sudahPiket = [SudahPiket?]()
    var belumPiketBulanan = [BelumPiket]()

    var itemPiket = [[Any]]()
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
        
        itemPiket = [
            [piket],
            [sudahPiket],
            [belumPiketBulanan]
        ]
    }
    
    func getDataPiket(dataPiket: [Piket]){
        self.piket = dataPiket
        print(self.piket)
    }
    
    func getDataSudah(dataPiket: [SudahPiket?]){
        self.sudahPiket = dataPiket
        print(self.sudahPiket)
    }
    
    func getDataBelum(dataPiket: [BelumPiket]){
        self.belumPiketBulanan = dataPiket
        print(self.belumPiketBulanan)
    }
    
    public func loadDataPiket(){
        networkManager.getListPiket(){(listPiket) in
            if let dataHariIni = listPiket{
                self.getDataPiket(dataPiket: dataHariIni)
                self.tableView?.reloadData()
            }
        }
        
        networkManager.getSudahPiketHariIni{(listSudahPiket) in
            if let dataSudah = listSudahPiket{
                self.getDataSudah(dataPiket: dataSudah)
                self.tableView?.reloadData()
            }
        }
        
        networkManager.getBelumPiketBulanan{(belumPiketBulanan) in
            if let dataBelum = belumPiketBulanan{
                self.getDataBelum(dataPiket: dataBelum)
                self.tableView?.reloadData()
            }
        }
    }
    
}

extension ListPiketHariIniViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return self.piket.count
        }else if section == 1 {
            return self.sudahPiket.count
        }else if section == 2 {
            return self.belumPiketBulanan.count
        }else{
            return 0
        }
        
     }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Piket Hari Ini"
        case 1: return "Sudah Piket"
        case 2: return "Belum Piket Bulan Ini"
        default: return nil
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cellJadwalPiket", for: indexPath) as! LisPiketTableViewCell
        
        let piketData = piket[indexPath.row]
        let sudah = sudahPiket[indexPath.row]
        let belum = belumPiketBulanan[indexPath.row]

        if(piketData.nim == nimAuth){
            print(defToken.string(forKey: "token") as Any)
            cell.buttonSelesaiPiket.setTitle(piketData.status, for: .normal)
            cell.buttonSelesaiPiket.isHidden = false
        }else{
            cell.buttonSelesaiPiket.isHidden = true
        }
        
        if indexPath.section == 0{
            cell.backgroundColor = .green
            cell.labelNama?.text = piketData.nama_anggota
            cell.labelJobPiket?.text = piketData.jenis_piket
        }else if indexPath.section == 1{
            cell.backgroundColor = .blue
            cell.labelNama?.text = sudah?.nama_anggota
            cell.labelJobPiket?.text = sudah?.jenis_piket
        }else if indexPath.section == 2{
            cell.backgroundColor = .red
            cell.labelNama?.text = belum.nama_anggota
            cell.labelJobPiket?.text = belum.jenis_piket
        }else{
            cell.backgroundColor = .white
        }
                    
      return cell
     }
}

extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
