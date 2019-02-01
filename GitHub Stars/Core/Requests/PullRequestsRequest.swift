//
//  PullRequestsRequest.swift
//  GitHub Stars
//
//  Created by Wesley Gomes on 16/08/18.
//  Copyright © 2018 Wesley Gomes. All rights reserved.
//

import Foundation
import Alamofire

class PullRequestsRequest: BaseRequest {
    
    enum URLs {
        static func all(_ repository: Repository) -> String {
            return "\(base)/repos/\(repository.fullName)/pulls"
        }
    }
    
    // MARK: - Requests
    
    static func all(_ repository: Repository, _ completion: @escaping defaultArrayCallback) {
        let url = URLs.all(repository)
        print("\nRequesting... \(url)")
        
        func failed(_ error: NSError? = nil) {
            completion(error ?? NSError(domain: "Ocorreu um erro", code: 400, userInfo: nil), nil)
        }
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            print("response from \(response.request?.url as Any): \(response)")
            
            switch response.result {
            case .failure(let error):
                print("response failed: \(error)")
                failed(NSError(domain: error.localizedDescription, code: response.response?.statusCode ?? 400, userInfo: nil))
                break
                
            case .success:
                guard let data = response.data else {
                    failed()
                    return
                }
                
                do {
                    let pullRequests = try decoder.decode([PullRequest].self, from: data)
                    completion(nil, pullRequests)
                } catch {
                    print("catch \(error)")
                    failed()
                }
                break
            }   
        }
    }
}
