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
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var starsForksStackView: UIStackView!
    @IBOutlet weak var PRTitleLabel: UILabel!
    @IBOutlet weak var PRDateLabel: UILabel!    
    
    var repositoryViewModel: RepositoryViewModel? {
        didSet {
            guard let repo = repositoryViewModel else { return }
            ownerAvatarImageView.sd_setImage(with: repo.ownerViewModel.avatarUrl)
            fullNameLabel.attributedText = repo.fullNameAttributed
            descriptionLabel.text = repo.description
            starsLabel.text = repo.stargazers
            forksLabel.text = repo.forks
            starsForksStackView.isHidden = false
            PRTitleLabel.text = nil
            PRDateLabel.text = nil
        }
    }
    
    var pullRequestViewModel: PullRequestViewModel? {
        didSet {
            guard let pr = pullRequestViewModel else { return }
            ownerAvatarImageView.sd_setImage(with: pr.ownerViewModel.avatarUrl)
            fullNameLabel.text = pr.ownerViewModel.username
            descriptionLabel.text = pr.body
            starsLabel.text = nil
            forksLabel.text = nil
            starsForksStackView.isHidden = true
            PRTitleLabel.text = pr.title
            PRDateLabel.text = pr.createdAt
        }
    }
}
