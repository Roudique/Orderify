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
    var session = URLSession.init(configuration: .default,
                                  delegate: nil,
                                  delegateQueue: nil)
    var page = 1
    
    func fetchOrders(_ orders: NSArray, with completion: @escaping ([Order]) -> ()) {
        let url = URL.init(string: buildLink(with: page))!
        
        let task = session.dataTask(with: url) { data, response, error in
            self.page += 1
            
            if let data = data {
                let json = JSON.init(data: data)
                let fetched = self.parser.parse(json: json)
                
                if fetched.count > 0 {
                    self.fetchOrders(orders.addingObjects(from: fetched) as NSArray, with: completion)
                } else {
                    let ordersToReturn = self.convertToOrdersArray(orders)
                    
                    self.page = 1
                    completion(ordersToReturn)
                }
            } else {
                completion(self.convertToOrdersArray(orders))
            }
        }
        task.resume()
    }
    
    func fetchOrders(from url: URL, completion: @escaping ([Order]) -> ()) {
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                let json = JSON.init(data: data)
                completion(self.parser.parse(json: json))
            }
        }
        task.resume()
    }
    
    
    //MARK: - Private
    
    fileprivate func buildLink(with page: Int) -> String {
        return "\(kBaseResourceLink)\(kOrdersKey)\(page)&\(kAccessTokenKey)"
    }
    
    fileprivate func convertToOrdersArray(_ orders: NSArray) -> [Order] {
        var ordersToReturn = [Order]()
        
        for item in orders {
            if let order = item as? Order {
                ordersToReturn.append(order)
            }
        }
        
        return ordersToReturn
    }
}
