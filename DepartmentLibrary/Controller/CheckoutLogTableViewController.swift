//
//  CheckoutLogTableViewController.swift
//  DepartmentLibrary
//
//  Created by Brian Canela on 6/19/18.
//  Copyright © 2018 Brian Canela. All rights reserved.
//

import UIKit
import RealmSwift


class CheckoutCustomCell: UITableViewCell {

    @IBOutlet weak var studentNameLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dateReturnedLabel: UILabel!
    
}

class CheckoutLogTableViewController: UITableViewController {
    
    var libaryItemArray: Results<DepartmentLibrary>?
    
    var checkoutItemArray: Results<CheckoutLogModel>?
    
    var delegateForCheckoutTable: DepartmentLibrary?
    
    
    let realm = try! Realm()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return checkoutItemArray?.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "checkoutLogCell", for: indexPath) as! CheckoutCustomCell
        
        if let item = checkoutItemArray?[indexPath.row] {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            
            cell.studentNameLabel.text = "Student Name: \(item.studentName)"
            
            
            if let dueDatee = item.dueCreated {
                let dueDate = dateFormatter.string(from: dueDatee)

                cell.dueDateLabel.text = "Item Due Date \(dueDate)"
            }else {
                cell.dueDateLabel.text = "No Due Date for this Item"
            }
            
            if let dateReturned = item.dateReturned {
                cell.dateReturnedLabel.text = "Item Returned  \(dateReturned))"
            }else {
                cell.dateReturnedLabel.text = "Item not yet Returned"
            }
            
        }else {
            cell.studentNameLabel.text = "no item name"
            cell.dueDateLabel.text = "no item type"
            cell.dateReturnedLabel.text = "N/A"
        }
    

        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK: Data Manipulation Methods
    func save(library: CheckoutLogModel){
        do{
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
        checkoutItemArray = delegateForCheckoutTable?.checkoutlog.sorted(byKeyPath: "dateBorrowed")
        self.tableView.reloadData()
    }

}



// MARK: - Table View Delegate //DELETE ITEM FROM REALM.!
extension CheckoutLogTableViewController {
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if let itemForDeletion = checkoutItemArray?[indexPath.row] {
            do{
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

