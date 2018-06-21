//
//  CheckoutViewController.swift
//  DepartmentLibrary
//
//  Created by Brian Canela on 6/19/18.
//  Copyright © 2018 Brian Canela. All rights reserved.
//

import UIKit
import RealmSwift

class CheckoutViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var studentNameTextField: UITextField!
    
    @IBOutlet weak var studentCinTextField: UITextField!
    
    
    @IBOutlet weak var dateBorrowedLabel: UILabel!
    
    @IBOutlet weak var dueDateTextField: UITextField!
    
   
    var dueDatePicker = UIDatePicker()
    
    //use for today date
    var datepicker = UIDatePicker()
    let formatter = DateFormatter()
    
    
     let realm = try! Realm()
    
    var selectedItem: DepartmentLibrary?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDatePicker()
        
        
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: datepicker.date)
        dateBorrowedLabel.text = dateString

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: TextField Methods
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == studentNameTextField {
            studentCinTextField.becomeFirstResponder()
        }else if textField == studentCinTextField {
            dueDateTextField.becomeFirstResponder()
        }else if textField == dueDateTextField {
              textField.resignFirstResponder()
        }
        return true
    }
    
    
    @IBAction func doneBarButtonPressed(_ sender: Any) {
        guard let studentName = studentNameTextField.text else {return}
        guard let cin  = studentCinTextField.text else {fatalError("required student cin name")}
        guard let dateBorrowed = dateBorrowedLabel.text else {return print("Required information")}
        guard let dueDate = dueDateTextField.text else {fatalError("required due date return book")}
        
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateBorrow = formatter.date(from: dateBorrowed)
        let dueDateItem = formatter.date(from: dueDate)

         print(studentName, cin, dateBorrowed, dueDate);
        
//        if let currentItemList = self.selectedItem {
//            let newItem = CheckoutLogModel()
//
//            newItem.studentName = studentName
//            newItem.cin = Int(cin)!
//            newItem.dateBorrowed = dateBorrow
//            newItem.dueCreated = dueDateItem
//
//        }
        
        do{
            try realm.write {
                if let currentItemList = self.selectedItem {
                    let newItem = CheckoutLogModel()
                    
                    newItem.studentName = studentName
                    newItem.cin = Int(cin)!
                    newItem.dateBorrowed = dateBorrow
                    newItem.dueCreated = dueDateItem
                    currentItemList.checkoutlog.append(newItem)
                }
                
//                realm.add(newItem)
            }
        }catch{
            print("Error saving context \(error)")
        }
        
        
        
    }
    
    
    
    
    
    
    



}


extension CheckoutViewController {
    func createDatePicker(){

        let toolbarDueDate = UIToolbar()
        toolbarDueDate.sizeToFit()

        
        let doneDueDate = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedDueDate))
        toolbarDueDate.setItems([doneDueDate], animated: true)

        
        dueDateTextField.inputAccessoryView = toolbarDueDate
        dueDateTextField.inputView = dueDatePicker
        
        dueDatePicker.datePickerMode = .date
    }
    
    
    @objc func donePressedDueDate(){
        //format date
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: dueDatePicker.date)
        
        dueDateTextField.text = "\(dateString)"
        self.view.endEditing(true)
    }
}
