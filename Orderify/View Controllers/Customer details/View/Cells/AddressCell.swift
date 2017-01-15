//
//  AddressCellTableViewCell.swift
//  Orderify
//
//  Created by Roudique on 1/14/17.
//  Copyright © 2017 roudique.com. All rights reserved.
//

import UIKit

class AddressCell: UITableViewCell {
    @IBOutlet weak var addressLabel: UILabel!
    
    static func identifier() -> String {
        return "AddressCell"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
