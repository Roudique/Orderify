//
//  BaseViewController.swift
//  Orderify
//
//  Created by Roudique on 1/13/17.
//  Copyright © 2017 roudique.com. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.applyGradient(colours: [UIColor(red:0.13, green:0.23, blue:0.36, alpha:1.00),
                                     UIColor(red:0.55, green:0.53, blue:0.62, alpha:1.00)])
    }

}
