//
//  ViewController.swift
//  movieMax
//
//  Created by sagarmodak on 19/12/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, RecentSearchControllerDelegate {

    var searchController : UISearchController!

    var movieListArray : [Movie] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    func setupView() {
        self.title = "MovieMax"
        setupSearchBarUI()
    }
    
    func setupSearchBarUI() {

        let recentSearchController = UIStoryboard.getRecentSearchesViewController()
        recentSearchController.delegate = self
        searchController = UISearchController(searchResultsController: recentSearchController)
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for Movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    @IBAction func clickHappened(_ sender: Any) {
        
        let listViewObj = UIStoryboard.getMovieResultsListViewController()
        self.navigationController?.pushViewController(listViewObj, animated: true)
    }
 
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        self.searchController.isActive = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchController.searchBar.resignFirstResponder()
        self.searchController.isActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if(self.searchController.searchBar.text != nil) {
            
            self.searchMovieApiCallWithSearchString(query: self.searchController.searchBar.text!)
        }
        
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            self.searchController.searchResultsController?.view.isHidden = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- searchApiCall
    func searchMovieApiCallWithSearchString(query: String) {
        
        let payload = SearchAPI.Payload()
        payload.search_string = query
        payload.page = 1
        
        Utils.showLoadingIn(view: (self.searchController.searchResultsController?.view)!)
        SearchAPI.getSearchResults(payload: payload, onSuccess: { (result) in
            switch result {
            case .Success(let response) :
                if let moviesArray = response.results {
                    self.movieListArray.removeAll()
                    self.movieListArray = moviesArray
                    
                    if(self.movieListArray.count > 0) {
                        
                        let movieDBManager = MovieDBManager()
                        movieDBManager.saveRecentSearches(searchName: query)
                        
                        DispatchQueue.main.async {
                            Utils.hideLoadingInView(view: (self.searchController.searchResultsController?.view)!)
                            let movieListView = UIStoryboard.getMovieResultsListViewController()
                            movieListView.movieListArray = self.movieListArray
                            movieListView.searchString = query
                        self.navigationController?.pushViewController(movieListView, animated: true)
                        }
                    }
                    else {
                        Utils.hideLoadingInView(view: (self.searchController.searchResultsController?.view)!)
                        Utils.displayAlert(title: "Oops", message: noMoviesFoundAlertMessage, senderViewController: self, alertDisplayedHandler: {
                            print("ok")
                        })
                        
                    }
                    
                }
                
            case .Error(let error) :
                Utils.hideLoadingInView(view: (self.searchController.searchResultsController?.view)!)
                Utils.displayAlert(title: "Error Occured", message: error.localizedDescription, senderViewController: self, alertDisplayedHandler: {
                    print("ok")
                })
               
                
            case .JSONParsingFailure() :
                Utils.hideLoadingInView(view: (self.searchController.searchResultsController?.view)!)
                Utils.displayAlert(title: "Error Occured", message: errorOccuredAlertMessage, senderViewController: self, alertDisplayedHandler: {
                    print("ok")
                })
                
            }
            
        }) { (error) in
            Utils.hideLoadingInView(view: (self.searchController.searchResultsController?.view)!)
            Utils.displayAlert(title: "Error Occured", message: error.localizedDescription, senderViewController: self, alertDisplayedHandler: {
                print("ok")
            })
            
        }
        
    }
    
    func didSelectSearch(searchName: String) {
        //self.searchController.dismiss(animated: true, completion: nil)
        self.searchMovieApiCallWithSearchString(query: searchName)
    }


}

