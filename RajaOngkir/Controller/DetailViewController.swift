//
//  DetailViewController.swift
//  RajaOngkir
//
//  Created by flow on 18/11/20.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
   
    
    var hargaAkhir2 = [Costs]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "reuseCell")
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController: UITableViewDataSource {
    // jumlah table berdasarkan array struct
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // berapa jumlah tablenya
            
        return hargaAkhir2[0].costs.count

    }
    // menampilkan cell nya sesuai array struct
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath) as? DetailTableViewCell {
            
                cell.namaKurir.text = String(hargaAkhir2[0].costs[indexPath.row].cost[0].value)
                cell.namaCode.text = hargaAkhir2[0].code.uppercased()
                cell.namaService.text = hargaAkhir2[0].costs[indexPath.row].service.uppercased()

                    
           
       
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
}
// user memilih table sesuai array dan berpindah ke detail view
//extension ViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detail = DetailViewController(nibName: "DetailViewController", bundle: nil)
//
//        detail.food = foods[indexPath.row]
//
//        self.navigationController?.pushViewController(detail, animated: true)
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//}
