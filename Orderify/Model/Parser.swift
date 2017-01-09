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
    var orders : Array<Order>
    
    init() {
        self.orders = Array<Order>.init()

        if let path = Bundle.main.path(forResource: "orders", ofType: "json") {
            let url = URL.init(fileURLWithPath: path)
            let data = try! Data.init(contentsOf: url)
            let json = JSON.init(data: data)

            if let orders = json["orders"].array {
                
                for orderJSON in orders {
                    if let order = Order.init(json: orderJSON) {
                        self.orders.append(order)
                    }
                }
            }
        }
    }
}
