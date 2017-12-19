//
//  MovieResultsViewController.swift
//  movieMax
//
//  Created by sagarmodak on 19/12/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit
import SDWebImage

class MovieResultsViewController: UIViewController {

    @IBOutlet weak var movieResultsTableView: UITableView!
    var movieListArray : [Movie] = []
    var pageIndex : Int = 1
    var searchString : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    func setupView() {
        
        registerNibs()
        self.movieResultsTableView.rowHeight = UITableViewAutomaticDimension
        self.movieResultsTableView.estimatedRowHeight = 150
        self.title = "\(self.searchString) Movies"
    }
    
    func callSearchWith(searchString : String, pageIndex : Int) {
        let payload = SearchAPI.Payload()
        payload.search_string = searchString
        payload.page = pageIndex
        
        SearchAPI.getSearchResults(payload: payload, onSuccess: { (result) in
            switch result {
            case .Success(let response) :
                if let moviesArray = response.results {
                    //self.movieListArray.removeAll()
                    
                    //self.movieListArray.append(moviesArray)
                    self.movieListArray.append(contentsOf: moviesArray)
                    
                    DispatchQueue.main.async {
                        Utils.hideLoadingInView(view: self.view)
                        self.movieResultsTableView.reloadData()
                    }
                    
                }
                
            case .Error(let error) :
                Utils.hideLoadingInView(view: self.view)
                Utils.displayAlert(title: "Error Occured", message: error.localizedDescription, senderViewController: self, alertDisplayedHandler: {
                    print("ok")
                })
                
            case .JSONParsingFailure() :
                Utils.hideLoadingInView(view: self.view)
                Utils.displayAlert(title: "Error Occured", message: errorOccuredAlertMessage, senderViewController: self, alertDisplayedHandler: {
                    print("ok")
                })
            }
            
        }) { (error) in
            Utils.hideLoadingInView(view: self.view)
            Utils.displayAlert(title: "Error Occured", message: error.localizedDescription, senderViewController: self, alertDisplayedHandler: {
                print("ok")
            })
        }
    }
    
    func registerNibs() {
        self.movieResultsTableView.register(UINib(nibName:movieResultTableViewCellIdentifier,bundle:nil), forCellReuseIdentifier: movieResultTableViewCellIdentifier)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}

extension MovieResultsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(movieListArray.count > 0) {
            return movieListArray.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movieCell = self.movieResultsTableView.dequeueReusableCell(withIdentifier: movieResultTableViewCellIdentifier, for: indexPath) as! MovieResultTableViewCell
        
        if(movieListArray.count > 0) {
            
            let movieObject = movieListArray[indexPath.row]
            
            movieCell.populateDataFrom(movieObject: movieObject)

        }
        movieCell.selectionStyle = .none
        return movieCell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(movieListArray.count > 19) {
            if(indexPath.row + 1 == self.movieListArray.count) {
                self.pageIndex = self.pageIndex + 1
                Utils.showLoadingIn(view: self.view)
                self.callSearchWith(searchString: self.searchString, pageIndex: self.pageIndex)
            }
        }
       
    }
    
}
