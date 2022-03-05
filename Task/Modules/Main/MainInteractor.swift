//
//  MainInteractor.swift
//
//

import Foundation

protocol MainInteractor: AnyObject {
    func viewDidLoad()
    func didTapStartButton()
    func didTapStopButton()
}

class MainInteractorImplementation: MainInteractor {
    var presenter: MainPresenter?
    private var locationService = LocationService.shared
    private var storageService: StorageService?
    private var firstTimer = Timer()
    private var secondTimer = Timer()
    
    private enum Constants {
        static let aValue: Double = 2
        static let bValue: Double = 3
        static let cValue = 10
    }
    
    func viewDidLoad() {
        storageService = StorageService(cValue: Constants.cValue)
    }
    
    //MARK: - User Actions handling
    func didTapStartButton() {
        presenter?.enableStartButton(false)
        
        DispatchQueue.main.async {
            self.startThreadOne()
            self.startThreadTwo()
        }
    }
    
    func didTapStopButton() {
        presenter?.enableStartButton(true)
        stopThreadOne()
        stopThreadTwo()
        stopThreadThree()
    }
}

//MARK: - Thread One handling
extension MainInteractorImplementation {
    private func startThreadOne() {
        locationService.startUpdatingLocation()
        
        firstTimer = Timer.scheduledTimer(timeInterval: Constants.aValue, target: self, selector: #selector(getUserLocation), userInfo: nil, repeats: true)
    }
    
    @objc private func getUserLocation() {
        guard let latitude = locationService.currentLocation?.latitude else { return }
        guard let longitude = locationService.currentLocation?.longitude else { return }
        
        let localizationString = latitude.description + " " + longitude.description
        storeLocation(localizationString)
    }
    
    private func stopThreadOne() {
        firstTimer.invalidate()
    }
}

//MARK: - Thread Two handling
extension MainInteractorImplementation {
    private func startThreadTwo() {
        secondTimer = Timer.scheduledTimer(timeInterval: Constants.bValue, target: self, selector: #selector(getDeviceBattery), userInfo: nil, repeats: true)
    }
    
    @objc private func getDeviceBattery() {
        let batteryService = BatteryService()
        let batteryString =  String(describing: batteryService.getBatteryLevel())
        storeBattery(batteryString)
    }
    
    private func stopThreadTwo() {
        secondTimer.invalidate()
    }
}

//MARK: - Thread Three handling
extension MainInteractorImplementation {
    private func storeBattery(_ battery: String) {
        storageService?.storeBattery(battery, shouldRefresh: { [weak self] refresh in
            if refresh {
                self?.sendDataToApi()
            }
        })
    }
    
    private func storeLocation(_ location: String) {
        storageService?.storeLocation(location, shouldRefresh: { [weak self] refresh in
            if refresh {
                self?.sendDataToApi()
            }
        })
    }
    
    private func stopThreadThree() {
        storageService?.removeStorage()
    }
}

//MARK: - API handler
extension MainInteractorImplementation {
    private func sendDataToApi() {
        guard let data = storageService?.getStorage() else { return }
        
        TaskApi.sendData(data: data) { [weak self] refresh in
            refresh ? self?.stopThreadThree() : self?.presenter?.showApiError()
        }
    }
}
