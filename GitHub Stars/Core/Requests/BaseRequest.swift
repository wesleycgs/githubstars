//
//  BaseRequest.swift
//  GitHub Stars
//
//  Created by Wesley Gomes on 16/08/18.
//  Copyright © 2018 Wesley Gomes. All rights reserved.
//

import Foundation
import Alamofire

typealias JSONDictionary = [String : Any]
typealias JSONArray = [[String : Any]]

class BaseRequest {

    static let base = "https://api.github.com"

    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
    
    typealias defaultArrayCallback = (_ error: NSError?, _ result: [Any]?) -> Void
    typealias defaultItemCallback = (_ error: NSError?, _ result: Any?) -> Void

    // MARK: - Utils

    static func cancelAllRequests() {
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach { $0.cancel() }
            uploadTasks.forEach { $0.cancel() }
            downloadTasks.forEach { $0.cancel() }
        }
    }
}
