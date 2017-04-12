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
    
    var restaurantLogo:String = ""
    var restaurantName:String = ""
    var restaurantDesc:String = ""
    var restaurantMap:String = ""
    var location :CLLocationManager!
    
    let homeLocation = CLLocation(latitude: 37.4904611, longitude: -121.9285222)
    let regionRadius: CLLocationDistance = 200
    
    @IBOutlet var storeImage: UIImageView!
    @IBOutlet var storeDesc: UILabel!
    @IBOutlet var storeMap: MKMapView!
    
    override func viewDidLoad() {
    super.viewDidLoad()

        
        // setup view
        storeDesc.text = restaurantName
        storeImage.image = UIImage(named: restaurantLogo)
        
        // located store
        centerMapOnLocation(location: homeLocation)
        
        // go back button
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DetailViewController.goBack))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = restaurantName
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // funtion go back
    func goBack(){
        dismiss(animated: true, completion: nil)
    }
    
    // centerized map with store location
    func centerMapOnLocation(location: CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        storeMap.setRegion(coordinateRegion, animated: true)
        addPointAnnotation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    }
    
    // add pin on map
    private func addPointAnnotation(latitude:CLLocationDegrees , longitude:CLLocationDegrees){
        
        // init a pin
        let point : MKPointAnnotation = MKPointAnnotation();
        
        // setup a pin
        point.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude);
        point.title = restaurantName;
        point.subtitle = restaurantDesc;
        
        storeMap.addAnnotation(point);
    }
    
}

