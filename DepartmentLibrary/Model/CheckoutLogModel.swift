//
//  CheckoutLogModel.swift
//  DepartmentLibrary
//
//  Created by Brian Canela on 6/12/18.
//  Copyright © 2018 Brian Canela. All rights reserved.
//

import Foundation
import RealmSwift


class CheckoutLogModel: Object  {
    
    @objc dynamic var studentName: String = ""
    @objc dynamic  var cin: Int = 0
    @objc dynamic  var dateBorrowed: Date!
    @objc dynamic  var dueCreated : Date?
    @objc dynamic  var dateReturned : Date?
    
    var parentItem = LinkingObjects(fromType: DepartmentLibrary.self, property: "checkoutlog")

    
    //THIS IS FOR USER CHECKOUT TEEST, testing new one!
    //this is usercheckout branch
    

    
    
    
    
}
