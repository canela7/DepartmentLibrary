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
    
    //var selectedItem: DepartmentLibrary?
    
    var delegateForCheckout: DepartmentLibrary?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDatePicker()

        let dateString = dateFormatter(with: datepicker.date)
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
        
        let dateBorrow = dateFormatterFromStringToDate(with: dateBorrowed)
        let dueDateItem = dateFormatterFromStringToDate(with: dueDate)

         print(studentName, cin, dateBorrowed, dueDate);
        
        do{
            try realm.write {
                if let currentItemList = self.delegateForCheckout {
                    let newItem = CheckoutLogModel()
                    newItem.studentName = studentName
                    newItem.cin = Int(cin)!
                    newItem.dateBorrowed = dateBorrow
                    newItem.dueCreated = dueDateItem
                    currentItemList.checkoutlog.append(newItem)
                }
            }
        }catch{
            print("Error saving context \(error)")
        }
        
        performSegue(withIdentifier: "goToDepartmentLibaray", sender: self)
        
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
    
    //when u press done button in the toolbar of the due date picker
    @objc func donePressedDueDate(){
        
        let dateStringer  = dateFormatter(with: dueDatePicker.date)
        
        dueDateTextField.text = "\(dateStringer)"
        self.view.endEditing(true)
    }
    
    //date formate from date to string
        func dateFormatter(with dateString: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            let date = dateFormatter.string(from: dateString)
            return date
        
        }
    
    
    func dateFormatterFromStringToDate(with dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let date = dateFormatter.date(from: dateString)
        return date!
        
    }
        
        
        
        
  
}
