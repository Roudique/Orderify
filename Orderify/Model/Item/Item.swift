//
//  Item.swift
//  Orderify
//
//  Created by Roudique on 1/9/17.
//  Copyright © 2017 roudique.com. All rights reserved.
//

import Foundation
import SwiftyJSON

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
