//
//  OrderDetailsController.swift
//  Orderify
//
//  Created by Roudique on 1/13/17.
//  Copyright © 2017 roudique.com. All rights reserved.
//

import UIKit

class OrderDetailsController: BaseViewController {
    var order : Order!

    @IBOutlet weak var orderNameLbl: UILabel!
    @IBOutlet weak var orderPriceLbl: UILabel!
    
    @IBOutlet weak var customerNameLbl: UILabel!
    @IBOutlet weak var customerEmailLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        load(order: order)
    }
    
    
    //MARK: - Private
    
    fileprivate func load(order: Order) {
        orderNameLbl.text   = order.name
        orderPriceLbl.text  = "$\(order.totalPriceUSD)"
        
        if let customer = order.customer {
            customerNameLbl.text    = "\(customer.firstName) \(customer.lastName)"
            customerEmailLbl.text   = "✉️\(customer.email)"
        } else {
            customerNameLbl.text    = ""
            customerEmailLbl.text   = ""
        }
    }
}
