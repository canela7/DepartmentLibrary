//
//  ReturnItemViewController.swift
//  DepartmentLibrary
//
//  Created by Brian Canela on 6/24/18.
//  Copyright © 2018 Brian Canela. All rights reserved.
//

import UIKit
import RealmSwift

class ReturnItemViewController: UIViewController {

    @IBOutlet weak var itemNameReturnLabel: UILabel!
    
    @IBOutlet weak var studentNameReturnLabel: UILabel!
    
    @IBOutlet weak var studentCinReturnLabel: UILabel!
    
    @IBOutlet weak var dueDateReturnLabel: UILabel!
    
    @IBOutlet weak var todayDateReturnLabel: UILabel!
    
    @IBOutlet weak var returnButton: UIButton!
    
    
    var delegateDepartmentLibraryData: DepartmentLibrary?
    
    var delegateCheckoutData: CheckoutLogModel?
    
    
    let realm = try! Realm()
    
    let datepicker = UIDatePicker()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Returning Item \(delegateDepartmentLibraryData?.name ?? "Returning Item")"
        
        if let returnItem = delegateDepartmentLibraryData {
            itemNameReturnLabel.text = returnItem.name
            
//            if returnItem.available {
//                returnButton.isEnabled = false
//            }else {
//                returnButton.isEnabled = true
//            }
            
        }
        

        
        
        if let returnItem = delegateCheckoutData {
            studentNameReturnLabel.text = "Student Name:  \(returnItem.studentName)"
            studentCinReturnLabel.text = "Student CIN: \(returnItem.cin)"
            
            let dateString = dateFormatter(with: returnItem.dueCreated!)
            dueDateReturnLabel.text = "Due Date: \(dateString)"
        }
        
        let dateString = dateFormatter(with: datepicker.date)
        todayDateReturnLabel.text = "Returning  date: \(dateString)"
        
        
        
        
    }

    
    
    @IBAction func returnButtonPressed(_ sender: Any) {
        
        
        if let returnItem = delegateDepartmentLibraryData, let returnUserDate = delegateCheckoutData {
            do{
                try realm.write {
                       returnItem.available = !returnItem.available
                    
                       returnUserDate.dateReturned = Date()
                    
                }
            }catch{
                print("Error deleting category \(error)")
            }
        }
        
       //performSegue(withIdentifier: "goToDepartmentLibarayFromReturn", sender: self)
        
        
    }
    
    
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

