//
//  PullRequest.swift
//  GitHub Stars
//
//  Created by Wesley Gomes on 15/08/18.
//  Copyright © 2018 Wesley Gomes. All rights reserved.
//

import Foundation

struct PullRequest: Decodable {
    var id: Int
    var url: String
    var htmlUrl: String?
    var number: Int
    var state: String
    var title: String
    var user: Owner
    var body: String?
    var createdAt: Date
}
