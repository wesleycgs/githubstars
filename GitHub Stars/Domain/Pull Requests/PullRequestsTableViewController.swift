//
//  PullRequestsTableViewController.swift
//  GitHub Stars
//
//  Created by Wesley Gomes on 16/08/18.
//  Copyright © 2018 Wesley Gomes. All rights reserved.
//

import UIKit
import SafariServices

class PullRequestsTableViewController: UITableViewController {

    // MARK: - Outlets
    
    //Send by segue
    var repository: Repository!
    
    var pullRequests: [PullRequest] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.prompt = repository.fullName
        tableView.tableFooterView = UIView()
        registerCells()
        getPullRequests()
        
        //Force tource
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: tableView)
        }
    }
    
    func registerCells() {
        tableView.register(RepositoryTableViewCell.nib, forCellReuseIdentifier: RepositoryTableViewCell.reuseIdentifier)
    }
    
    // MARK: - Requests
    
    func getPullRequests() {
        ProgressUtils.show()
        PullRequestsRequest.all(repository) { (error, pullRequests) in
            ProgressUtils.dismiss()
            
            if let error = error {
                ProgressUtils.error(error.domain)
            }
            
            if let pullRequests = pullRequests as? [PullRequest] {
                self.pullRequests = pullRequests
            }
        }
    }
}

// MARK: - Table view data source

extension PullRequestsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pullRequests.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.reuseIdentifier) as! RepositoryTableViewCell
        let pr = pullRequests[indexPath.row]
        cell.pullRequestViewModel = PullRequestViewModel(pr)
        return cell
    }
}

// MARK: - Table view delegate

extension PullRequestsTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let pr = pullRequests[indexPath.row]
        guard let url = URL(string: pr.htmlUrl.unwrapped) else { return }
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.modalPresentationStyle = .currentContext
        safariViewController.modalTransitionStyle = .coverVertical
        present(safariViewController)
    }
}

// MARK: - View controller previewing delegate

extension PullRequestsTableViewController: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = tableView.indexPathForRow(at: location) else { return nil }
        guard let cell = tableView.cellForRow(at: indexPath) as? RepositoryTableViewCell else { return nil }
        
        previewingContext.sourceRect = cell.frame
        let pr = pullRequests[indexPath.row]
        
        guard let url = URL(string: pr.htmlUrl.unwrapped) else { return nil }
        let viewController = SFSafariViewController(url: url)
        viewController.preferredContentSize = CGSize.zero
        
        return viewController
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        present(viewControllerToCommit)
    }
}



