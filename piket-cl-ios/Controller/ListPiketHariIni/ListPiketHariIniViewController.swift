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
    var piket = [Piket]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataTable()
        self.tableView?.reloadData()
    }
    
    func getDataFromClosure(dataPiket: [Piket]?){
        self.piket = dataPiket!
    }
    
    public func loadDataTable(){
        networkManager.getListPiket(){(listPiket) in
            if let data = listPiket{
                self.getDataFromClosure(dataPiket: data)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.piket.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "cellJadwalPiket", for: indexPath) as! LisPiketTableViewCell
        
        let eachPiket = piket[indexPath.row]
        cell.labelNama?.text = eachPiket.nama_anggota
        cell.labelJobPiket?.text = eachPiket.jenis_piket
        cell.buttonSelesaiPiket.titleLabel?.text = eachPiket.status
     return cell
    }
   

}
