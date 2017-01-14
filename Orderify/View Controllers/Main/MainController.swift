//
//  MainController.swift
//  Orderify
//
//  Created by Roudique on 1/8/17.
//  Copyright © 2017 roudique.com. All rights reserved.
//

import UIKit


let kParseSegueId = "parseSegue"
let kResourceLink = "https://shopicruit.myshopify.com/admin/orders.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
let kAuthorLink   = "https://github.com/Roudique"


class MainController: BaseViewController, URLSessionDownloadDelegate {
    var fileURL : URL?
    
//MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hideKeyboardGR = UITapGestureRecognizer.init(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(hideKeyboardGR)
    }
    
    
//MARK: - Actions
    
    @IBAction func parseDefault(_ sender: Any) {
        view.endEditing(true)
        print("Sent request to server...")
        if let url = URL.init(string: kResourceLink) {
            let session = URLSession.init(configuration: .default,
                                          delegate: self,
                                          delegateQueue: nil)
            let task = session.downloadTask(with: url)
            
            task.resume()
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
            let parser = Parser.init(url: fileURL)
            
            if let statisticsController = segue.destination as? StatisticsController {
                statisticsController.orders = parser.orders
                statisticsController.countries = parser.countries
                statisticsController.totalPrice = parser.totalCost
            }
        }
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    
//MARK: - URLSessionDownloadDelegate
    
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL) {
        fileURL = location
        
        DispatchQueue.main.sync {
            self.performSegue(withIdentifier: kParseSegueId, sender: nil)
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            print("Failed to download :( Error: \(error.localizedDescription)")
        }
    }
    
}
