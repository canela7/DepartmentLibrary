//
//  AddItemsViewController.swift
//  DepartmentLibrary
//
//  Created by Brian Canela on 6/12/18.
//  Copyright © 2018 Brian Canela. All rights reserved.
//

import UIKit

class AddItemsViewController: UIViewController {

    @IBOutlet weak var addNameItem: UITextField!
    @IBOutlet weak var addAuthorItem: UITextField!
    
    @IBOutlet weak var addInformationItem: UITextField!
    
    @IBOutlet weak var addPickerViewItem: UIPickerView!
    
    let itemPickerViewTypes = ["Book", "Tablet"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}


extension AddItemsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
  
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return itemPickerViewTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return itemPickerViewTypes[row]
    }
    
}
