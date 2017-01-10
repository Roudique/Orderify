//
//  StatisticsController.swift
//  Orderify
//
//  Created by Roudique on 1/8/17.
//  Copyright © 2017 roudique.com. All rights reserved.
//

import UIKit

let kStatisticCellId = "statisticCellId"

class StatisticsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var orders : Array<Order>?
    var selectedCells = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    // MARK: - Table view data source
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("\(scrollView.contentOffset)")
        if scrollView.contentOffset.y < -150.0 {
            dismiss(animated: true, completion: nil)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = orders?.count {
            return count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if cellIsSelected(indexPath: indexPath) {
            return 127.0
        }
        return 127.0 - 48.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kStatisticCellId, for: indexPath) as! StatisticsCell
        
        if let order = orders?[indexPath.row] {
            cell.configure(with: order)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if cellIsSelected(indexPath: indexPath) {
            selectedCells.remove(at: selectedCells.index(of: indexPath.row)!)
        } else {
            selectedCells.append(indexPath.row)
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func cellIsSelected(indexPath: IndexPath) -> Bool {
        return selectedCells.contains(indexPath.row)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
