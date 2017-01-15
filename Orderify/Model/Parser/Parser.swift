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
    var orders = Array<Order>()
    var countries = Dictionary<String, Int>()
    var totalCost = 0.0
    
    static let countryFlags        = ["US" : "🇺🇸",
                                      "CA" : "🇨🇦"]
    static let restCountriesFlag   = "🏳️"
    
    convenience init(url: URL?) {
        self.init()
        
        if let url = url {
            parseJSON(localUrl: url)
        } else {
            if let path = Bundle.main.path(forResource: "orders", ofType: "json") {
                if let localUrl = URL.init(string: path) {
                    parseJSON(localUrl: localUrl)
                }
            }
        }
    }
    
    func parseJSON(localUrl url: URL) {
        let data = try! Data.init(contentsOf: url)
        let json = JSON.init(data: data)
        var totalPrice = 0.0
        
        if let orders = json["orders"].array {
            for orderJSON in orders {
                if let order = Order.init(json: orderJSON) {
                    self.orders.append(order)
                    totalPrice += order.totalPriceUSD
                    
                    if let country = order.customer?.defaultAddress?.countryCode {
                        if let _ = countries[country] {
                            countries[country]! += 1
                        } else {
                            countries[country] = 1
                        }
                    }
                    
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
        
        totalCost = totalPrice
    }
}
