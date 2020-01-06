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

class ListPiketHariIniViewController: UIViewController {
    
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    enum TableSection: Int {
        case belumPiketHarian = 0, sudahPiket, belumPiketBulanan
    }
    
    var data = [TableSection: [Piket]]()
    var networkManager = NetworkManager()
    var piket = [Piket]()
    
    
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var calendarWeekPiket: FSCalendar!{
        didSet{
            calendarWeekPiket.scope = .week
            calendarWeekPiket.appearance.headerMinimumDissolvedAlpha = 0.0
            calendarWeekPiket.allowsMultipleSelection = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataTable()
        
    }
    
    func getDataFromClosure(dataPiket: [Piket]){
        self.piket = dataPiket
    }
    
    public func loadDataTable(){
        networkManager.getListPiket(){(listPiket) in
            if let data = listPiket{
                self.getDataFromClosure(dataPiket: data)
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
        label.backgroundColor = .gray
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
         
        if indexPath.section == 0 && eachPiket.status == "Belum"{
            cell.backgroundColor = .green
        }else if indexPath.section == 1{
            cell.backgroundColor = .blue
        }else if indexPath.section == 2 {
            cell.backgroundColor = .red
        }else{
            cell.backgroundColor = .white
        }
        
        cell.labelNama?.text = eachPiket.nama_anggota
        cell.labelJobPiket?.text = eachPiket.jenis_piket
                
//        cell.buttonSelesaiPiket.setTitle(eachPiket.status, for: .normal)
         
      return cell
     }
}

extension ListPiketHariIniViewController: FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateString = formatter.string(from: date as Date)
        print(dateString)
    }
}

extension URL {
    func appendParameters( params: Parameters) -> URL? {
        var components = URLComponents(string: self.absoluteString)
        components?.queryItems = params.map { element in URLQueryItem(name: element.key, value: element.value as? String) }
        return components?.url
    }
}

