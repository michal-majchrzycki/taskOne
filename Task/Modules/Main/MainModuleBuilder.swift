//
//  MainModuleBuilder.swift
//
//

import UIKit

class MainModuleBuilder {
    func build() -> MainViewController {
        let viewController = MainViewController()
        let view = MainView()
        let router = MainRouterImplementation()
        let presenter = MainPresenterImplementation()
        let interactor = MainInteractorImplementation()
        
        viewController.router = router
        viewController.interactor = interactor
        viewController.mainView = view
        
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.handler = viewController
        
        return viewController
    }
}
