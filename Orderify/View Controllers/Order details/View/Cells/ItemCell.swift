//
//  ItemCell.swift
//  Orderify
//
//  Created by Roudique on 1/13/17.
//  Copyright © 2017 roudique.com. All rights reserved.
//

import UIKit


class ItemCell: UITableViewCell {
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var gramsLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    
    
    
    
    static func identifier() -> String {
        return "ItemCell"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(item: Item) {
        idLabel.text = "id: \(item.id)"
        quantityLbl.text = "qnt: \(item.quantity)"
        titleLbl.text = "title: \(item.title)"
        priceLbl.text = "price: \(item.price)"
        gramsLbl.text = "grams: \(item.grams)"
        nameLbl.text = "name: \(item.name)"
    }

}
