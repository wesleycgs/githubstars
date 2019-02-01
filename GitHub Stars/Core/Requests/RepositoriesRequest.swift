//
//  RepositoriesRequest.swift
//  GitHub Stars
//
//  Created by Wesley Gomes on 16/08/18.
//  Copyright © 2018 Wesley Gomes. All rights reserved.
//

import Foundation
import Alamofire

class RepositoriesRequest: BaseRequest {

    enum URLs {
        static let all = "\(base)/search/repositories"
    }

    // MARK: - Requests

    static func get(_ page: Int, _ completion: @escaping defaultArrayCallback) {
        let url = URLs.all
        print("\nRequesting... \(url)")
        
        func failed(_ error: NSError? = nil) {
            completion(error ?? NSError(domain: "Ocorreu um erro", code: 400, userInfo: nil), nil)
        }

        let params = [
            "q" : "language:Swift",
            "sort" : "stars",
            "page" : page.description
        ]
        print("params: \(params)")

        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            print("response from \(response.request?.url as Any): \(response)")
            
            switch response.result {
            case .failure(let error):
                print("response failed: \(error)")
                failed(NSError(domain: error.localizedDescription, code: response.response?.statusCode ?? 400, userInfo: nil))
                break

            case .success(let JSON):
                //Get items array from json
                guard let JSONResult = JSON as? JSONDictionary, let JSONItems = JSONResult["items"] as? JSONArray else {
                    failed()
                    return
                }
                
                do {
                    //Convert items json to Data to decode it
                    let itemsData = try JSONSerialization.data(withJSONObject: JSONItems, options: JSONSerialization.WritingOptions.sortedKeys)
                    let repositories = try decoder.decode([Repository].self, from: itemsData)
                    completion(nil, repositories)
                } catch {
                    print("catch \(error)")
                    failed()
                }
                break
            }
        }
    }
}











