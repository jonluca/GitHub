//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD
import AFNetworking

// Main ViewController
class RepoResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()

    @IBOutlet weak var table: UITableView!
    
    var repos: [GithubRepo]!
    
    


    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self

        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        // Perform the first search when the view controller first loads
        doSearch()
        
        //tableview stuff
        self.table.delegate = self
        self.table.dataSource = self
        

        
        
    }

    // Perform the search.
    private func doSearch() {

        MBProgressHUD.showHUDAddedTo(self.view, animated: true)

        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in

            // Print the returned repositories to the output window
            for repo in newRepos {
                print(repo)
            }
            
            self.repos = newRepos
            
            print("__________________")
            for repo in self.repos {
                print(repo)
            }
            self.table.reloadData()


            MBProgressHUD.hideHUDForView(self.view, animated: true)
            }, error: { (error) -> Void in
                print(error)
        })
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! RepoViewCell

        if let temp = repos{
            if let repo = repos[indexPath.row] as? GithubRepo{
                cell.nameLabel.text = repo.name
                cell.authorLabel.text = repo.ownerHandle
                cell.descriptionLabel.text = repo.desc
                cell.starsLabel.text = "\(repo.stars!)"
                cell.forksLabel.text = "\(repo.forks!)"
                let imageUrlString = repo.ownerAvatarURL as! String!
                if let imageUrl = NSURL(string: imageUrlString) {
                    cell.displayImage.setImageWithURL(imageUrl as NSURL)
                } else {
                    // NSURL(string: imageUrlString!) is nil. Good thing we didn't try to unwrap it!
                }
            }
        }
        
       
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}





// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true;
    }

    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true;
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}
