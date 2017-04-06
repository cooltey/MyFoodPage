//
//  ViewController.swift
//  MyFoodPage
//
//  Created by Cooltey Feng on 05/04/2017.
//  Copyright © 2017 18841. All rights reserved.
//

// table view references : https://itisjoe.gitbooks.io/swiftgo/content/uikit/uitableview.html

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    var restaurant = ["McDonald's", "Wendy's", "Burger King", "Jack in the Box"]
    var restaurant_detail = ["0.5mi", "1.2mi", "1.5mi", "1.7mi"]
    var restaurant_logo = ["mc.png", "wendys.jpg", "bk.png", "jib.png"]
    
    // count items in the tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return restaurant.count
    }
    
    // click item
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
//        // find second story board
//        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
//        // get destination
//        let destination = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as UIViewController
//        
//        let navigationController = UINavigationController()
//        
//        navigationController.pushViewController(destination, animated: true)
//        
//        print("test")
//        print(navigationController)
        
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        
        if let resultController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            let navController = UINavigationController(rootViewController: resultController) // Creating a navigation controller with resultController at the root of the navigation stack.
            self.present(navController, animated:true, completion: nil)
        }
        
    }
    
    // display content in the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell: CustomTableViewCell = CustomTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        cell.imageView!.layer.cornerRadius = 20
        cell.imageView!.clipsToBounds = true
        let imageData = restaurant_logo[indexPath.row]
        let image = UIImage(named: imageData)
        cell.imageView?.image = ResizeImage(image: image!, targetSize: CGSize(width: 90, height: 90))
        
        // setup list text
        cell.textLabel?.text = restaurant[indexPath.row]
        cell.detailTextLabel?.text = restaurant_detail[indexPath.row]
        
        return cell
        
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
            x: 0, y: 20,
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

