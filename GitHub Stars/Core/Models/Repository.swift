//
//  Repository.swift
//  GitHub Stars
//
//  Created by Wesley Gomes on 15/08/18.
//  Copyright © 2018 Wesley Gomes. All rights reserved.
//

import Foundation

struct Repository {
    var id: Int
    var name: String
    var fullName: String?
    var owner: Owner
    var isPrivate: Bool
    var htmlUrl: String?
    var description: String?
    var stargazersCount: Int
    var openIssuesCount: Int
    var forksCount: Int
}

extension Repository: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName
        case owner
        case isPrivate = "private"
        case htmlUrl
        case description
        case stargazersCount
        case openIssuesCount
        case forksCount = "forks"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let fullName = try container.decode(String?.self, forKey: .fullName)
        let owner = try container.decode(Owner.self, forKey: .owner)
        let isPrivate = try container.decode(Bool.self, forKey: .isPrivate)
        let htmlUrl = try container.decode(String?.self, forKey: .htmlUrl)
        let description = try container.decode(String?.self, forKey: .description)
        let stargazersCount = try container.decode(Int.self, forKey: .stargazersCount)
        let openIssuesCount = try container.decode(Int.self, forKey: .openIssuesCount)
        let forksCount = try container.decode(Int.self, forKey: .forksCount)
        
        self.init(id: id, name: name, fullName: fullName, owner: owner, isPrivate: isPrivate, htmlUrl: htmlUrl, description: description, stargazersCount: stargazersCount, openIssuesCount: openIssuesCount, forksCount: forksCount)
    }
}

