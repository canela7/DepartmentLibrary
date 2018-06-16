//
//  ItemInformationViewController.swift
//  DepartmentLibrary
//
//  Created by Brian Canela on 6/16/18.
//  Copyright © 2018 Brian Canela. All rights reserved.
//

import UIKit
import RealmSwift

class ItemInformationViewController: UIViewController {
    @IBOutlet weak var itemName: UILabel!
    
    @IBOutlet weak var itemAuthor: UILabel!
    
    @IBOutlet weak var itemInformation: UILabel!
    
    @IBOutlet weak var itemType: UILabel!
    
    @IBOutlet weak var itemAvailable: UILabel!
    
    
    var delegateForItemInformationController: DepartmentLibrary?
    var libraryEditItemArray: Results<DepartmentLibrary>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let editItem = delegateForItemInformationController {
            title = editItem.name
            itemName.text = editItem.name
            itemAuthor.text = "Author name is \(editItem.authorName)"
            itemInformation.text = "Information about \(editItem.name): \(editItem.additionalInformation)"
            itemType.text = editItem.type
            itemAvailable.text = "This item is: \(editItem.available)"
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
  
    
    
    @IBAction func checkoutButtonPressed(_ sender: Any) {
        
        
        
    }
    


    @IBAction func editButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "goToEdit", sender: self)
        
    }
    
    
}
