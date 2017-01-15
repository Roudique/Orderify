//
//  Customer.swift
//  Orderify
//
//  Created by Roudique on 1/9/17.
//  Copyright © 2017 roudique.com. All rights reserved.
//

import Foundation
import SwiftyJSON

class Customer : JSONInitializable {
    var id : Int
    var email : String
    
    var firstName : String
    var lastName : String
    
    var ordersCount : Int?
    var totalSpent : Double?
    
    var defaultAddress : Address?
    var phoneNumber : String?
    
    init(id: Int, email: String, firstName: String, lastName: String) {
        self.id         = id
        self.email      = email
        self.firstName  = firstName
        self.lastName   = lastName
    }
    
    required convenience init?(json: JSON) {
        let id              = json["id"].int
        let email           = json["email"].string
        let firstName       = json["first_name"].string
        let lastName        = json["last_name"].string
        
        if let id = id, let email = email, let firstName = firstName, let lastName = lastName {
            self.init(id: id, email: email, firstName: firstName, lastName: lastName)
            self.defaultAddress = Address.init(json: json["default_address"])
            self.totalSpent     = 0.0
            self.ordersCount    = json["orders_count"].int
            phoneNumber = defaultAddress?.phoneNumber
        } else {
            return nil
        }
    }
}
