//
//  OngkirManager.swift
//  RajaOngkir
//
//  Created by flow on 16/11/20.
//

import Foundation
import UIKit

protocol OngkirManagerDelegate {
    func updateProvince (ongkir: [Province])
    func updateCity (ongkir: [Province2])
    func updateCityDestination (ongkir: [Province2])

    
}

struct OngkirManager {
    //    var provinsiAwalArray = [String]()
    var delegate: OngkirManagerDelegate?
    
    
    func fetch() {
        
       
        let headers = ["key": "e1a4a8209e2197008e00a582acac7485"]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.rajaongkir.com/starter/province")! as URL,
                                          cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print("asd\(error!)")
            }; if let safeData = data {
                if let provinsi = parseJson(provinceData: safeData) {
                    
                    delegate?.updateProvince(ongkir: provinsi)
                    
                    
                }
            }
            
        })
        
        dataTask.resume()
        
    }
    
    func parseJson(provinceData: Data) -> [Province]?  {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(Ongkir.self, from: provinceData)
            let provinsi = decodedData.rajaongkir.results
            
            return provinsi
        }
        catch {
            print(error)
        }
        return nil
    }
    
    func fetchCity(provinceId: String) {
        
        
        let headers = ["key": "e1a4a8209e2197008e00a582acac7485"]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.rajaongkir.com/starter/city?&province=\(provinceId)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print("asd\(error!)")
            }; if let safeData = data {
                if let city = self.parseJsonCity(cityData: safeData) {
                    
                    
                    delegate?.updateCity(ongkir: city)
                    
                    
                }
            }
            
            
        })
        
        dataTask.resume()
        
    }
    
    func parseJsonCity(cityData: Data) -> [Province2]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(City.self, from: cityData)
            let city = decodedData.rajaongkir.results
            
            return city
        }
        catch {
            print("\(error)")
        }
        return nil
    }
    
    func fetchCityDestination(provinceIdDestination: String) {
        
        
        let headers = ["key": "e1a4a8209e2197008e00a582acac7485"]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.rajaongkir.com/starter/city?&province=\(provinceIdDestination)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print("asd\(error!)")
            }; if let safeData = data {
                if let city = self.parseJsonCity(cityData: safeData) {
                    
                    
                    delegate?.updateCityDestination(ongkir: city)
                    
                    
                }
            }
            
            
        })
        
        dataTask.resume()
        
    }
    
    func parseJsonCityDestination(cityData: Data) -> [Province2]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(City.self, from: cityData)
            let city = decodedData.rajaongkir.results
            
            return city
        }
        catch {
            print("\(error)")
        }
        return nil
    }
    
    
    
    
    
}
