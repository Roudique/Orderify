//
//  StatisticsController.swift
//  Orderify
//
//  Created by Roudique on 1/8/17.
//  Copyright © 2017 roudique.com. All rights reserved.
//

import UIKit
import Hero

let kStatisticCellId            = "statisticCellId"

let kShowOrderSegueId           = "kShowOrderDetailsSegueId"

let kHeroOrderNameID            = "orderNameLabel"
let kHeroItemID                 = "itemsLabel"
let kHeroCustomerNameID         = "customerNameLabel"
let kHeroCustomerEmailID        = "customerEmailLabel"
let kHeroNoID                   = "noLabel"

let kPullLimit : CGFloat        = 150.0
let kCellHeight : CGFloat       = 136.0
let kCellHiddenHeight : CGFloat = 54.0


class StatisticsController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var graphHeightConstraints: [NSLayoutConstraint]!

    @IBOutlet weak var canadaLabel: UILabel!
    @IBOutlet weak var usLabel: UILabel!
    @IBOutlet weak var restLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var orders : Array<Order>?
    var countries : Dictionary<String, Int>?
    var totalPrice : Double = 0
    var selectedCells = [Int]()
    
    var graphHeight : CGFloat {
        var height : CGFloat = 0.0
        for constraint in graphHeightConstraints {
            height += constraint.constant
        }
        return height
    }
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.heroModifiers = [.fade, .scale(0.5)]
        
        prepareCountriesStats()
        prepareTotalPrice()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    //MARK: - Private
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kShowOrderSegueId {
            if let controller = segue.destination as? OrderDetailsController, let order = sender as? Order {
                controller.order = order
            }
        }
    }
    
    func prepareCountriesStats() {
        if let countries = countries {
            if let canadianFlag = Parser.countryFlags["CA"] {
                let canadianOrders = countries["CA"] ?? 0
                canadaLabel.text = "\(canadianFlag): \(canadianOrders)"
            }
            
            if let usFlag = Parser.countryFlags["US"] {
                let usOrders = countries["US"] ?? 0
                usLabel.text = "\(usFlag): \(usOrders)"
            }
            
            var restOrders = 0
            for country in countries {
                if !["US", "CA"].contains(country.key) {
                    restOrders += country.value
                }
            }
            restLabel.text = "\(Parser.restCountriesFlag): \(restOrders)"
        }
    }
    
    func prepareTotalPrice() {
        totalPriceLabel.text = "Total orders' cost: \(totalPrice) USD"
    }
    

    // MARK: - Actions
    
    func showMoreAction(sender: UIButton) {
        guard let superView     = sender.superview else { return }
        guard let contentView   = superView.superview else { return }
        guard let cell          = contentView.superview as? StatisticsCell else { return }
        guard let indexPath     = tableView.indexPath(for: cell) else { return }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let isSelected = cellIsSelected(indexPath: indexPath)
        if isSelected {
            selectedCells.remove(at: selectedCells.index(of: indexPath.row)!)
        } else {
            selectedCells.append(indexPath.row)
        }
        
        cell.addBottomConstraint(veryBottom: !isSelected)

        UIView.animate(withDuration: 0.2) {
            self.tableView.beginUpdates()
            cell.layoutIfNeeded()
            self.tableView.endUpdates()
        }
        
    }
    
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < -kPullLimit {
            dismiss(animated: true, completion: nil)
        }
    }

    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = orders?.count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if cellIsSelected(indexPath: indexPath) {
            return kCellHeight
        }
        return kCellHeight - kCellHiddenHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kStatisticCellId, for: indexPath) as! StatisticsCell
        
        if let order = orders?[indexPath.row] {
            cell.configure(with: order)
            cell.showMoreBtn.addTarget(self, action: #selector(showMoreAction(sender:)), for: .touchUpInside)
            cell.addBottomConstraint(veryBottom: cellIsSelected(indexPath: indexPath))
        }
        
        return cell
    }
    
    
    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emptyCell")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return graphHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: kShowOrderSegueId, sender: orders?[indexPath.row])
        
        let cell = tableView.cellForRow(at: indexPath) as! StatisticsCell
        cell.orderNameLabel.heroID  = kHeroOrderNameID
        cell.itemsLabel.heroID      = kHeroItemID
        cell.nameLabel.heroID       = kHeroCustomerNameID
        cell.emailLabel.heroID      = kHeroCustomerEmailID
        cell.noLbl.heroID           = kHeroNoID
        
        if !cellIsSelected(indexPath: indexPath) {
            cell.nameLabel.heroID = nil
            cell.emailLabel.heroID = nil
        }
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }

    
    // MARK: - Private
    
    func cellIsSelected(indexPath: IndexPath) -> Bool {
        return selectedCells.contains(indexPath.row)
    }

}
