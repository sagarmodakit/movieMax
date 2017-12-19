//
//  RecentSearchesViewController.swift
//  movieMax
//
//  Created by sagarmodak on 19/12/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit

protocol RecentSearchControllerDelegate{
    func didSelectSearch(searchName : String)
}

class RecentSearchesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var recentSearchTableView: UITableView!
    var delegate : RecentSearchControllerDelegate? = nil
    var searches : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recentSearchTableView.delegate = self
        self.recentSearchTableView.dataSource = self

        showSearches()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getRecentSearchesFromDB()
    }
    
    func getRecentSearchesFromDB() {
        let movieDBManager = MovieDBManager()
        searches = movieDBManager.getAllSearchesFromDB(entityName: "RecentSearches")
        self.recentSearchTableView.reloadData()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //showSearches()
    }
    
    func showSearches() {
        self.recentSearchTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searches.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(searches.count > 0) {
            return "You recently searched for.."
        }
        else {
            return "No recent searches"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.searches[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectSearch(searchName: searches[indexPath.row])
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



