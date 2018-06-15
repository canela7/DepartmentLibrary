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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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


    

}
