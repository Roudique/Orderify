//
//  OrderDetailsController.swift
//  Orderify
//
//  Created by Roudique on 1/13/17.
//  Copyright © 2017 roudique.com. All rights reserved.
//

import UIKit
import Hero


let kCustomerDetailsSegueId = "kCustomerDetailsSegue"
let kHeroPersonIconID       = "kHeroPersonIconID"


class OrderDetailsController: BaseViewController,
                              UITableViewDelegate, UITableViewDataSource,
                              HeroViewControllerDelegate {
    var order : Order!

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var orderNameLbl: UILabel!
    @IBOutlet weak var orderPriceLbl: UILabel!
    
    @IBOutlet weak var customerNameLbl: UILabel!
    @IBOutlet weak var customerEmailLbl: UILabel!
    
    @IBOutlet weak var noLabel: UILabel!
    @IBOutlet weak var infoBtn: UIButton!
    @IBOutlet weak var personIconImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        load(order: order)
        
        orderNameLbl.heroID         = kHeroOrderNameID
        orderPriceLbl.heroID        = kHeroItemID
        customerNameLbl.heroID      = kHeroCustomerNameID
        customerEmailLbl.heroID     = kHeroCustomerEmailID
        noLabel.heroID              = kHeroNoID
        personIconImageView.heroID  = kHeroPersonIconID
        
        infoBtn.heroModifiers = [.fade, .scale(0.5)]
        personIconImageView.heroModifiers = [.fade, .scale(0.5)]
        tableView.heroModifiers = [.fade, .scale(0.5)]
    }
    
    func heroDidEndTransition() {
        customerNameLbl.heroID = nil
        customerEmailLbl.heroID = nil
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kCustomerDetailsSegueId, let customer = sender as? Customer {
            let customerController = segue.destination as! CustomerDetailsController
            
            customerController.customer = customer
            
            customerNameLbl.heroID      = kHeroCustomerNameID
            customerEmailLbl.heroID     = kHeroCustomerEmailID
        }
    }
    
    
    //MARK: - Actions
    
    @IBAction func customerDetailsAction(_ sender: Any) {
        performSegue(withIdentifier: kCustomerDetailsSegueId, sender: order.customer)
    }
    
    
    //MARK: - UITableViewDelegate
    
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return order.lineItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.identifier()) as! ItemCell
        
        cell.configure(item: order.lineItems[indexPath.row])
        
        return cell
    }
}
