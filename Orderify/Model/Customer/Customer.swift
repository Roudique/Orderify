//
//  Customer.swift
//  Orderify
//
//  Created by Roudique on 1/9/17.
//  Copyright © 2017 roudique.com. All rights reserved.
//

import Foundation
import SwiftyJSON

class Customer {
    var id : Int
    var email : String
    
    var firstName : String
    var lastName : String
    
    var ordersCount : Int?
    var totalSpent : Double?
    
    var defaultAddress : Address?
    
    init(id: Int, email: String, firstName: String, lastName: String) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
    }
}
