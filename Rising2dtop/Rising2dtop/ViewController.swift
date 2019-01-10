//
//  ViewController.swift
//  Rising2dtop
//
//  Created by Ramon Geronimo on 1/10/19.
//  Copyright © 2019 Ramon Geronimo. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup background color
        view.backgroundColor = .white
        
        // Setup navbar title
        navigationItem.title = "Companies"
        
        // Remove lines
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView() // blank UIView
        tableView.backgroundColor = .white
        
        
        // register cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
        // Setup navbar
        setupNavigationStyle()
        
        // Setup navbar Add button
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddCompany))
    }
    
    @objc fileprivate func handleAddCompany(){
        print("Add Company")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    fileprivate func setupNavigationStyle(){
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .darkYellow
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let logo = UIImage(named: "app_icon.png")
        let imageView = UIImageView(image:logo)
        imageView.layer.cornerRadius = 7.0
        imageView.clipsToBounds = true
        navigationItem.titleView = imageView
        

    }


}

