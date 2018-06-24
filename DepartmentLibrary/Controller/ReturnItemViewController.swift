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
    
    
    
    var delegateDepartmentLibraryData: DepartmentLibrary?
    
    var delegateCheckoutData: CheckoutLogModel?
    
    
    let realm = try! Realm()
    
    let datepicker = UIDatePicker()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Returning Item \(delegateDepartmentLibraryData?.name ?? "Returning Item")"
        
        if let returnItem = delegateDepartmentLibraryData {
            itemNameReturnLabel.text = returnItem.name
        }
        
        
        if let returnItem = delegateCheckoutData {
            studentNameReturnLabel.text = "Student Name:  \(returnItem.studentName)"
            studentCinReturnLabel.text = "Student CIN: \(returnItem.cin)"
            dueDateReturnLabel.text = ",,,"
        }
        
           
       
        
        
        
        let dateString = dateFormatter(with: datepicker.date)
        todayDateReturnLabel.text = "Return date \(dateString)"
        
    }

    
    
    @IBAction func returnButtonPressed(_ sender: Any) {
        
        
        
        
    }
    
    
    func dateFormatter(with dateString: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let date = dateFormatter.string(from: dateString)
        return date
        
    }
    
}

