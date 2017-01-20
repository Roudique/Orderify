//
//  APIManager.swift
//  Orderify
//
//  Created by Roudique on 1/19/17.
//  Copyright © 2017 roudique.com. All rights reserved.
//

import Foundation
import SwiftyJSON

let kBaseResourceLink   = "https://shopicruit.myshopify.com/admin/"
let kOrdersKey          = "orders.json?page="
let kAccessTokenKey     = "access_token=c32313df0d0ef512ca64d5b336a0d7c6"

class APIManager {
    static let shared = APIManager()
    let parser = Parser()
    var page = 0
    
    func fetchOrders(_ orders: NSArray, with completion: @escaping ([Order]) -> ()) {
        let session = URLSession.init(configuration: .default,
                                      delegate: nil,
                                      delegateQueue: nil)
        print("I got orders: \(orders.count)")
        
        let url = URL.init(string: buildLink(with: page))!
        print("Next page is #\(page)")
        
        let task = session.dataTask(with: url) { data, response, error in
            
            print("Data arrived")
            self.page += 1
            
            if let data = data {
                let json = JSON.init(data: data)
                let fetched = self.parser.parse(json: json)
                
                if fetched.count > 0 {
                    self.fetchOrders(orders.addingObjects(from: fetched) as NSArray, with: completion)
                } else {
                    var ordersToReturn = [Order]()
                    
                    for item in orders {
                        if let order = item as? Order {
                            ordersToReturn.append(order)
                        }
                    }
                    completion(ordersToReturn)
                }
                
            }
        }
        task.resume()
    }
    
    
    func buildLink(with page: Int) -> String {
        return "\(kBaseResourceLink)\(kOrdersKey)\(page)&\(kAccessTokenKey)"
    }
}
