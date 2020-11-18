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
    
    var provinceId = [Province]()
    var selectedProvince = ""
    var provinceIdDestination = [Province]()
    var selectedProvinceDestination = ""
    var value = [String]()
    
    var origin = [Province2]()
    var destination = [Province2]()
    
    
    var originSelected = ""
    var destinationSelected = ""
    var gram = ""
    var kurirSelected = ""
    
    var hargaAkhir = [Costs]()
    
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
            pilihProvinsi.setTitle(item, for: .normal)
            
            selectedProvince = provinceId[index].province_id
            DispatchQueue.main.async {
                self.ongkirManager.fetchCity(provinceId: selectedProvince)
            }
            
        }
        
        
    }
    
    
    @IBAction func pilihKotaPressed(_ sender: Any) {
        kotaAsal.show()
        kotaAsal.selectionAction = { [unowned self] (index: Int, item: String) in
            pilihKota.setTitle(item, for: .normal)
            
            originSelected = origin[index].city_id
            
            
            
        }
        
        
    }

    @IBAction func pilihProvinsiTujuanPressed(_ sender: Any) {
        provinsiTujuan.show()
        provinsiTujuan.selectionAction = { [unowned self] (index: Int, item: String) in
            pilihProvinsiTujuan.setTitle(item, for: .normal)
            
            selectedProvinceDestination = provinceIdDestination[index].province_id
            DispatchQueue.main.async {
                self.ongkirManager.fetchCityDestination(provinceIdDestination: selectedProvinceDestination)
                
            }
            
        }
    }
    
    
    
    @IBAction func pilihKotaTujuanPressed(_ sender: Any) {
        kotaTujuan.show()
        kotaTujuan.selectionAction = { [unowned self] (index: Int, item: String) in
            pilihKotaTujuan.setTitle(item, for: .normal)
            destinationSelected = destination[index].city_id
            
        }
    }
 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {  // << no 10.
        self.inputBerat.endEditing(true)
        self.gram = self.inputBerat.text!
        
        return true
    }

    @IBAction func pilihKurirPressed(_ sender: Any) {
        
        kurir.show()
        
        kurir.selectionAction = {  (index: Int, item: String) in
            self.pilihKurir.setTitle(item, for: .normal)
            self.kurirSelected = item
            
            
            
        }
        
    }

    
    @IBAction func cekOngkosKirimPressed(_ sender: Any) {
        print(originSelected)
        print(destinationSelected)
        print(gram)
        print(kurirSelected)
       
      
        ongkirManager.fetchCost(origin: originSelected, destination: destinationSelected, weight: self.gram, courier: self.kurirSelected)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { // Change `2.0` to the desired number of seconds.
           // Code you want to be delayed
            self.performSegue(withIdentifier: "goToDetail", sender: self)

        }
      

    }
    
       

    
    
  
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail" {
            
            let destinationVC = segue.destination as! DetailViewController


                destinationVC.hargaAkhir2 = hargaAkhir
            
        }
    }
    
}


extension ViewController: OngkirManagerDelegate {
    func updateCost(harga: [Costs]) {
        print(harga[0])
        hargaAkhir.removeAll()
        hargaAkhir.append(contentsOf: harga)
    }

    func updateProvince(ongkir: [Province]) {
        provinsiAsal.dataSource.removeAll()
        DispatchQueue.main.async {
            ongkir.forEach { (Province) in
                self.provinsiAsal.dataSource.append(Province.province)
                self.provinsiTujuan.dataSource.append(Province.province)
       
            }
            
            
        }
        self.provinceId.append(contentsOf: ongkir)
        self.provinceIdDestination.append(contentsOf: ongkir)
        
    }
    
    func updateCity(ongkir: [Province2]) {
        kotaAsal.dataSource.removeAll()
        origin.removeAll()
        DispatchQueue.main.async {
            ongkir.forEach { (Province) in
                self.kotaAsal.dataSource.append(Province.city_name)
                
            }
        }
        
        origin.append(contentsOf: ongkir)
    }
    
    func updateCityDestination(ongkir: [Province2]) {
        kotaTujuan.dataSource.removeAll()
        destination.removeAll()
        
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



