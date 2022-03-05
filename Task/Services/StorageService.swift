//
//  StorageService.swift
//  Task
//
//  Created by Prograils on 04/03/2022.
//

import CoreLocation

final class StorageService {
    private let cValue: Int
    private var array: [String] = []
    
    init(cValue: Int) {
        self.cValue = cValue
    }

    func storeLocation(_ location: String, shouldRefresh: @escaping ((Bool) -> Void)) {
        array.append(location)
        let count = array.count ?? 0
        shouldRefresh(count >= cValue)
    }
    
    func storeBattery(_ status: String, shouldRefresh: @escaping ((Bool) -> Void)) {
        array.append(status)
        
        let count = array.count ?? 0
        shouldRefresh(count >= cValue)
    }
    
    func getStorage() -> [String]? {
        return array
    }
    
    func removeStorage() {
        array.removeAll()
    }
}
