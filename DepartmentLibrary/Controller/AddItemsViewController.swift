//
//  AddItemsViewController.swift
//  DepartmentLibrary
//
//  Created by Brian Canela on 6/12/18.
//  Copyright © 2018 Brian Canela. All rights reserved.
//

import UIKit
import RealmSwift

class AddItemsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var addItemButtonPressed: UIButton!
    
    @IBOutlet weak var doneBarButtonPressed: UIBarButtonItem!
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
        let allInputValues = itemNameTextField.text! + authorTextField.text! + informationTextField.text! + typeTextField.text!
        if allInputValues == "" {
            doneBarButtonPressed.isEnabled = false
        }
        
        

    }

    //MARK: TextField Methods
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
            doneBarButtonPressed.isEnabled = false
        } else {
            doneBarButtonPressed.isEnabled = true
        }
    }
 
    //Done bar button pressed
    @IBAction func doneBarButtonPressed(_ sender: Any) {
        guard let nameTextfield = itemNameTextField.text else {fatalError("required item name ")}
        guard let authorTextfield = authorTextField.text else {fatalError("required author name")}
        guard let informationTextfield = informationTextField.text else {return print("Required information")}
        guard let type = typeTextField.text else {fatalError("no type")}
        
        print(nameTextfield, authorTextfield, informationTextfield, type);
        
        let newItem = DepartmentLibrary()
        newItem.name = nameTextfield
        newItem.authorName = authorTextfield
        newItem.additionalInformation = informationTextfield
        newItem.type = type
        newItem.available = true
        
        do{
            let realm = try! Realm()
            try realm.write {
                realm.add(newItem)
            }
        }catch{
            print("Error saving context \(error)")
        }
        
        performSegue(withIdentifier: "goToDepartmentLibrary", sender: self)
        
        
        
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
