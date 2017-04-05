//
//  CustomeTableViewCell.swift
//  MyFoodPage
//
//  Created by Cooltey Feng on 05/04/2017.
//  Copyright © 2017 18841. All rights reserved.
//

import UIKit

// my custom table view
class CustomTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // Here you can customize the appearance of your cell
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Customize imageView like you need
        self.imageView?.frame = CGRect(x: 20, y: 20, width: 70, height: 70)
        self.imageView?.contentMode = UIViewContentMode.scaleAspectFill
        
        // Costomize other elements
        self.textLabel?.frame = CGRect(x: 120, y: 20, width: self.frame.width - 100, height: 30)
        self.detailTextLabel?.frame = CGRect(x: 120, y: 40, width: self.frame.width - 100, height: 40)
    }
}
