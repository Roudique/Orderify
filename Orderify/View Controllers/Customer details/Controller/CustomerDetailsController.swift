//
//  CustomerDetailsController.swift
//  Orderify
//
//  Created by Roudique on 1/14/17.
//  Copyright © 2017 roudique.com. All rights reserved.
//

import UIKit

class CustomerDetailsController: BaseViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var ordersLabel: UILabel!
    @IBOutlet weak var totalSpentLabel: UILabel!
    
    @IBOutlet weak var personIconImageView: UIImageView!
    
    var customer : Customer!
    var address = Array<String>()
    
    
    //MARK: - Lifecycle
        
    override func viewDidLoad() {
        super.viewDidLoad()

        load(customer: customer)
        prepareHeroIDs()
        prepareAddress()
    }
    
    
    //MARK: - Private
    
    func prepareHeroIDs() {
        nameLabel.heroID = kHeroCustomerNameID
        emailLabel.heroID = kHeroCustomerEmailID
        personIconImageView.heroID = kHeroPersonIconID
    }
    
    func load(customer: Customer) {
        nameLabel.text = "\(customer.firstName) \(customer.lastName)"
        emailLabel.text = "✉️ \(customer.email)"
        
        phoneLabel.text = "☎️ \(customer.phoneNumber ?? "no number")"
        ordersLabel.text = "Total orders: \(customer.ordersCount ?? 0)"
        totalSpentLabel.text = "Total spent: \(customer.totalSpent ?? 0) USD"
    }
    
    func prepareAddress() {
        if let defaultAddress = customer.defaultAddress {
            address.append(defaultAddress.address1)
            
            if let address2 = defaultAddress.address2 {
                address.append(address2)
            }
            
            if let city = defaultAddress.city {
                address.append("🏙 \(city)")
            }
            
            if let zip = defaultAddress.zip {
                address.append("Zip: \(zip)")
            }
            
            if let province = defaultAddress.province {
                address.append("Province/state: \(province)")
            }
            
            address.append(defaultAddress.country)
        }
    }
    
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return address.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressCell.identifier()) as! AddressCell
        
        cell.addressLabel.text = address[indexPath.row]
        
        return cell
    }
}
