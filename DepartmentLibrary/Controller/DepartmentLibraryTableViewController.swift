//
//  DepartmentLibraryTableViewController.swift
//  DepartmentLibrary
//
//  Created by Brian Canela on 6/12/18.
//  Copyright © 2018 Brian Canela. All rights reserved.
//

import UIKit
import RealmSwift

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemType: UILabel!
    
    @IBOutlet weak var isAvailable: UILabel!
    
}



class DepartmentLibraryTableViewController: UITableViewController {

  
    //get the results from the database.
    var libraryItemArray: Results<DepartmentLibrary>?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadItems()
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 110;
        
    }

    
    
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return libraryItemArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "departmentLibraryCell", for: indexPath) as! CustomCell
        
        if let item = libraryItemArray?[indexPath.row] {
            cell.itemName.text = item.name
            cell.itemType.text = item.type
            
            if item.available {
                cell.isAvailable.text = "Yes"
            }else {
                cell.isAvailable.text = "No"
            }
            
        }else {
            cell.itemName.text = "no item name"
            cell.itemType.text = "no item type"
            cell.isAvailable.text = "N/A"
        }
    
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "goToEdit", sender: self)
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEdit" {
            if let editDestination = segue.destination as? EditViewController {
                if let index = tableView.indexPathForSelectedRow {
                    editDestination.delegateForEditController = libraryItemArray?[index.row]
                }
            }
        }
    }
    
    
    
    
    //MARK: Data Manipulation Methods
    func save(library: DepartmentLibrary){
        do{
//            let realm = try! Realm()
            try realm.write {
                realm.add(library)
            }
        }catch{
            print("Error saving context \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    //get the items from database
    func loadItems() {
//        let realm = try! Realm()
        libraryItemArray = realm.objects(DepartmentLibrary.self).sorted(byKeyPath: "available", ascending: false)
        
        self.tableView.reloadData()
    }
   


}



// MARK: - Table View Delegate //DELETE ITEM FROM REALM.!
extension DepartmentLibraryTableViewController {
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if let itemForDeletion = libraryItemArray?[indexPath.row] {
            do{
//                let realm = try! Realm()
                try realm.write {
                    realm.delete(itemForDeletion)
                }
            }catch{
                print("Error deleting category \(error)")
            }
        }
        
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    
}


extension DepartmentLibraryTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        libraryItemArray = libraryItemArray?.filter("name CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "available", ascending: false)
        
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems() //get all the items back if the search bar is empty
            
            //ask the dispatch to run code inside the main thread, and run that
            DispatchQueue.main.async {
                //keyboard and cursor disappers after we dont have any text inside the search bar
                searchBar.resignFirstResponder()
            }
        }
    }
    
    
    
}






