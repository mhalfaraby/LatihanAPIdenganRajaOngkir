//
//  Ongkir.swift
//  RajaOngkir
//
//  Created by flow on 16/11/20.
//

import Foundation




struct Ongkir: Decodable {
    let rajaongkir: Result
}

struct Result: Decodable {
    let results: [Province]
}

struct Province: Decodable {
    let province_id: String
    let province: String
}

struct City: Decodable {
    let rajaongkir: Result2
}

struct Result2: Decodable {
    let results: [Province2]
}

struct Province2: Decodable {
    let city_name: String
    let city_id: String
}

struct Harga: Decodable {
    let rajaongkir: Result3
}

struct Result3: Decodable {
    let results: [Costs]
}

struct Costs: Decodable {
    let code: String
    let name: String
    let costs: [Cost]
}

struct Cost: Decodable {
    let service: String
    let description: String
    let cost: [Value]
}

struct Value: Decodable {
    let value: Int
    let etd: String
    let note: String
}


