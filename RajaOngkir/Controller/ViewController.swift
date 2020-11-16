//
//  ViewController.swift
//  RajaOngkir
//
//  Created by flow on 14/11/20.
//

import UIKit
import DropDown
class ViewController: UIViewController , UITextFieldDelegate {
    
    
    let provinsiAsal = DropDown()
    let provinsiTujuan = DropDown()
    let kotaAsal = DropDown()
    let kotaTujuan = DropDown()
    
    let kurir = DropDown()
    
    var ongkirManager = OngkirManager()
    
    var provinceId = [String]()
    var selectedProvince = ""
    var provinceIdDestination = [String]()
    var selectedProvinceDestination = ""
    var gram = ""
    
    
    @IBOutlet weak var labelAsal: UILabel!
    @IBOutlet weak var labelTujuan: UILabel!
    
    
    @IBOutlet weak var pilihProvinsi: UIButton!
    @IBOutlet weak var pilihKota: UIButton!
    
    
    @IBOutlet weak var pilihProvinsiTujuan: UIButton!
    @IBOutlet weak var pilihKotaTujuan: UIButton!
    
    
    @IBOutlet weak var inputBerat: UITextField!
    @IBOutlet weak var pilihKurir: UIButton!
    
    @IBOutlet weak var cekOngkosKirim: UIButton!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        provinsiAsal.anchorView = pilihProvinsi
        kotaAsal.anchorView = pilihKota
        provinsiTujuan.anchorView = pilihProvinsiTujuan
        provinsiTujuan.direction = .bottom
        kotaTujuan.anchorView = pilihKotaTujuan
        kotaTujuan.direction = .bottom
        kurir.anchorView = pilihKurir
        
        inputBerat.delegate = self
        
        
        ongkirManager.delegate = self
        ongkirManager.fetch()
        
        
        
        
        
    }
    
    @IBAction func pilihProvinsiPressed(_ sender: Any)  {
        provinsiAsal.show()
        provinsiAsal.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            pilihProvinsi.setTitle(item, for: .normal)
            
            selectedProvince = provinceId[index]
            DispatchQueue.main.async {
                self.ongkirManager.fetchCity(provinceId: selectedProvince)
            }
            
        }
        
        
    }
    
    
    @IBAction func pilihKotaPressed(_ sender: Any) {
        kotaAsal.show()
        kotaAsal.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            pilihKota.setTitle(item, for: .normal)
            
        }
        
        
    }
    
    
    
    @IBAction func pilihProvinsiTujuanPressed(_ sender: Any) {
        provinsiTujuan.show()
        provinsiTujuan.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            pilihProvinsiTujuan.setTitle(item, for: .normal)
            
            selectedProvinceDestination = provinceIdDestination[index]
            DispatchQueue.main.async {
                self.ongkirManager.fetchCityDestination(provinceIdDestination: selectedProvinceDestination)
                
            }
            
        }
    }
    
    
    
    @IBAction func pilihKotaTujuanPressed(_ sender: Any) {
        kotaTujuan.show()
        kotaTujuan.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            pilihKotaTujuan.setTitle(item, for: .normal)
            
        }
    }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {  // << no 10.
        self.inputBerat.endEditing(true)
        print(self.inputBerat.text!)
        self.gram = self.inputBerat.text!
        return true
    }
    
    
    
    
    
    
    
    @IBAction func pilihKurirPressed(_ sender: Any) {
        
        kurir.show()
        kurir.dataSource = ["JNE", "TIKI" , "POS"]
        kurir.selectionAction = {  (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.pilihKurir.setTitle(item, for: .normal)

            
            
        }
        
    }
    
    
}


extension ViewController: OngkirManagerDelegate {
    
    func updateProvince(ongkir: [Province]) {
        provinsiAsal.dataSource.removeAll()
        DispatchQueue.main.async {
            ongkir.forEach { (Province) in
                self.provinsiAsal.dataSource.append(Province.province)
                self.provinsiTujuan.dataSource.append(Province.province)
                
                self.provinceId.append(Province.province_id)
                self.provinceIdDestination.append(Province.province_id)
                
                
            }
            
            
        }
        
    }
    
    func updateCity(ongkir: [Province2]) {
        kotaAsal.dataSource.removeAll()
        DispatchQueue.main.async {
            ongkir.forEach { (Province) in
                self.kotaAsal.dataSource.append(Province.city_name)
            }
        }
    }
    
    func updateCityDestination(ongkir: [Province2]) {
        kotaTujuan.dataSource.removeAll()
        DispatchQueue.main.async {
            ongkir.forEach { (Province) in
                self.kotaTujuan.dataSource.append(Province.city_name)
                
            }
        }
    }
    
    
}

