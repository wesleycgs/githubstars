//
//  Owner.swift
//  GitHub Stars
//
//  Created by Wesley Gomes on 15/08/18.
//  Copyright © 2018 Wesley Gomes. All rights reserved.
//

import Foundation

struct Owner: Decodable {
    var id: Int
    var login: String
    var avatarUrl: String?
    var htmlUrl: String?
}
