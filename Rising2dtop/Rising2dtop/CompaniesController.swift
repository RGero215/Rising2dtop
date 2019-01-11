//
//  ViewController.swift
//  Rising2dtop
//
//  Created by Ramon Geronimo on 1/10/19.
//  Copyright © 2019 Ramon Geronimo. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController {
    func setupNavigationStyle(){
        
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

class CompaniesController: UITableViewController, CreateCompanyControllerDelegate {
    func didAddCompany(company: Company) {
        companies.append(company)
        
        // Insert a new indexPath
        let newIndexPath = IndexPath(row: companies.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    var companies = [Company]()
    
    
//    var companies = [
//        Company(firstName: "Ramon", surname: "Geronimo", userImage: "", cardImage: "", position: "Founder/CEO", company: "DormStartups", address: BusinessAddress(street: "246 McAllister ST", city: "San Francisco", state: "CA", postalCode: "94102", coordinates: (latittude: 37.7809473, longtitude: -122.4135812)), website: SocialLinkData(link: "https://dormstartups.tv", type: .Website), phoneNumber: "2018510284", email: "rgero215@100gmail.com", accountOne: SocialLinkData(link: "https://www.linkedin.com/in/rgero215/", type: .StackOverFlow), accountTwo: SocialLinkData(link: "https://github.com/RGero215", type: .GitHub)),
//
//        Company(firstName: "Ramon", surname: "Geronimo", userImage: "", cardImage: "", position: "Founder/CEO", company: "Rising To The Top", address: BusinessAddress(street: "246 McAllister ST", city: "San Francisco", state: "CA", postalCode: "94102", coordinates: (latittude: 37.7809473, longtitude: -122.4135812)), website: SocialLinkData(link: "https://rising2dtop.org", type: .Website), phoneNumber: "2018510284", email: "rgero215@gmail.com", accountOne: SocialLinkData(link: "https://www.linkedin.com/in/rgero215/", type: .StackOverFlow), accountTwo: SocialLinkData(link: "https://github.com/RGero215", type: .GitHub)),
//
//        Company(firstName: "Ramon", surname: "Geronimo", userImage: "", cardImage: "", position: "Founder/CEO", company: "The 2 Become 1", address: BusinessAddress(street: "246 McAllister ST", city: "San Francisco", state: "CA", postalCode: "94102", coordinates: (latittude: 37.7809473, longtitude: -122.4135812)), website: SocialLinkData(link: "https://the2become1.us", type: .Website), phoneNumber: "2018510284", email: "rgero215@gmail.com", accountOne: SocialLinkData(link: "https://www.linkedin.com/in/rgero215/", type: .StackOverFlow), accountTwo: SocialLinkData(link: "https://github.com/RGero215", type: .GitHub))
//    ]
    
    fileprivate func fetchCompanies(){
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        do {
            let companies = try context.fetch(fetchRequest)
            
            companies.forEach { (company) in
                print(company.name ?? "")
            }
            
            self.companies = companies
            self.tableView.reloadData()
            
        } catch let fetchErr {
            print("Failed to fetch companies: ", fetchErr)
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCompanies()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset))
        navigationItem.leftBarButtonItem?.tintColor = .white
        
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
    
    @objc fileprivate func handleReset(){
        print("Reset")
    }
    
    @objc func handleAddCompany(){
        print("Add Company")
        
        let createCompanyController = CreateCompanyController()
        
        let navController = UINavigationController(rootViewController: createCompanyController)
        
        createCompanyController.delegate = self
        
        present(navController, animated: true)
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
        cell.textLabel?.text = company.name
        
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (_ , indexPath) in
            let company = self.companies[indexPath.row]
            print("Attempting to delete company:", company.name ?? "")
            
            // remove the company from our tableview
            self.companies.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            // delete from core data
            let context = CoreDataManager.shared.persistentContainer.viewContext
            context.delete(company)
            
            do {
                try context.save()
            } catch let saveErr{
                print("Failed to delete company:", saveErr)
            }
            
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: editHandlerFunction)
        
        return [deleteAction, editAction]
    }
    
    fileprivate func editHandlerFunction(action: UITableViewRowAction, indexPath: IndexPath) {
        let editCompanyController = CreateCompanyController()
        editCompanyController.company = companies[indexPath.row]
        let navController = CustomNavigationController(rootViewController: editCompanyController)
        present(navController, animated: true)
    }

}

