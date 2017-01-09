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

class MainController: UIViewController, URLSessionDownloadDelegate {
    var fileURL : URL?
    
    //MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.applyGradient(colours: [UIColor(red:0.13, green:0.23, blue:0.36, alpha:1.00),
                                     UIColor(red:0.55, green:0.53, blue:0.62, alpha:1.00)])
    }
    
    
    //MARK: - Actions
    
    @IBAction func parseDefault(_ sender: Any) {
        print("Sent request to server...")
        if let url = URL.init(string: kResourceLink) {
            let session = URLSession.init(configuration: .default,
                                          delegate: self,
                                          delegateQueue: nil)
            let task = session.downloadTask(with: url)
            
            task.resume()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kParseSegueId {
            let parser = Parser.init(url: fileURL)
            
            let statisticsController = segue.destination as! StatisticsController
            statisticsController.orders = parser.orders
        }
        
    }
    
    //MARK: - URLSessionDownloadDelegate
    
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL) {
        print("GET request finished.")
        fileURL = location
        
        performSegue(withIdentifier: kParseSegueId, sender: nil)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("Failed to download :(")
    }
    
}
