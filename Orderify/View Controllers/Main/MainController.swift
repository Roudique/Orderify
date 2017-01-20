//
//  MainController.swift
//  Orderify
//
//  Created by Roudique on 1/8/17.
//  Copyright © 2017 roudique.com. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


let kParseSegueId = "parseSegue"

let kAuthorLink   = "https://github.com/Roudique"


class MainController: BaseViewController, UITextFieldDelegate {
    var fileURL : URL?
    var isLoading = false {
        didSet {
            DispatchQueue.main.async {
                self.parseJSONButton.isEnabled = !self.isLoading
                if self.isLoading {
                    self.animatingView.type = .pacman
                    self.animatingView.startAnimating()
                } else {
                    self.animatingView.stopAnimating()
                }
            }
        }
    }
    var orders = [Order]()
    
    @IBOutlet weak var parseJSONButton: BorderedButton!
    @IBOutlet weak var animatingView: NVActivityIndicatorView!
    @IBOutlet weak var greetingLabel: UILabel!
    
    
    //MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hideKeyboardGR = UITapGestureRecognizer.init(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(hideKeyboardGR)
        
        greetingLabel.adjustsFontSizeToFitWidth = true
    }
    
    
    //MARK: - Actions
    
    @IBAction func parseDefault(_ sender: Any) {
        guard !isLoading else { return }
        
        hideKeyboard()
        
        isLoading = true
        let array = NSArray.init()
        APIManager.shared.fetchOrders(array) { orders in
            self.goToDetails(with: orders)
        }
    }
    
    @IBAction func authorAction(_ sender: UIButton) {
        if let url = URL.init(string: kAuthorLink) {
            UIApplication.shared.openURL(url)
        }
    }
    
    
    //MARK: - Private
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kParseSegueId {
            
            if let statisticsController = segue.destination as? StatisticsController {
                statisticsController.orders = self.orders
                statisticsController.countries = Parser.getCountries(from: self.orders)
                statisticsController.totalPrice = Parser.totalPrice(for: self.orders)
            }
        }
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func goToDetails(with orders: [Order]) {
        DispatchQueue.main.async {
            self.orders = orders
            self.performSegue(withIdentifier: kParseSegueId, sender: nil)
            self.isLoading = false
        }
    }
    
    
    //MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let url = URL.init(string: textField.text ?? "") {
            hideKeyboard()
            
            APIManager.shared.fetchOrders(from: url, completion: { orders in
                self.goToDetails(with: orders)
            })
        } else {
            showAlert(title: nil, message: "This is not URL 😑")
        }
        
        return false
    }
}
