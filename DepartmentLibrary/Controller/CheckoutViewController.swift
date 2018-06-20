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
    
    
    @IBOutlet weak var dateBorrowedLabel: UILabel!
    
    @IBOutlet weak var dueDateTextField: UITextField!
    
   
    var dueDatePicker = UIDatePicker()
    
    //use for today date
    var datepicker = UIDatePicker()
    let formatter = DateFormatter()
    
    
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
