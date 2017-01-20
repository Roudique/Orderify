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


class MainController: BaseViewController, URLSessionDownloadDelegate, UITextFieldDelegate {
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
        
//        if let url = URL.init(string: kBaseResourceLink + kOrdersKey + "4&" + kAccessTokenKey) {
//            fetchJSON(url: url)
//        }
        let array = NSArray.init()
        APIManager.shared.fetchOrders(array) { orders in
            DispatchQueue.main.async {
                self.orders = orders
                self.performSegue(withIdentifier: kParseSegueId, sender: nil)
            }
            
            
        }
    }
    
    @IBAction func authorAction(_ sender: UIButton) {
        if let url = URL.init(string: kAuthorLink) {
            UIApplication.shared.openURL(url)
        }
    }
    
    
//MARK: - Private
    
    func fetchJSON(url: URL?) {
        
        if let url = url {
            isLoading = true
            let session = URLSession.init(configuration: .default,
                                          delegate: self,
                                          delegateQueue: nil)
            let task = session.downloadTask(with: url)

            task.resume()
        } else {
            showAlert(title: "Error", message: "Wrong URL 😲")
        }
    }
    
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
    
    
    //MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let url = URL.init(string: textField.text ?? "") {
            hideKeyboard()
            fetchJSON(url: url)
        } else {
            showAlert(title: nil, message: "This is not URL 😑")
        }
        
        return false
    }
    
    
    //MARK: - URLSessionDownloadDelegate
    
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL) {
        isLoading = false
        fileURL = location
        
        DispatchQueue.main.sync {
            self.performSegue(withIdentifier: kParseSegueId, sender: nil)
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        isLoading = false

        if let error = error {
            showAlert(title: "Failed to download 😲", message: "Error: \(error.localizedDescription)")
        }
    }
}
