//
//  OrderifyTests.swift
//  OrderifyTests
//
//  Created by Roudique on 1/8/17.
//  Copyright © 2017 roudique.com. All rights reserved.
//

import XCTest
@testable import Orderify

class OrderifyTests: XCTestCase {
    var parser : Parser?
    var orders : Array<Order> {
        return parser!.orders
    }
    
    
    //MARK: - Preparations
    
    override func setUp() {
        super.setUp()
        
        if let path = Bundle.main.path(forResource: "orders", ofType: "json") {
            let url = URL.init(fileURLWithPath: path)
            parser = Parser.init(url: url)
            
            XCTAssert((parser?.orders.count)! > 0)
        } else {
            XCTAssert(false)
        }
    }
    
    override func tearDown() {
        parser = nil
        
        super.tearDown()
    }
    
    
    //MARK: - Order
    
    func testOrderHasLineItems() {
        for order in orders {
            XCTAssert(order.lineItems.count > 0)
        }
    }
    
    func testOrderHasCustomer() {
        for order in orders {
            XCTAssert(order.customer != nil)
        }
    }
    
    func testOrderHasShippingAddress() {
        for order in orders {
            XCTAssert(order.shippingAddress != nil)
        }
    }
    
    
    //MARK: - Item
    
    func testItemProperties() {
        for order in orders {
            for item in order.lineItems {
                XCTAssert(item.id > 0)
                XCTAssert(item.quantity > 0)
                XCTAssert(item.price > 0)
                XCTAssert(item.grams > 0)
            }
        }
    }
    
    func testItemHasName() {
        for order in orders {
            for item in order.lineItems {
                XCTAssert(item.name != nil)
            }
        }
    }
    
    
    //MARK: - Customer
    
    func testCustomerProperties() {
        for order in orders {
            if let customer = order.customer {
                XCTAssert(customer.id > 0)
                XCTAssert(customer.firstName.characters.count > 0)
                XCTAssert(customer.lastName.characters.count > 0)
                XCTAssert(customer.email.characters.count > 0)
            }
        }
    }
    
    func testCustomerOrders() {
        for order in orders {
            if let customer = order.customer {
                XCTAssert(customer.ordersCount != nil)
                XCTAssert(customer.ordersCount! > 0)
            }
        }
    }
    
    func testCustomerTotalSpent() {
        for order in orders {
            if let customer = order.customer {
                XCTAssert(customer.totalSpent != nil)
            }
        }
    }
    
    
    //MARK: - Address
    
    func testAddressProperties() {
        for order in orders {
            if let address = order.shippingAddress {
                XCTAssert(address.firstName.characters.count > 0)
                XCTAssert(address.lastName.characters.count > 0)
                XCTAssert(address.address1.characters.count > 0)
                XCTAssert(address.country.characters.count > 0)
                XCTAssert(address.countryCode.characters.count > 1)
            }
        }
    }
    
    
    //MARK: - Performance
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            if let path = Bundle.main.path(forResource: "orders", ofType: "json") {
                let url = URL.init(fileURLWithPath: path)
                self.parser = Parser.init(url: url)
            } else {
                XCTAssert(false)
            }
        }
    }
    
}
