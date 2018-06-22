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
            guard let dueDate = item.dueCreated else {fatalError("required item name ")}
         
            cell.studentNameLabel.text = "Student Name: \(item.studentName)"
            cell.dueDateLabel.text = "Item Due Date \(dueDate)"
            cell.dateReturnedLabel.text = "Item Returned  \(String(describing: item.dateReturned))"
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

   
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    //MARK: Data Manipulation Methods
    func save(library: CheckoutLogModel){
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
        checkoutItemArray = delegateForCheckoutTable?.checkoutlog.sorted(byKeyPath: "dateBorrowed")
        self.tableView.reloadData()
    }
 

   
 
 

    

}
