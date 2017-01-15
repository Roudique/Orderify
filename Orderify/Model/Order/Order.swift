//
//  Order.swift
//  Orderify
//
//  Created by Roudique on 1/9/17.
//  Copyright © 2017 roudique.com. All rights reserved.
//

import Foundation
import SwiftyJSON

class Order : JSONInitializable {
    var id : Int
    var name : String
    var email : String
    var paid : Bool?
    var totalPriceUSD : Double
    var lineItems : Array<Item>
    var customer : Customer?
    var shippingAddress : Address?
    
    init(id: Int, name: String, email: String, totalPrice: Double) {
        self.id = id
        self.name = name
        self.email = email
        self.totalPriceUSD = totalPrice
        self.lineItems = Array<Item>.init()
    }
    
    required init?(json: JSON) {
        let id      = json["id"].int
        let name    = json["name"].string
        let email   = json["email"].string
        let price   = json["total_price_usd"].string
        
        if let id = id, let name = name, let email = email, let price = price {
            self.id             = id
            self.name           = name
            self.email          = email
            self.totalPriceUSD  = Double.init(price) ?? 0.0
            self.lineItems      = Array<Item>.init()
            self.customer       = Customer.init(json: json["customer"])
            self.shippingAddress = Address.init(json: json["shipping_address"])
            
            if let financialStatus = json["financial_status"].string {
                self.paid = financialStatus == "paid"
            }
        } else {
            return nil
        }
    }
}
