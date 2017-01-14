//
//  StatisticsCell.swift
//  Orderify
//
//  Created by Roudique on 1/10/17.
//  Copyright © 2017 roudique.com. All rights reserved.
//

import UIKit


let kShowMore = "Show more"
let kShowLess = "Show less"

let kPaid     = "paid"
let kNotPaid  = "not paid"


class StatisticsCell: UITableViewCell {
    @IBOutlet weak var orderNameLabel: UILabel!
    @IBOutlet weak var paidLabel: UILabel!
    @IBOutlet weak var itemsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var showMoreBtn: UIButton!
    @IBOutlet weak var btnBotConstraint: NSLayoutConstraint!
    @IBOutlet weak var wrapperView: UIView!
    
    
    //MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        paidLabel.adjustsFontSizeToFitWidth = true
        wrapperView.applyGradient(colors: [UIColor(red:0.68, green:0.80, blue:0.91, alpha:1.00),
                                           UIColor(red:0.47, green:0.62, blue:0.76, alpha:1.00)
                                           ],
                                  start: .left,
                                  end: .right)
        
        nameLabel.adjustsFontSizeToFitWidth  = true
        emailLabel.adjustsFontSizeToFitWidth = true
        
    }
    
    
    //MARK: - Public
    
    func configure(with order: Order) {
        orderNameLabel.text = order.name
        
        if let paid = order.paid {
            paidLabel.text      = paid ? kPaid : kNotPaid
            paidLabel.textColor = paid ? .statisticCellPaidColor() : .statisticCellNotPaidColor()
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
        
        let showText = veryBottom ? kShowLess : kShowMore
        self.showMoreBtn.setTitle(showText, for: .normal)
    }

}
