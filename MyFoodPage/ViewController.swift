//
//  ViewController.swift
//  MyFoodPage
//
//  Created by Cooltey Feng on 05/04/2017.
//  Copyright © 2017 18841. All rights reserved.
//

// table view references : https://itisjoe.gitbooks.io/swiftgo/content/uikit/uitableview.html

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    // my location
    var app_location = [37.4761117,-121.9302447]
    
    var restaurant = ["McDonald's",
                      "Wendy's",
                      "Burger King",
                      "Jack in the Box"]
    
    var restaurant_location = [[37.457278, -121.909285],
                               [37.505761, -121.972298],
                               [37.490525, -121.928100],
                               [37.492545, -121.926858]]
    
    var restaurant_detail = ["McDonald's (or simply as McD) is an American hamburger and fast food restaurant chain. It was founded in 1940 as a barbecue restaurant operated by Richard and Maurice McDonald.",
                             "Wendy's is an American international fast food restaurant chain founded by Dave Thomas on November 15, 1969, in Columbus, Ohio, United States. The company moved its headquarters to Dublin, Ohio, on January 29, 2006. ",
                             "Burger King (BK) is an American global chain of hamburger fast food restaurants. Headquartered in the unincorporated area of Miami-Dade County, Florida, the company was founded in 1953 as InstaBurger King, a Jacksonville, Florida-based restaurant chain.",
                             "Jack in the Box is an American fast-food restaurant chain founded February 21, 1951, by Robert O. Peterson in San Diego, California, where it is headquartered."]
    
    var restaurant_logo = [["mc", "mc_1", "mc_2", "mc_3"],
                           ["wendys", "wendy_1", "wendy_2", "wendy_3"],
                           ["bk", "bk_1", "bk_2", "bk_3"],
                           ["jib", "jib_1", "jib_2", "jib_3"]]
    
    var restaurant_website = ["https://www.mcdonalds.com",
                              "https://www.wendys.com/",
                              "https://www.bk.com/",
                              "https://www.jackinthebox.com/"]
    
    // count items in the tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return restaurant.count
    }
    
    // click item
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    
        
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        
        if let resultController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            
            // pass data
            resultController.restaurantLogo       = restaurant_logo[indexPath.row]
            resultController.restaurantDesc       = restaurant_detail[indexPath.row]
            resultController.restaurantName       = restaurant[indexPath.row]
            resultController.restaurantMap        = restaurant_location[indexPath.row]
            resultController.restaurantWebsite    = restaurant_website[indexPath.row]
            resultController.myLocation           = app_location
            
            
            let navController = UINavigationController(rootViewController: resultController)
            
            self.present(navController, animated:true, completion: nil)
        }
        
    }
    
    // display content in the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell: CustomTableViewCell = CustomTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        cell.imageView!.layer.cornerRadius = 20
        cell.imageView!.clipsToBounds = true
        let imageData = restaurant_logo[indexPath.row][0]
        let image = UIImage(named: imageData)
        cell.imageView?.image = ResizeImage(image: image!, targetSize: CGSize(width: 90, height: 90))
        
        // setup list text
        cell.textLabel?.text = restaurant[indexPath.row]
        // calculate location
        
        let coordinate_0 = CLLocation(latitude: app_location[0], longitude: app_location[1])
        let coordinate_1 = CLLocation(latitude: restaurant_location[indexPath.row][0], longitude: restaurant_location[indexPath.row][1])
        
        // result is in meters
        let distanceInMeters = coordinate_0.distance(from: coordinate_1)
        
        cell.detailTextLabel?.text = "\(meterToMile(meter: distanceInMeters)) mi"
        
        return cell
        
    }
    
    func meterToMile(meter : Double) -> String{
        return NSString(format:"%.2f", meter/1609.344) as String
    }
    
    // resize the image
    func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // get device screen
        let fullScreenSize = UIScreen.main.bounds.size
        
        // create uitable view
        let myTableView = UITableView(frame: CGRect(
            x: 0, y: 70,
            width: fullScreenSize.width,
            height: fullScreenSize.height - 20),
            style: .plain)
        
        // register cell
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        // setup delegate
        myTableView.delegate = self
        myTableView.dataSource = self
        
        // divider
        myTableView.separatorStyle = .singleLine
        
        // divider edges
        myTableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20)
        
        // multiple cell
        myTableView.allowsMultipleSelection = false
        
        // setup item height
        myTableView.rowHeight = 120
//        myTableView.estimatedRowHeight = 120
        
        // add into screen
        self.view.addSubview(myTableView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

