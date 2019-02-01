//
//  RepositoryViewModel.swift
//  GitHub Stars
//
//  Created by Wesley Gomes on 01/02/19.
//  Copyright © 2019 Wesley Gomes. All rights reserved.
//

import UIKit

struct RepositoryViewModel {
    
    var repository: Repository
//    var ownerViewModel: OwnerViewModel
    
    var name: String
    var fullName: String
    var fullNameAttributed = NSMutableAttributedString()
    var htmlUrl: String?
    var description: String?
    var stargazers: String
    var openIssues: String
    var forks: String
    
    init(_ repo: Repository) {
        self.repository = repo
//        self.ownerViewModel = OwnerViewModel(repo.owner)
        self.name = repo.name
        self.fullName = repo.fullName
        self.htmlUrl = repo.htmlUrl
        self.description = repo.description
        self.stargazers = repo.stargazersCount.description
        self.openIssues = repo.openIssuesCount.description
        self.forks = repo.forksCount.description
        self.fullNameAttributed.normal("\(repo.owner.login)/").bold(repo.name)
    }
    
    
    
    
}
