//
//  RepositoriesTableViewController.swift
//  GitHub Stars
//
//  Created by Wesley Gomes on 15/08/18.
//  Copyright © 2018 Wesley Gomes. All rights reserved.
//

import UIKit

class RepositoriesTableViewController: UITableViewController {

    // MARK: - Outlets
    
    var repositories: [Repository] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    //Pagination settings
    var page = 1
    var isGettingMore = false
    var canGetMore = false {
        didSet {
            tableView.tableFooterView?.h = canGetMore ? 44 : 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initRefreshControl()
        registerCells()
        getRepositories()
    }
    
    func registerCells() {
        tableView.register(RepositoryTableViewCell.nib, forCellReuseIdentifier: RepositoryTableViewCell.reuseIdentifier)
    }
    
    // MARK: - Requests
    
    func getRepositories() {
        if refreshControl?.isRefreshing == false, isGettingMore == false {
            ProgressUtils.show()
        }
        
        RepositoriesRequest.get(page) { (error, repositories) in
            ProgressUtils.dismiss()
            self.refreshControl?.endRefreshing()

            if let error = error {
                ProgressUtils.error(error.domain)
                self.canGetMore = false
            }

            if let repositories = repositories as? [Repository] {
                self.repositories = self.page == 1 ? repositories : self.repositories + repositories
                self.canGetMore = !repositories.isEmpty
            }
            
            self.isGettingMore = false
        }
    }
    
    // MARK: - Utils
    
    // MARK: Refresh control
    
    func initRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .allEvents)
        self.refreshControl = refreshControl
    }
    
    @objc func refreshData() {
        page = 1
        getRepositories()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PullRequestsTableViewController, let repository = sender as? Repository {
            destination.repository = repository
        }
    }
}

// MARK: - Table view data source

extension RepositoriesTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.reuseIdentifier) as! RepositoryTableViewCell
        let repo = repositories[indexPath.row]
        cell.repository = repo
        return cell
    }
}

// MARK: - Table view delegate

extension RepositoriesTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let repository = repositories[indexPath.row]
        performSegue(withIdentifier: String(describing: PullRequestsTableViewController.self), sender: repository)
    }
}

// MARK: - Scroll view delegate

extension RepositoriesTableViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //Get more
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        if bottomEdge >= scrollView.contentSize.height - 100 {
            //we are at the end
            if canGetMore, isGettingMore == false  {
                page += 1
                print("requesting get more page \(page)")
                isGettingMore = true
                getRepositories()
            }
        }
    }
}
