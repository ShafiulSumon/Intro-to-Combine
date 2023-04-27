//
//  NetworkManager.swift
//  Intro-to-combine
//
//  Created by ShafiulAlam-00058 on 4/11/23.
//

import Foundation
import Combine

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchData() -> Future<[String], Error> {
        return Future { promixe in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                promixe(.success(["Apple", "Samsung", "Google", "Facebook"]))
            }
        }
    }
}
