//
//  UsersTableViewController.swift
//  CampusBook
//
//  Created by Ajay Mandani on 2023-01-18.
//

import UIKit
import FirebaseAuth
class UsersTableViewController: UITableViewController, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filteredUser = allUsers.filter { user -> Bool in
            let searchusercombined = "\(user.username) \(user.program) \(user.collegeName)"
            return searchusercombined.lowercased().contains((searchController.searchBar.text)!.lowercased())
        }
        self.tableView.reloadData()
    }
    
    @IBOutlet weak var logout: UIBarButtonItem!
    var allUsers:[User] = []
    var filteredUser:[User] = []
    let searchContollers = UISearchController(searchResultsController: nil)

    @IBAction func logoutBtn(_ sender: UIBarButtonItem) {
        do{
            UserDefaults.standard.removeObject(forKey: KCURRENTUSERS)
            try  Auth.auth().signOut()
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "welcome") 

            storyboard.modalPresentationStyle = .fullScreen

            self.present(storyboard, animated: true)
        }catch{
            
        }
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.refreshControl = UIRefreshControl()
        self.tableView.refreshControl = self.refreshControl
        downloadUser()
        setupsearchcontroller()
    }

    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return  searchContollers.isActive ? filteredUser.count : allUsers.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celluseridentifer", for: indexPath) as! UserTableViewCell

        
        let users = searchContollers.isActive ? filteredUser[indexPath.row] : allUsers[indexPath.row]
        cell.configCell(user: users)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "profilegoto") as? GotoProfileViewController
        
        let users = searchContollers.isActive ? filteredUser[indexPath.row] : allUsers[indexPath.row]
        storyboard?.user = users
        self.navigationController?.pushViewController(storyboard!, animated: true)
    }
  
    
    func downloadUser()
    {
       
        
        downloadAllUsers { alluser in
            if let alluser = alluser
            {
                self.allUsers = alluser
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
           
        }
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

}
