//
//  ApiUrls.swift
//  Task
//
//

import Foundation

struct ApiUrls {
    let data = "\(ApiVersion().version)/data"
}

fileprivate struct ApiVersion {
    let version = "/api/v1"
}
