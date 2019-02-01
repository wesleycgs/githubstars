//
//  PullRequestViewModel.swift
//  GitHub Stars
//
//  Created by Wesley Gomes on 01/02/19.
//  Copyright © 2019 Wesley Gomes. All rights reserved.
//

import Foundation

struct PullRequestViewModel {
    
    var pullRequest: PullRequest
    var url: URL?
    var htmlUrl: URL?
    var number: String
    var state: String
    var title: String
    var ownerViewModel: OwnerViewModel
    var body: String?
    var createdAt: String?
    
    init(_ pullRequest: PullRequest) {
        self.pullRequest = pullRequest
        self.url = URL(string: pullRequest.url.unwrapped)
        self.htmlUrl = URL(string: pullRequest.htmlUrl.unwrapped)
        self.number = pullRequest.number.description
        self.state = pullRequest.state
        self.title = pullRequest.title
        self.ownerViewModel = OwnerViewModel(pullRequest.user)
        self.body = pullRequest.body
        if let date = pullRequest.createdAt {
            self.createdAt = "Aberto em \(DateUtils.string(from: date, formatter: .brDateExtensive))"
        }
    }
}
