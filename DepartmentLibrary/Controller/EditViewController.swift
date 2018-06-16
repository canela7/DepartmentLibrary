//
//  EditViewController.swift
//  DepartmentLibrary
//
//  Created by Brian Canela on 6/14/18.
//  Copyright © 2018 Brian Canela. All rights reserved.
//

import UIKit
import RealmSwift


class EditViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var editNameTextField: UITextField!
    
    @IBOutlet weak var editAuthorTextField: UITextField!
    
    @IBOutlet weak var editInformationTextField: UITextField!
    
    
    @IBOutlet weak var editSelectedType: UITextField!
    
    
    @IBOutlet weak var doneBarButtonPressed: UIBarButtonItem!
    
    
    var delegateForEditController: DepartmentLibrary?
    
    var libraryEditItemArray: Results<DepartmentLibrary>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let editItem = delegateForEditController {
            title = editItem.name
            editNameTextField.text = editItem.name
            editAuthorTextField.text = editItem.authorName
            editInformationTextField.text = editItem.additionalInformation
            editSelectedType.text = editItem.type
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let allInputValues = editNameTextField.text! +  editAuthorTextField.text! + editInformationTextField.text! + editSelectedType.text!
        if allInputValues == "" {
            doneBarButtonPressed.isEnabled = false
        }

    }
    
    
    //MARK: Textfield methods
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == editNameTextField {
            editAuthorTextField.becomeFirstResponder()
        }else if textField == editAuthorTextField {
            editInformationTextField.becomeFirstResponder()
        }else if textField == editInformationTextField {
            editSelectedType.becomeFirstResponder()
        }else if textField == editSelectedType {
            textField.resignFirstResponder()
        }
        return true
    }
    

    
    func textFieldDidEndEditing(_ textField: UITextField) {

        let allInputValues = editNameTextField.text! + editAuthorTextField.text! + editInformationTextField.text! + editSelectedType.text!

        if allInputValues == "" {
            doneBarButtonPressed.isEnabled = false
        } else {
            doneBarButtonPressed.isEnabled = true
        }
    }

    @IBAction func editDoneBarButtonPressed(_ sender: Any) {
        //update the current realm!
        guard let nameTextfield = editNameTextField.text else {fatalError("required item name ")}
        guard let authorTextfield = editAuthorTextField.text else {fatalError("required author name")}
        guard let informationTextfield = editInformationTextField.text else {return print("Required information")}
        guard let type = editSelectedType.text else {fatalError("no type")}

        if let editItem = delegateForEditController {
            do{
                let realm = try! Realm()
                try realm.write {
                    editItem.name = nameTextfield
                    editItem.authorName = authorTextfield
                    editItem.additionalInformation = informationTextfield
                    editItem.type = type
                }
            }catch{
                print("Error deleting category \(error)")
            }
        }
        
        performSegue(withIdentifier: "goToDepartmentLibrayFromEdit", sender: self)
        
        print("Triggered!")
    }
    
    
    

}

