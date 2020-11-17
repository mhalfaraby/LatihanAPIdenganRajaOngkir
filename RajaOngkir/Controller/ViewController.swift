//
//  ViewController.swift
//  RajaOngkir
//
//  Created by flow on 14/11/20.
//

import UIKit
import DropDown
import Keyboardy
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
    var value = [String]()
    
    var origin = [Province2]()
    var destination = [Province2]()


    var originSelected = ""
    var destinationSelected = ""
    var gram = ""
    var kurirSelected = ""
    
    
    
    @IBOutlet weak var labelAsal: UILabel!
    @IBOutlet weak var labelTujuan: UILabel!
    
    
    @IBOutlet weak var pilihProvinsi: UIButton!
    @IBOutlet weak var pilihKota: UIButton!
    
    
    @IBOutlet weak var pilihProvinsiTujuan: UIButton!
    @IBOutlet weak var pilihKotaTujuan: UIButton!
    
    
    @IBOutlet weak var inputBerat: UITextField!
    @IBOutlet weak var pilihKurir: UIButton!
    
    @IBOutlet weak var cekOngkosKirim: UIButton!
    
    
    
    
    @IBOutlet weak var keyboard: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        provinsiAsal.anchorView = pilihProvinsi
        kotaAsal.anchorView = pilihKota
        provinsiTujuan.anchorView = pilihProvinsiTujuan
        provinsiTujuan.direction = .bottom
        kotaTujuan.anchorView = pilihKotaTujuan
        kotaTujuan.direction = .bottom
        kurir.anchorView = pilihKurir
        kurir.dataSource = ongkirManager.dataKurir
        inputBerat.delegate = self
        
        
        ongkirManager.delegate = self
        ongkirManager.fetch()
        
        
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        registerForKeyboardNotifications(self)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        unregisterFromKeyboardNotifications()
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
            
            originSelected = origin[index].city_id
            
            print(originSelected)
            
            
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
            destinationSelected = destination[index].city_id
            
            print(destinationSelected)
        }
    }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {  // << no 10.
        self.inputBerat.endEditing(true)
        print(self.inputBerat.text!)
        self.gram = self.inputBerat.text!
        
        print(gram)
        return true
    }
    
/*
     gue mau ngapain coba
     
     mau simpan value
     
     origin: String, destination: String , weight: String ,courier: String
     
     ketika button cekongkoskirim di pencet maka
     */
    
    
    
    
    
    @IBAction func pilihKurirPressed(_ sender: Any) {
        
        kurir.show()
        
        kurir.selectionAction = {  (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.pilihKurir.setTitle(item, for: .normal)
            self.kurirSelected = item
            
            print(self.kurirSelected)
            
            
        }
        
    }
    
    @IBAction func cekOngkosKirimPressed(_ sender: Any) {
  print(originSelected)
        print(destinationSelected)
        print(gram)
        print(kurirSelected)
        ongkirManager.fetchCost(origin: originSelected, destination: destinationSelected, weight: gram, courier: kurirSelected)
    }
    
}


extension ViewController: OngkirManagerDelegate {
    func updateCost(harga: [Costs]) {
        print(harga[0])
    }
    
   
  
    
    
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
        
        origin.append(contentsOf: ongkir)
    }
    
    func updateCityDestination(ongkir: [Province2]) {
        kotaTujuan.dataSource.removeAll()
        DispatchQueue.main.async {
            ongkir.forEach { (Province) in
                self.kotaTujuan.dataSource.append(Province.city_name)
                
            }
        }
        
        destination.append(contentsOf: ongkir)
    }
    
  
    
    
    
    
    
}
extension ViewController: KeyboardStateDelegate {

    func keyboardWillTransition(_ state: KeyboardState) {
        // keyboard will show or hide
    }

    func keyboardTransitionAnimation(_ state: KeyboardState) {
        switch state {
        case .activeWithHeight(let height):
            keyboard.constant = height
        case .hidden:
            keyboard.constant = 0.0
        }

        view.layoutIfNeeded()
    }

    func keyboardDidTransition(_ state: KeyboardState) {
        // keyboard animation finished
    }
}



