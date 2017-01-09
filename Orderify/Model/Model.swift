//
//  Order.swift
//  Orderify
//
//  Created by Roudique on 1/8/17.
//  Copyright © 2017 roudique.com. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol JSONInitializable {
    init?(json: JSON)
}

struct Address {
    var firstName   : String
    var lastName    : String
    
    var address1    : String
    var address2    : String?
    var city        : String?
    var zip         : String?
    var province    : String?
    var country     : String
    
    var countryCode  : String
    var provinceCode : String
    
}

class Item : JSONInitializable {
    var id : Int
    var quantity : Int
    var title : String
    var price : Double
    var grams : Int
    var name : String?
    
    init(id: Int, quantity: Int, title: String, price : Double, grams: Int, name : String?) {
        self.id = id
        self.quantity = quantity
        self.title = title
        self.price = price
        self.grams = grams
        self.name = name
    }
    
    required init?(json: JSON) {
        let id          = json["id"].int
        let quantity    = json["quantity"].int
        let title       = json["title"].string
        let priceString = json["price"].string
        let grams       = json["grams"].int
        let name        = json["name"].string
        
        if let id = id, let quantity = quantity, let title = title, let priceString = priceString, let grams = grams {
            self.id         = id
            self.quantity   = quantity
            self.title      = title
            self.price      = Double.init(priceString) ?? 0.0
            self.grams      = grams
            self.name       = name
        } else {
            return nil
        }
    }
}

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

class Order : JSONInitializable {
    var id : Int
    var name : String
    var email : String
    var paid : Bool?
    var totalPriceUSD : Double
    var lineItems : Array<Item>
    
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
        } else {
            return nil
        }
    }
}

