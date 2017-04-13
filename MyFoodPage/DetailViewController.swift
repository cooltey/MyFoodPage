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

class DetailViewController: UIViewController, CLLocationManagerDelegate{
    
    var myLocation:[Double] = []
    var restaurantLogo:[String] = []
    var restaurantName:String = ""
    var restaurantDesc:String = ""
    var restaurantWebsite:String = ""
    var restaurantMap:[Double] = []
    var location :CLLocationManager!
    
    // current img
    var currentPosition = 1
    
    // map location
    var homeLocation : CLLocation!
    // display range
    let regionRadius: CLLocationDistance = 200
    
    @IBOutlet var storeImage: UIImageView!
    @IBOutlet var storeDesc: UILabel!
    @IBOutlet var storeMap: MKMapView!
    @IBOutlet var storeWebsite: UIButton!
    @IBOutlet var storeImagePosition: UILabel!
    
    override func viewDidLoad() {
    super.viewDidLoad()

        
        // setup view
        storeDesc.text = restaurantName
        storeImage.image = UIImage(named: restaurantLogo[0])
        storeDesc.text = restaurantDesc
        storeDesc.numberOfLines = 0;
        storeDesc.lineBreakMode = .byWordWrapping;
        storeDesc.sizeToFit()
        
        // setup button
        storeWebsite.setTitle("Website", for: .normal)
        storeWebsite.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        // setup image tap
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        storeImage.isUserInteractionEnabled = true
        storeImage.addGestureRecognizer(tapGestureRecognizer)
        
        homeLocation = CLLocation(latitude: restaurantMap[0], longitude: restaurantMap[1])
        
        // located store
        centerMapOnLocation(location: homeLocation)
        
        // go back button
        let backButton = UIBarButtonItem(title: "Back",
                                         style: UIBarButtonItemStyle.plain,
                                         target: self,
                                         action: #selector(DetailViewController.goBack))
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = restaurantName
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // function go website
    func buttonAction(sender: UIButton!) {
        
        let storyboard = UIStoryboard(name: "WebView", bundle: nil)
        
        if let resultController = storyboard.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
            
            // pass data
            resultController.websiteUrl = restaurantWebsite
            resultController.restaurantName = restaurantName
            
            
            let navController = UINavigationController(rootViewController: resultController)
            
            self.present(navController, animated:true, completion: nil)
        }
    }
    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        // switch
        if currentPosition == restaurantLogo.count {
            currentPosition = 0
        }
        
        tappedImage.image = UIImage(named: restaurantLogo[currentPosition])
        
        storeImagePosition.text = "Tap to View: \(currentPosition+1)/\(restaurantLogo.count)"
        
        currentPosition += 1
    }
    
    // function go back
    func goBack(){
        dismiss(animated: true, completion: nil)
    }
    
    // centerized map with store location
    func centerMapOnLocation(location: CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        storeMap.setRegion(coordinateRegion, animated: true)
        // add restaurant location
        addPointAnnotation(title: restaurantName,
                           subtitle: restaurantDesc,
                           latitude: location.coordinate.latitude,
                           longitude: location.coordinate.longitude)
    }
    
    
    func meterToMile(meter : Double) -> String{
        return NSString(format:"%.2f", meter/1609.344) as String
    }
    
    // add pin on map
    private func addPointAnnotation(title:String, subtitle:String, latitude:CLLocationDegrees , longitude:CLLocationDegrees){
        
        // init a pin
        let point : MKPointAnnotation = MKPointAnnotation();
        
        // setup a pin
        point.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude);
        point.title = title;
        point.subtitle = subtitle;
        
        storeMap.addAnnotation(point);
    }
    
}

