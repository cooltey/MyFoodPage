//
//  ViewController.swift
//  MyFoodPage
//
//  Created by Cooltey Feng on 05/04/2017.
//  Copyright © 2017 18841. All rights reserved.
//


import UIKit
import MapKit
import CoreLocation

class DetailViewController: UIViewController{
    
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
        // go back button
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DetailViewController.goBack))
        navigationItem.leftBarButtonItem = backButton
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // funtion go back
    func goBack(){
        dismiss(animated: true, completion: nil)
    }
}

