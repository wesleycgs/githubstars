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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(getRepositories), for: .allEvents)
        tableView.refreshControl = refreshControl
        
        registerCells()
        getRepositories()
    }
    
    func registerCells() {
        tableView.register(RepositoryTableViewCell.nib, forCellReuseIdentifier: RepositoryTableViewCell.reuseIdentifier)
    }
    
    // MARK: - Requests
    
    @objc func getRepositories() {
        //Fake data
        let json = """
[
{
            "id": 22458259,
            "node_id": "MDEwOlJlcG9zaXRvcnkyMjQ1ODI1OQ==",
            "name": "Alamofire",
            "full_name": "Alamofire/Alamofire",
            "owner": {
                "login": "Alamofire",
                "id": 7774181,
                "node_id": "MDEyOk9yZ2FuaXphdGlvbjc3NzQxODE=",
                "avatar_url": "https://avatars3.githubusercontent.com/u/7774181?v=4",
                "gravatar_id": "",
                "url": "https://api.github.com/users/Alamofire",
                "html_url": "https://github.com/Alamofire",
                "followers_url": "https://api.github.com/users/Alamofire/followers",
                "following_url": "https://api.github.com/users/Alamofire/following{/other_user}",
                "gists_url": "https://api.github.com/users/Alamofire/gists{/gist_id}",
                "starred_url": "https://api.github.com/users/Alamofire/starred{/owner}{/repo}",
                "subscriptions_url": "https://api.github.com/users/Alamofire/subscriptions",
                "organizations_url": "https://api.github.com/users/Alamofire/orgs",
                "repos_url": "https://api.github.com/users/Alamofire/repos",
                "events_url": "https://api.github.com/users/Alamofire/events{/privacy}",
                "received_events_url": "https://api.github.com/users/Alamofire/received_events",
                "type": "Organization",
                "site_admin": false
            },
            "private": false,
            "html_url": "https://github.com/Alamofire/Alamofire",
            "description": "Elegant HTTP Networking in Swift",
            "fork": false,
            "url": "https://api.github.com/repos/Alamofire/Alamofire",
            "forks_url": "https://api.github.com/repos/Alamofire/Alamofire/forks",
            "keys_url": "https://api.github.com/repos/Alamofire/Alamofire/keys{/key_id}",
            "collaborators_url": "https://api.github.com/repos/Alamofire/Alamofire/collaborators{/collaborator}",
            "teams_url": "https://api.github.com/repos/Alamofire/Alamofire/teams",
            "hooks_url": "https://api.github.com/repos/Alamofire/Alamofire/hooks",
            "issue_events_url": "https://api.github.com/repos/Alamofire/Alamofire/issues/events{/number}",
            "events_url": "https://api.github.com/repos/Alamofire/Alamofire/events",
            "assignees_url": "https://api.github.com/repos/Alamofire/Alamofire/assignees{/user}",
            "branches_url": "https://api.github.com/repos/Alamofire/Alamofire/branches{/branch}",
            "tags_url": "https://api.github.com/repos/Alamofire/Alamofire/tags",
            "blobs_url": "https://api.github.com/repos/Alamofire/Alamofire/git/blobs{/sha}",
            "git_tags_url": "https://api.github.com/repos/Alamofire/Alamofire/git/tags{/sha}",
            "git_refs_url": "https://api.github.com/repos/Alamofire/Alamofire/git/refs{/sha}",
            "trees_url": "https://api.github.com/repos/Alamofire/Alamofire/git/trees{/sha}",
            "statuses_url": "https://api.github.com/repos/Alamofire/Alamofire/statuses/{sha}",
            "languages_url": "https://api.github.com/repos/Alamofire/Alamofire/languages",
            "stargazers_url": "https://api.github.com/repos/Alamofire/Alamofire/stargazers",
            "contributors_url": "https://api.github.com/repos/Alamofire/Alamofire/contributors",
            "subscribers_url": "https://api.github.com/repos/Alamofire/Alamofire/subscribers",
            "subscription_url": "https://api.github.com/repos/Alamofire/Alamofire/subscription",
            "commits_url": "https://api.github.com/repos/Alamofire/Alamofire/commits{/sha}",
            "git_commits_url": "https://api.github.com/repos/Alamofire/Alamofire/git/commits{/sha}",
            "comments_url": "https://api.github.com/repos/Alamofire/Alamofire/comments{/number}",
            "issue_comment_url": "https://api.github.com/repos/Alamofire/Alamofire/issues/comments{/number}",
            "contents_url": "https://api.github.com/repos/Alamofire/Alamofire/contents/{+path}",
            "compare_url": "https://api.github.com/repos/Alamofire/Alamofire/compare/{base}...{head}",
            "merges_url": "https://api.github.com/repos/Alamofire/Alamofire/merges",
            "archive_url": "https://api.github.com/repos/Alamofire/Alamofire/{archive_format}{/ref}",
            "downloads_url": "https://api.github.com/repos/Alamofire/Alamofire/downloads",
            "issues_url": "https://api.github.com/repos/Alamofire/Alamofire/issues{/number}",
            "pulls_url": "https://api.github.com/repos/Alamofire/Alamofire/pulls{/number}",
            "milestones_url": "https://api.github.com/repos/Alamofire/Alamofire/milestones{/number}",
            "notifications_url": "https://api.github.com/repos/Alamofire/Alamofire/notifications{?since,all,participating}",
            "labels_url": "https://api.github.com/repos/Alamofire/Alamofire/labels{/name}",
            "releases_url": "https://api.github.com/repos/Alamofire/Alamofire/releases{/id}",
            "deployments_url": "https://api.github.com/repos/Alamofire/Alamofire/deployments",
            "created_at": "2014-07-31T05:56:19Z",
            "updated_at": "2018-08-15T15:45:36Z",
            "pushed_at": "2018-08-09T12:05:01Z",
            "git_url": "git://github.com/Alamofire/Alamofire.git",
            "ssh_url": "git@github.com:Alamofire/Alamofire.git",
            "clone_url": "https://github.com/Alamofire/Alamofire.git",
            "svn_url": "https://github.com/Alamofire/Alamofire",
            "homepage": "",
            "size": 6735,
            "stargazers_count": 28719,
            "watchers_count": 28719,
            "language": "Swift",
            "has_issues": true,
            "has_projects": true,
            "has_downloads": true,
            "has_wiki": false,
            "has_pages": true,
            "forks_count": 5104,
            "mirror_url": null,
            "archived": false,
            "open_issues_count": 47,
            "license": {
                "key": "mit",
                "name": "MIT License",
                "spdx_id": "MIT",
                "url": "https://api.github.com/licenses/mit",
                "node_id": "MDc6TGljZW5zZTEz"
            },
            "forks": 5104,
            "open_issues": 47,
            "watchers": 28719,
            "default_branch": "master",
            "score": 1
        },
{
            "id": 21700699,
            "node_id": "MDEwOlJlcG9zaXRvcnkyMTcwMDY5OQ==",
            "name": "awesome-ios",
            "full_name": "vsouza/awesome-ios",
            "owner": {
                "login": "vsouza",
                "id": 484656,
                "node_id": "MDQ6VXNlcjQ4NDY1Ng==",
                "avatar_url": "https://avatars2.githubusercontent.com/u/484656?v=4",
                "gravatar_id": "",
                "url": "https://api.github.com/users/vsouza",
                "html_url": "https://github.com/vsouza",
                "followers_url": "https://api.github.com/users/vsouza/followers",
                "following_url": "https://api.github.com/users/vsouza/following{/other_user}",
                "gists_url": "https://api.github.com/users/vsouza/gists{/gist_id}",
                "starred_url": "https://api.github.com/users/vsouza/starred{/owner}{/repo}",
                "subscriptions_url": "https://api.github.com/users/vsouza/subscriptions",
                "organizations_url": "https://api.github.com/users/vsouza/orgs",
                "repos_url": "https://api.github.com/users/vsouza/repos",
                "events_url": "https://api.github.com/users/vsouza/events{/privacy}",
                "received_events_url": "https://api.github.com/users/vsouza/received_events",
                "type": "User",
                "site_admin": false
            },
            "private": false,
            "html_url": "https://github.com/vsouza/awesome-ios",
            "description": "A curated list of awesome iOS ecosystem, including Objective-C and Swift Projects ",
            "fork": false,
            "url": "https://api.github.com/repos/vsouza/awesome-ios",
            "forks_url": "https://api.github.com/repos/vsouza/awesome-ios/forks",
            "keys_url": "https://api.github.com/repos/vsouza/awesome-ios/keys{/key_id}",
            "collaborators_url": "https://api.github.com/repos/vsouza/awesome-ios/collaborators{/collaborator}",
            "teams_url": "https://api.github.com/repos/vsouza/awesome-ios/teams",
            "hooks_url": "https://api.github.com/repos/vsouza/awesome-ios/hooks",
            "issue_events_url": "https://api.github.com/repos/vsouza/awesome-ios/issues/events{/number}",
            "events_url": "https://api.github.com/repos/vsouza/awesome-ios/events",
            "assignees_url": "https://api.github.com/repos/vsouza/awesome-ios/assignees{/user}",
            "branches_url": "https://api.github.com/repos/vsouza/awesome-ios/branches{/branch}",
            "tags_url": "https://api.github.com/repos/vsouza/awesome-ios/tags",
            "blobs_url": "https://api.github.com/repos/vsouza/awesome-ios/git/blobs{/sha}",
            "git_tags_url": "https://api.github.com/repos/vsouza/awesome-ios/git/tags{/sha}",
            "git_refs_url": "https://api.github.com/repos/vsouza/awesome-ios/git/refs{/sha}",
            "trees_url": "https://api.github.com/repos/vsouza/awesome-ios/git/trees{/sha}",
            "statuses_url": "https://api.github.com/repos/vsouza/awesome-ios/statuses/{sha}",
            "languages_url": "https://api.github.com/repos/vsouza/awesome-ios/languages",
            "stargazers_url": "https://api.github.com/repos/vsouza/awesome-ios/stargazers",
            "contributors_url": "https://api.github.com/repos/vsouza/awesome-ios/contributors",
            "subscribers_url": "https://api.github.com/repos/vsouza/awesome-ios/subscribers",
            "subscription_url": "https://api.github.com/repos/vsouza/awesome-ios/subscription",
            "commits_url": "https://api.github.com/repos/vsouza/awesome-ios/commits{/sha}",
            "git_commits_url": "https://api.github.com/repos/vsouza/awesome-ios/git/commits{/sha}",
            "comments_url": "https://api.github.com/repos/vsouza/awesome-ios/comments{/number}",
            "issue_comment_url": "https://api.github.com/repos/vsouza/awesome-ios/issues/comments{/number}",
            "contents_url": "https://api.github.com/repos/vsouza/awesome-ios/contents/{+path}",
            "compare_url": "https://api.github.com/repos/vsouza/awesome-ios/compare/{base}...{head}",
            "merges_url": "https://api.github.com/repos/vsouza/awesome-ios/merges",
            "archive_url": "https://api.github.com/repos/vsouza/awesome-ios/{archive_format}{/ref}",
            "downloads_url": "https://api.github.com/repos/vsouza/awesome-ios/downloads",
            "issues_url": "https://api.github.com/repos/vsouza/awesome-ios/issues{/number}",
            "pulls_url": "https://api.github.com/repos/vsouza/awesome-ios/pulls{/number}",
            "milestones_url": "https://api.github.com/repos/vsouza/awesome-ios/milestones{/number}",
            "notifications_url": "https://api.github.com/repos/vsouza/awesome-ios/notifications{?since,all,participating}",
            "labels_url": "https://api.github.com/repos/vsouza/awesome-ios/labels{/name}",
            "releases_url": "https://api.github.com/repos/vsouza/awesome-ios/releases{/id}",
            "deployments_url": "https://api.github.com/repos/vsouza/awesome-ios/deployments",
            "created_at": "2014-07-10T16:03:45Z",
            "updated_at": "2018-08-15T18:24:42Z",
            "pushed_at": "2018-08-14T16:24:19Z",
            "git_url": "git://github.com/vsouza/awesome-ios.git",
            "ssh_url": "git@github.com:vsouza/awesome-ios.git",
            "clone_url": "https://github.com/vsouza/awesome-ios.git",
            "svn_url": "https://github.com/vsouza/awesome-ios",
            "homepage": "http://awesomeios.com",
            "size": 7923,
            "stargazers_count": 27058,
            "watchers_count": 27058,
            "language": "Swift",
            "has_issues": true,
            "has_projects": true,
            "has_downloads": true,
            "has_wiki": false,
            "has_pages": false,
            "forks_count": 4542,
            "mirror_url": null,
            "archived": false,
            "open_issues_count": 2,
            "license": {
                "key": "mit",
                "name": "MIT License",
                "spdx_id": "MIT",
                "url": "https://api.github.com/licenses/mit",
                "node_id": "MDc6TGljZW5zZTEz"
            },
            "forks": 4542,
            "open_issues": 2,
            "watchers": 27058,
            "default_branch": "master",
            "score": 1
        }
]
""".data(using: .utf8)!
        
        let decode = JSONDecoder()
        decode.keyDecodingStrategy = .convertFromSnakeCase
        decode.dateDecodingStrategy = .iso8601
        
        do {
            repositories = try decode.decode([Repository].self, from: json)
            tableView.reloadDataAnimated()
        } catch {
            print(error)
        }
        
    }
    
    // MARK: - Utils
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
