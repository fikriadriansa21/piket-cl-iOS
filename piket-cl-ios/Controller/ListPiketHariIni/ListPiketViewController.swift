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


class ListPiketViewController: UIViewController {
    let defToken = UserDefaults.standard
    var nimAuth:String = ""
    var networkManager = NetworkManager()
    var piket = [Piket?]()
    var sudahPiket = [SudahPiket?]()
    var belumPiketBulanan = [BelumPiket?]()
    let image = UIImage(imageLiteralResourceName: "checklist.png")
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .black
        refreshControl.addTarget(self, action: #selector(loadDataPiket), for: .valueChanged)
        
        return refreshControl
    }()
    
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var calendarWeekPiket: FSCalendar!{
        didSet{
            calendarWeekPiket.scope = .week
            calendarWeekPiket.appearance.headerMinimumDissolvedAlpha = 0.0            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 10.0, *) {
            tableView?.refreshControl = refresher
        }else{
            tableView?.addSubview(refresher)
        }
        
        
        let timeDelay = DispatchTime.now() + .milliseconds(200)
        DispatchQueue.main.asyncAfter(deadline: timeDelay){
            self.refresher.endRefreshing()
            self.loadDataPiket()
        }
    }
    
    func getDataPiket(dataPiket: [Piket]){
        self.piket = dataPiket
    }
    
    func getDataSudah(dataPiket: [SudahPiket?]){
        self.sudahPiket = dataPiket
    }
    
    func getDataBelum(dataPiket: [BelumPiket]){
        self.belumPiketBulanan = dataPiket
    }
    
    @objc
    private func loadDataPiket(){
        
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
        
        refresher.endRefreshing()
    }
    

}

extension ListPiketViewController: UITableViewDataSource, UITableViewDelegate{
    
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
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellHariIni", for: indexPath) as! ListHariIniTableViewCell
            
            if(piket[indexPath.row]?.status == "Sudah"){
                cell.isHidden = true
            }else if(piket[indexPath.row]?.status == "Belum"){
                cell.isHidden = false
            }

            if(piket[indexPath.row]?.nim == nimAuth){
                cell.buttonSelesaiPiket.isHidden = false
                cell.actionBlock = {
                    self.networkManager.permohonanSelesaiPiket(id: (self.piket[indexPath.row]?.id)!){(response) in
                        tableView.beginUpdates()
                        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
                        tableView.endUpdates()
                    }
                }
            }else{
                cell.buttonSelesaiPiket.isHidden = true
            }
                        
            cell.labelNama?.text = piket[indexPath.row]?.nama_anggota
            cell.labelJobPiket?.text = piket[indexPath.row]?.jenis_piket
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellSudahPiket", for: indexPath) as! ListSudahPiketTableViewCell
            
                if sudahPiket[indexPath.row]?.diperiksa_oleh != nil {
                    cell.buttonKonfirmasi.setImage(self.image, for: .normal)
                    cell.buttonKonfirmasi.backgroundColor = .white
                    cell.buttonKonfirmasi.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
                    cell.buttonKonfirmasi.isEnabled = false
                }
                if(sudahPiket[indexPath.row]?.nim == nimAuth){
                    cell.buttonKonfirmasi.isHidden = true
               }else{
                    cell.buttonKonfirmasi.isHidden = false
                    cell.actionKonfirmasi = {
                        self.networkManager.konfirmasiPiket(id: (self.sudahPiket[indexPath.row]?.id)!){(response) in
                            cell.buttonKonfirmasi.setImage(self.image, for: .normal)
                            cell.buttonKonfirmasi.backgroundColor = .white
                            cell.buttonKonfirmasi.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
                        }
                    }
               }

            cell.labelNama?.text = sudahPiket[indexPath.row]?.nama_anggota
            cell.labelJenisPiket?.text = sudahPiket[indexPath.row]?.jenis_piket
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellBelum", for: indexPath) as! ListBelumPiketTableViewCell

            cell.labelNama?.text = belumPiketBulanan[indexPath.row]?.nama_anggota
            cell.labelJenisPiket?.text = belumPiketBulanan[indexPath.row]?.jenis_piket
            return cell
        }
    }
}
