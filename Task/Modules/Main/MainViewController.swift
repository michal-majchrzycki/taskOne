//
//  MainViewController.swift
//
//

import UIKit

protocol MainPresenterOutput: AnyObject {
    func enableStartButton(_ value: Bool)
    func showAlert(title: String)
}

class MainViewController: UIViewController {
    var interactor: MainInteractor?
    var router: MainRouter?
    var mainView: MainView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        
        mainView?.startButton.addTarget(self, action: #selector(onStartAction), for: .touchUpInside)
        mainView?.stopButton.addTarget(self, action: #selector(onStopAction), for: .touchUpInside)
        
        interactor?.viewDidLoad()
    }
    
}

//MARK: - Input
extension MainViewController: MainPresenterOutput {
    func enableStartButton(_ value: Bool) {
        mainView?.startButton.isEnabled = value
    }
    
    func showAlert(title: String) {
        mainView?.errorLabel.text = title
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.mainView?.errorLabel.text = nil
        }
    }
}

//MARK: - User Actions
extension MainViewController {
    @objc private func onStartAction() {
        interactor?.didTapStartButton()
    }
    
    @objc private func onStopAction() {
        interactor?.didTapStopButton()
    }
}
