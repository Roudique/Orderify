//
//  MainController.swift
//  Orderify
//
//  Created by Roudique on 1/8/17.
//  Copyright © 2017 roudique.com. All rights reserved.
//

import UIKit

let kParseSegueId = "parseSegue"

class MainController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.applyGradient(colours: [UIColor(red:0.13, green:0.23, blue:0.36, alpha:1.00),
                                     UIColor(red:0.55, green:0.53, blue:0.62, alpha:1.00)])
    }
    
    @IBAction func parseDefault(_ sender: Any) {
        performSegue(withIdentifier: kParseSegueId, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kParseSegueId {
            let parser = Parser.init()
            let statisticsController = segue.destination as! StatisticsController
            statisticsController.orders = parser.orders
        }
        
    }
    
}
