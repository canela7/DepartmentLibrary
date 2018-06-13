//
//  DepartmentLibraryTableViewController.swift
//  DepartmentLibrary
//
//  Created by Brian Canela on 6/12/18.
//  Copyright © 2018 Brian Canela. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemType: UILabel!
    
    @IBOutlet weak var isAvailable: UILabel!
    
}



class DepartmentLibraryTableViewController: UITableViewController {
//TESTING GIT PUSH
    var items: [DepartmentLibrary]
    
    
    required init?(coder aDecoder: NSCoder) {
        
        items = [DepartmentLibrary]()
        
        let row0Item = DepartmentLibrary()
        row0Item.name = "Cracking the coding Book!";
        row0Item.type = "Book";
        row0Item.available = false
        items.append(row0Item)
        
        let row1Item = DepartmentLibrary()
        row1Item.name = "Cracking the coding Book!";
        row1Item.type = "Tablet";
        row1Item.available = true
        items.append(row1Item)
        
        
        
        let row2Item = DepartmentLibrary()
        row2Item.name = "Java for Noobs!";
        row2Item.type = "Tablet";
        row2Item.available = true
        items.append(row2Item)
   
        super.init(coder: aDecoder)
        
        
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 110.0;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "departmentLibraryCell", for: indexPath) as! CustomCell
        
         let item = items[indexPath.row]
        
        
        cell.itemName.text = item.name
        cell.itemType.text = item.type
        
        if item.available {
            cell.isAvailable.text = "Yes"
        }else {
            cell.isAvailable.text = "No"
        }
        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
   


}
