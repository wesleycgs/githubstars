# GithHub Stars
Show most popular Swift repositories from GitHub.

## How to Generate App
Open ```GitHub Stars.xcworkspace``` and press <kbd>Command</kbd>+<kbd>R</kbd>

## General Explanation of code and app

#### Model
* `Repository.swift` : Repository Model
* `Owner.swift`: User Model (Repository Owner)
* `PullRequest.swift`: Pull Request Model

##### ViewControllers
* `RepositoriesTableViewController.swift`: ViewController with repositories list
* `PullRequestsTableViewController.swift`: ViewController with pull requests of selected repository

#### Api Networkers
* `BaseRequest.swift`: Used to manage global variables for networker subclasses
* `RepositoriesRequest.swift`: Api request of Repositories (Subclass of BaseRequest)
* `PullRequestsRequest.swift`: Api request of Pull Requests (Subclass of BaseRequest)

#### Helpers
* `RepositoryTableViewCell.swift/.xib`: Table view cell, in xib to reuse, used in RepositoriesTableViewController and PullRequestsTableViewController
* `DateUtils.swift`: Used to convert ```Date``` to ```String``` and vice versa in several date format
* `ProgressUtils.swift`: Used to show activity and alerts more easily of pod ```SVProgressHUD```
* `WGExtensions.swift`: My custom extensions, help to make my code more easily and faster

## Libraries Used

#### [Alamofire](https://github.com/Alamofire/Alamofire)
* Description: Elegant HTTP Networking in Swift

#### [SVProgressHUD](https://github.com/SVProgressHUD/SVProgressHUD)
* Description: A clean and lightweight progress HUD for your iOS and tvOS app.

#### [SDWebImage](https://github.com/rs/SDWebImage)
* Description: Asynchronous image downloader with cache support with an UIImageView category.
