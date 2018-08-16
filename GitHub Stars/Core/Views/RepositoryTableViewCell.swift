//
//  RepositoryTableViewCell.swift
//  GitHub Stars
//
//  Created by Wesley Gomes on 15/08/18.
//  Copyright © 2018 Wesley Gomes. All rights reserved.
//

import UIKit
import SDWebImage

class RepositoryTableViewCell: UITableViewCell {
    static let reuseIdentifier = String(describing: RepositoryTableViewCell.self)
    static let nib = UINib(nibName: String(describing: RepositoryTableViewCell.self), bundle: nil)
    
    // MARK: - Outlets
    
    @IBOutlet weak var ownerAvatarImageView: UIImageView!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var repoLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var starsForksStackView: UIStackView!
    @IBOutlet weak var PRTitleLabel: UILabel!
    @IBOutlet weak var PRDateLabel: UILabel!    
    
    var repository: Repository? {
        didSet {
            guard let repository = repository else { return }
            ownerAvatarImageView.sd_setImage(with: URL(string: repository.owner.avatarUrl.unwrapped))
            ownerLabel.text = "\(repository.owner.login) /"
            repoLabel.text = repository.name
            descriptionLabel.text = repository.description
            starsLabel.text = repository.stargazersCount.description
            forksLabel.text = repository.forksCount.description
            starsForksStackView.isHidden = false
            PRTitleLabel.text = nil
            PRDateLabel.text = nil
        }
    }
    
    var pullRequest: PullRequest? {
        didSet {
            guard let pullRequest = pullRequest else { return }
            ownerAvatarImageView.sd_setImage(with: URL(string: pullRequest.user.avatarUrl.unwrapped))
            ownerLabel.text = pullRequest.user.login
            repoLabel.text = nil
            descriptionLabel.text = pullRequest.body//pullRequest HTML
            starsLabel.text = nil
            forksLabel.text = nil
            starsForksStackView.isHidden = true
            PRTitleLabel.text = pullRequest.title
            PRDateLabel.text = "Aberto em \(DateUtils.string(from: pullRequest.createdAt, formatter: .brDateExtensive))"
        }
    }
}
