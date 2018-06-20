//
//  DepartmentLibrary.swift
//  DepartmentLibrary
//
//  Created by Brian Canela on 6/12/18.
//  Copyright © 2018 Brian Canela. All rights reserved.
//


import RealmSwift

class DepartmentLibrary: Object {
    

    @objc dynamic var name: String = ""
    @objc dynamic var authorName: String = ""
    @objc dynamic var additionalInformation: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var available: Bool = true
    
    //let checkoutlog = List<CheckoutLogModel>()
    
    
//    convenience init(name: String, authorName:String, additionalInformation: String, type: String, available: Bool){
//        self.init()
//        self.name = name
//        self.authorName = authorName
//        self.additionalInformation = additionalInformation
//        self.type = type
//        self.available = available
//    }
    
    
   
    
  
    
}
