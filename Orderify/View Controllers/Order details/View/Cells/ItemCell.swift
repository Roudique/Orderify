//
//  ItemCell.swift
//  Orderify
//
//  Created by Roudique on 1/13/17.
//  Copyright © 2017 roudique.com. All rights reserved.
//

import UIKit


let kGramsInKilogram = 1_000


class ItemCell: UITableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var gramsLbl: UILabel!
    
    
    //MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLbl.adjustsFontSizeToFitWidth = true
    }
    
    
    //MARK: - Public
    
    static func identifier() -> String {
        return "ItemCell"
    }
    
    func configure(item: Item) {
        titleLbl.text = "Title:  \(item.title)"
        priceLbl.text = "💵 $\(item.price) x \(item.quantity) = $\(item.price * Double(item.quantity))"
        
        if item.grams > kGramsInKilogram {
            gramsLbl.text = "📦 \(item.grams / kGramsInKilogram).\(item.grams % kGramsInKilogram) kilograms"
        } else {
            gramsLbl.text = "📦 \(item.grams) grams"
        }
    }
}
