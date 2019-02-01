//
//  OwnerViewModel.swift
//  GitHub Stars
//
//  Created by Wesley Gomes on 01/02/19.
//  Copyright © 2019 Wesley Gomes. All rights reserved.
//

import Foundation

struct OwnerViewModel {

    var owner: Owner
    var username: String
    var avatarUrl: URL?
    var htmlUrl: URL?

    init(_ owner: Owner) {
        self.owner = owner
        self.username = owner.login
        self.avatarUrl = URL(string: owner.avatarUrl.unwrapped)
        self.htmlUrl = URL(string: owner.htmlUrl.unwrapped)
    }
}
