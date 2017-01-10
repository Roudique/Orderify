//
//  StatisticsCell.swift
//  Orderify
//
//  Created by Roudique on 1/10/17.
//  Copyright © 2017 roudique.com. All rights reserved.
//

import UIKit

class StatisticsCell: UITableViewCell {
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var orderNameLabel: UILabel!
    @IBOutlet weak var paidLabel: UILabel!
    @IBOutlet weak var itemsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var showMoreBtn: UIButton!
    @IBOutlet weak var btnBotConstraint: NSLayoutConstraint!
    @IBOutlet weak var wrapperView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        paidLabel.adjustsFontSizeToFitWidth = true
        wrapperView.applyGradient(colors: [UIColor(red:0.54, green:0.69, blue:0.79, alpha:1.00),
                                           UIColor(red:0.83, green:0.88, blue:0.92, alpha:1.00)],
                                  start: .left,
                                  end: .right)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with order: Order) {
        orderNameLabel.text = "\(order.id)"
        orderNumberLabel.text = order.name
        if let paid = order.paid {
            paidLabel.text = paid ? "paid" : "not paid"

        }
        if let customer = order.customer {
            nameLabel.text = "\(customer.firstName) \(customer.lastName)"
            emailLabel.text = order.customer?.email
        }
        
        var itemsString = order.lineItems.count > 1 ? "items" : "item"
        if order.lineItems.count == 0 { itemsString = "items" }
        
        itemsLabel.text = "$\(order.totalPriceUSD) total, \(order.lineItems.count) " + itemsString
    }
    
    func addBottomConstraint(veryBottom: Bool) {
        btnBotConstraint.isActive = false
        
        if veryBottom {
            btnBotConstraint = NSLayoutConstraint.init(item: self.showMoreBtn,
                                                       attribute: .bottom,
                                                       relatedBy: .equal,
                                                       toItem: emailLabel,
                                                       attribute: .bottom,
                                                       multiplier: 1.0,
                                                       constant: 0)
        } else {
            btnBotConstraint = NSLayoutConstraint.init(item: self.showMoreBtn,
                                                       attribute: .bottom,
                                                       relatedBy: .equal,
                                                       toItem: nameLabel,
                                                       attribute: .top,
                                                       multiplier: 1.0,
                                                       constant: 0)
        }
        btnBotConstraint.priority = 1000
        btnBotConstraint.isActive = true
    }

}
