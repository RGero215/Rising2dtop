//
//  ViewController.swift
//  Rising2dtop
//
//  Created by Ramon Geronimo on 1/10/19.
//  Copyright © 2019 Ramon Geronimo. All rights reserved.
//

import UIKit

class CompaniesController: UITableViewController {
    
    let companies = [
        Company(firstName: "Ramon", surname: "Geronimo", userImage: "", cardImage: "", position: "Founder/CEO", company: "DormStartups", address: BusinessAddress(street: "246 McAllister ST", city: "San Francisco", state: "CA", postalCode: "94102", coordinates: (latittude: 37.7809473, longtitude: -122.4135812)), website: SocialLinkData(link: "https://dormstartups.tv", type: .Website), phoneNumber: "2018510284", email: "rgero215@100gmail.com", accountOne: SocialLinkData(link: "https://www.linkedin.com/in/rgero215/", type: .StackOverFlow), accountTwo: SocialLinkData(link: "https://github.com/RGero215", type: .GitHub)),
        
        Company(firstName: "Ramon", surname: "Geronimo", userImage: "", cardImage: "", position: "Founder/CEO", company: "Rising To The Top", address: BusinessAddress(street: "246 McAllister ST", city: "San Francisco", state: "CA", postalCode: "94102", coordinates: (latittude: 37.7809473, longtitude: -122.4135812)), website: SocialLinkData(link: "https://rising2dtop.org", type: .Website), phoneNumber: "2018510284", email: "rgero215@gmail.com", accountOne: SocialLinkData(link: "https://www.linkedin.com/in/rgero215/", type: .StackOverFlow), accountTwo: SocialLinkData(link: "https://github.com/RGero215", type: .GitHub)),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup background color
        view.backgroundColor = .white
        
        // Setup navbar title
        navigationItem.title = "Companies"
        
        // style lines
        tableView.separatorColor = .darkYellow
    
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
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .lightBlack
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        let company = companies[indexPath.row]
        cell.textLabel?.text = company.company
        
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
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

