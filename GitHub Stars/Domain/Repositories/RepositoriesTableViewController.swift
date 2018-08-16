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
    
    var repositories: [Repository] = []
    var page = 1
    
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
    
    @objc func getRepositories() {
        if refreshControl?.isRefreshing == false {
            ProgressUtils.show()
        }

        RepositoriesRequest.all(page) { (error, repositories) in
            ProgressUtils.dismiss()
            self.refreshControl?.endRefreshing()

            if let error = error {
                ProgressUtils.error(error.domain)
            }

            if let repositories = repositories as? [Repository] {
                self.repositories += repositories
                self.tableView.reloadDataAnimated()
            }
        }
        
    }
    
    // MARK: - Utils
    
    // MARK: Refresh control
    
    func initRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(getRepositories), for: .allEvents)
        self.refreshControl = refreshControl
    }
    
    @objc func refreshData() {
        page = 0
        getRepositories()
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
