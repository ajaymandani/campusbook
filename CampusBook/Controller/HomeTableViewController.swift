//
//  HomeTableViewController.swift
//  CampusBook
//
//  Created by Ajay Mandani on 2023-01-20.
//

import UIKit

class HomeTableViewController: UITableViewController, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filteredLatest = allLatest.filter { user -> Bool in
            let searchusercombined = "\(user.receriverName) \(user.collegeName) \(user.programName)"
            print(searchusercombined)

            return searchusercombined.lowercased().contains((searchController.searchBar.text)!.lowercased())
        }
        self.tableView.reloadData()
    }
    

    var allLatest:[Latest] = []
    var filteredLatest:[Latest] = []
    let searchContollers = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        donwloadAlldata()
       
        setupsearchcontroller()
    }

    private func donwloadAlldata()
    {
        FirebaseLatestListener.shared.downloadAllLatestfromfirestore { latest in
            if let latest = latest{
                self.allLatest = latest
               
            }else{
                self.allLatest = []
                
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
 

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchContollers.isActive ? filteredLatest.count : allLatest.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! HomeTableViewCell
        
        cell.conifcell(latest: searchContollers.isActive ? filteredLatest[indexPath.row] : allLatest[indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func setupsearchcontroller()
    {
        searchContollers.searchBar.searchTextField.backgroundColor = .darkGray
        searchContollers.searchBar.barTintColor = .white
        searchContollers.searchBar.searchTextField.tintColor = .white
        searchContollers.searchBar.searchTextField.textColor = .white
        searchContollers.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search by username, college name, college program",attributes: [.foregroundColor:UIColor.lightGray])
        navigationItem.searchController = searchContollers
        navigationItem.searchController?.searchBar.searchTextField.textColor = .white
        navigationItem.hidesSearchBarWhenScrolling = true
        searchContollers.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchContollers.searchResultsUpdater = self
    }
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let recent = searchContollers.isActive ? filteredLatest[indexPath.row] : allLatest[indexPath.row]
            
            FirebaseLatestListener.shared.deleteLatets(latest: recent)
            
            _ = searchContollers.isActive ? self.filteredLatest.remove(at: indexPath.row) : allLatest.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

}
