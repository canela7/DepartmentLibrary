//
//  CheckoutViewController.swift
//  DepartmentLibrary
//
//  Created by Brian Canela on 6/19/18.
//  Copyright © 2018 Brian Canela. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController {

    @IBOutlet weak var studentNameTextField: UITextField!
    
    @IBOutlet weak var studentCinTextField: UITextField!
    
    
    @IBOutlet weak var dateBorrowedTextField: UITextField!
    
    @IBOutlet weak var dueDateTextField: UITextField!
    
    var datepicker = UIDatePicker()
    var dueDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDatePicker()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}


extension CheckoutViewController {
    func createDatePicker(){
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let toolbarDueDate = UIToolbar()
        toolbarDueDate.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedDatePicker))
        toolbar.setItems([done], animated: true)
        
        
        let doneDueDate = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedDueDate))
        toolbarDueDate.setItems([doneDueDate], animated: true)
        
        dateBorrowedTextField.inputAccessoryView = toolbar
        dateBorrowedTextField.inputView = datepicker
        
        dueDateTextField.inputAccessoryView = toolbarDueDate
        dueDateTextField.inputView = dueDatePicker
        
        
        datepicker.datePickerMode = .date
        dueDatePicker.datePickerMode = .date
    }
    
    @objc func donePressedDatePicker() {
        //format date
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: datepicker.date)
        
        dateBorrowedTextField.text = "\(dateString)"
        self.view.endEditing(true)
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
