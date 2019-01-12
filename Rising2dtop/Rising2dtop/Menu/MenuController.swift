//
//  MenuController.swift
//  Rising2dtop
//
//  Created by Ramon Geronimo on 1/12/19.
//  Copyright © 2019 Ramon Geronimo. All rights reserved.
//

import Foundation
import UIKit

struct MenuItem {
    let icon: UIImage
    let title: String
}

extension MenuController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let slidingController = UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingController
        slidingController?.didSelectMenuItem(indexPath: indexPath)
    }
}

class MenuController: UITableViewController {
    let menuItems = [
        MenuItem(icon: #imageLiteral(resourceName: "industry"), title: "Companies"),
        MenuItem(icon: #imageLiteral(resourceName: "crowfunding"), title: "Services"),
        MenuItem(icon: #imageLiteral(resourceName: "promotion"), title: "Project We Love"),
        MenuItem(icon: #imageLiteral(resourceName: "tv"), title: "Tell Your Story"),
        MenuItem(icon: #imageLiteral(resourceName: "heart (1)"), title: "Help us"),
        MenuItem(icon: #imageLiteral(resourceName: "app_icon"), title: "Bring To Life")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
    }
    
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let customMenuHeader = CustomMenuHeaderView()
        return customMenuHeader
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuItems.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MenuItemCell(style: .default, reuseIdentifier: "cellId")
        let menuItem = menuItems[indexPath.row]
        cell.titleLabel.text = menuItem.title
        cell.iconImageView.image = menuItem.icon
        cell.titleLabel.textColor = UIColor(white: 0, alpha: 0.5)
        
        return cell
    }
    
    
}
