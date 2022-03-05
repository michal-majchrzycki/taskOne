//
//  MainPresenter.swift
//
//

import Foundation

protocol MainPresenter: AnyObject {
    func enableStartButton(_ value: Bool)
    func showApiError()
}

class MainPresenterImplementation: MainPresenter {
    weak var viewController: MainPresenterOutput?
    

    func enableStartButton(_ value: Bool) {
        viewController?.enableStartButton(value)
    }
    
    func showApiError() {
        let error = "MainModule.api.error.text".localized
        #warning("Localization not yet implemented!")
        viewController?.showAlert(title: error)
    }
}
