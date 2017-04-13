//
//  WebViewController.swift
//  MyFoodPage
//
//  Created by Cooltey Feng on 13/04/2017.
//  Copyright © 2017 18841. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet var webView: UIWebView!
    @IBOutlet var loadingCircle: UIActivityIndicatorView!
    
    var websiteUrl:String = ""
    var restaurantName:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup url
        let url = NSURL(string: websiteUrl)
        let requestObj = NSURLRequest(url: url! as URL)
        
        // setup webview and loading circle
        loadingCircle.hidesWhenStopped = true
        webView.delegate = self
        webView.loadRequest(requestObj as URLRequest);
        
        
        // go back button
        let backButton = UIBarButtonItem(title: "Back",
                                         style: UIBarButtonItemStyle.plain,
                                         target: self,
                                         action: #selector(DetailViewController.goBack))
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = restaurantName
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        // show progress bar
        loadingCircle.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        // hide progress bar
        loadingCircle.stopAnimating()
    }
    
    // function go back
    func goBack(){
        dismiss(animated: true, completion: nil)
    }
}
