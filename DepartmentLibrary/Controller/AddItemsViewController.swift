//
//  AddItemsViewController.swift
//  DepartmentLibrary
//
//  Created by Brian Canela on 6/12/18.
//  Copyright © 2018 Brian Canela. All rights reserved.
//

import UIKit

class AddItemsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var addItemButtonPressed: UIButton!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        
        if itemNameTextField.text == "" && authorTextField.text == "" && informationTextField.text == ""
        {
            addItemButtonPressed.isHidden = true
        }
        
    }

    //MARK: Texfield methods
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == itemNameTextField {
            authorTextField.becomeFirstResponder()
        }else if textField == authorTextField {
            informationTextField.becomeFirstResponder()
        }else if textField == informationTextField {
            typeTextField.becomeFirstResponder()
        }else if textField == typeTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let allInputValues = itemNameTextField.text! + authorTextField.text! + informationTextField.text! + typeTextField.text!
        
        if allInputValues == "" {
            addItemButtonPressed.isHidden = true
        } else {
            addItemButtonPressed.isHidden = false
        }
    }
    
    
    @IBAction func addItemPressed(_ sender: Any) {
        
        guard let nameTextfield = itemNameTextField.text else {fatalError("required item name ")}
        guard let authorTextfield = authorTextField.text else {fatalError("required author name")}
        guard let informationTextfield = informationTextField.text else {return print("Required information")}
        
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
