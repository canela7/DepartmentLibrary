//
//  CheckoutLogTableViewController.swift
//  DepartmentLibrary
//
//  Created by Brian Canela on 6/19/18.
//  Copyright © 2018 Brian Canela. All rights reserved.
//

import UIKit
import RealmSwift

class CheckoutLogTableViewController: UITableViewController {
    
    var libaryItemArray: Results<DepartmentLibrary>?
    
    var checkoutItemArray: Results<CheckoutLogModel>?
    
    
    
    let realm = try! Realm()


    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return checkoutItemArray?.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "checkoutLogCell", for: indexPath)

    

        return cell
    }
 

   
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
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
        checkoutItemArray = realm.objects(CheckoutLogModel.self).sorted(byKeyPath: "dateBorrowed", ascending: false)
        
        self.tableView.reloadData()
    }
 

   
 
 

    

}
