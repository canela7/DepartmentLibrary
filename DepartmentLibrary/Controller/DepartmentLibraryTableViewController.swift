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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadItems()
        tableView.rowHeight = 110.0;
        
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
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    //MARK: Data Manipulation Methods
    func save(library: DepartmentLibrary){
        do{
            let realm = try! Realm()
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
        let realm = try! Realm()
        libraryItemArray = realm.objects(DepartmentLibrary.self)
        
        self.tableView.reloadData()
    }
   


}
