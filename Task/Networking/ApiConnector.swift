//
//  ApiConnector.swift
//  Task
//
//

import Foundation
import Alamofire

final class ApiConnector {
    class func request(url: String, method: HTTPMethod, parameters: [String: Any]?, requestResponse: @escaping ((Data?) -> Void), requestError: @escaping ((Error?) -> Void)) {
        AF.request(url, method: method, parameters: parameters).response { response in
            do {
                guard let data = response.data else {
                    throw response.error ?? AFError.sessionDeinitialized
                }
                requestResponse(data)
            } catch let error {
                print(error)
                requestError(error)
            }
        }
    }
}
