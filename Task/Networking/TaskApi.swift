//
//  TaskApi.swift
//  Task
//
//  Created by Prograils on 05/03/2022.
//

import Foundation

final class TaskApi {
    private static let api = ApiConnector.self
}

//MARK: - Data handler
extension TaskApi {
    class func sendData(data: [String], shouldRefresh: @escaping ((Bool) -> Void)) {
        let url = BaseApiUrl().url + ApiUrls().data
        let parameters: [String: Any] = [
            "data": data
        ]
        
        api.request(url: url, method: .post, parameters: parameters) { responseData in
            shouldRefresh(true)
        } requestError: { responseError in
            shouldRefresh(false)
        }
    }
}
