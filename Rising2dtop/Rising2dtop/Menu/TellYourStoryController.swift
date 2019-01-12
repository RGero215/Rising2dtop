//
//  TellYourStoryController.swift
//  Rising2dtop
//
//  Created by Ramon Geronimo on 1/12/19.
//  Copyright © 2019 Ramon Geronimo. All rights reserved.
//

import Foundation
import UIKit

class TellYourStoryController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleReset))
        navigationItem.leftBarButtonItem?.tintColor = .white
        
        // Setup background color
        view.backgroundColor = .white
        
        // Setup navbar title
        navigationItem.title = "Tell Your Story"
        
        // style lines
        tableView.separatorColor = .darkYellow
        
        tableView.tableFooterView = UIView() // blank UIView
        tableView.backgroundColor = .white
        
        // setup navibar style
        setupNavigationStyle()
    }
    
    @objc fileprivate func handleReset(){
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .lightBlack
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.textColor = .gold()
        cell.textLabel?.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        cell.textLabel?.text = "Stories"
        return cell
    }
}
