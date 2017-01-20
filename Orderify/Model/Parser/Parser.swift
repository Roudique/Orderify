//
//  Parser.swift
//  Orderify
//
//  Created by Roudique on 1/8/17.
//  Copyright © 2017 roudique.com. All rights reserved.
//

import Foundation
import SwiftyJSON

class Parser {
    var totalCost = 0.0
    
    static let countryFlags        = ["US" : "🇺🇸",
                                      "CA" : "🇨🇦"]
    static let restCountriesFlag   = "🏳️"
    
    static func getCountries(from orders: [Order]) -> Dictionary<String, Int> {
        var countries = Dictionary<String, Int>()
        for order in orders {
            if let country = order.customer?.defaultAddress?.countryCode {
                if let _ = countries[country] {
                    countries[country]! += 1
                } else {
                    countries[country] = 1
                }
            }
        }
        return countries
    }
    
    func parse(json: JSON) -> [Order] {
        var orders = [Order]()
        
        if let ordersJSON = json["orders"].array {
            for orderJSON in ordersJSON {
                if let order = Order.init(json: orderJSON) {
                    orders.append(order)
                    
                    if let items = orderJSON["line_items"].array {
                        for itemJSON in items {
                            if let item = Item.init(json: itemJSON) {
                                order.lineItems.append(item)
                            }
                        }
                    }
                }
            }
        }
        
        orders.sort { (first, second) -> Bool in
            if let id1 = Int.init(first.name.replacingOccurrences(of: "#", with: "")), let id2 = Int.init(second.name.replacingOccurrences(of: "#", with: "")) {
                return id1 < id2
            }
            return true
        }
        
        return orders
    }
    
    static func totalPrice(for orders: [Order]) -> Double {
        var totalPrice = 0.0
        for order in orders {
            totalPrice += order.totalPriceUSD
        }
        return totalPrice
    }
}
