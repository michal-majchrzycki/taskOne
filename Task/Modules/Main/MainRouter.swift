//
//  MainRouter.swift
//
//

import UIKit

protocol MainRouter: AnyObject {
    var handler: MainViewController? { get set }
}

class MainRouterImplementation: MainRouter {
    weak var handler: MainViewController?
}
