//
//  BatteryService.swift
//  Task
//
//  Created by Prograils on 04/03/2022.
//

import UIKit

final class BatteryService {
    func getBatteryLevel() -> Float {
        return UIDevice.current.batteryLevel
    }
}
