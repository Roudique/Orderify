//
//  StatisticsController.swift
//  Orderify
//
//  Created by Roudique on 1/8/17.
//  Copyright © 2017 roudique.com. All rights reserved.
//

import UIKit

let kStatisticCellId            = "statisticCellId"
let kPullLimit : CGFloat        = 150.0
let kCellHeight : CGFloat       = 136.0
let kCellHiddenHeight : CGFloat = 54.0
var kEmptyCellHeight : CGFloat  = 100.0

class StatisticsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var orders : Array<Order>?
    var selectedCells = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.applyGradient(colours: [UIColor(red:0.13, green:0.23, blue:0.36, alpha:1.00),
                                     UIColor(red:0.55, green:0.53, blue:0.62, alpha:1.00)])
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
        return kEmptyCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    
// MARK: - Private
    
    func cellIsSelected(indexPath: IndexPath) -> Bool {
        return selectedCells.contains(indexPath.row)
    }

}
