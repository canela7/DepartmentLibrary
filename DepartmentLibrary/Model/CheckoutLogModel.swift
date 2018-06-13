//
//  CheckoutLogModel.swift
//  DepartmentLibrary
//
//  Created by Brian Canela on 6/12/18.
//  Copyright © 2018 Brian Canela. All rights reserved.
//

import Foundation


class CheckoutLogModel  {
    
    var cin: Int
    var studentName = ""
    var dateBorrowed: Date!
    var dueDate: Date?
    
    
    init(cin: Int) {
        self.cin = cin
    }
    
    
    
    
}
