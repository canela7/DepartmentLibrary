//
//  AddItemsViewController.swift
//  DepartmentLibrary
//
//  Created by Brian Canela on 6/12/18.
//  Copyright © 2018 Brian Canela. All rights reserved.
//

import UIKit

class AddItemsViewController: UIViewController {

    @IBOutlet weak var itemNameTextField: UITextField!
    
    @IBOutlet weak var authorTextField: UITextField!
    
    @IBOutlet weak var informationTextField: UITextField!
    
    @IBOutlet weak var typeTextField: UITextField!
    
    let itemPickerViewTypes = ["Book", "Tablet"]
    
    var pickerView = UIPickerView()
    
    //to store the data and send it to homepage
    var addedItemsToDepartmentLibrary: DepartmentLibrary?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.delegate = self
        pickerView.dataSource = self
        
        
        typeTextField.inputView = pickerView
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addItemPressed(_ sender: Any) {
        
        let nameTextfield = itemNameTextField.text!
        let authorTextfield = authorTextField.text!
        let informationTextfield = informationTextField.text!
        
        let type = typeTextField.text!





        print(nameTextfield, authorTextfield, informationTextfield, type);

        
        
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //TODO
        typeTextField.text = itemPickerViewTypes[row]
        typeTextField.resignFirstResponder()
    }
    
    
    
}
