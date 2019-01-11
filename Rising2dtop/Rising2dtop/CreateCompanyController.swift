//
//  CreateCompanyController.swift
//  Rising2dtop
//
//  Created by Ramon Geronimo on 1/10/19.
//  Copyright © 2019 Ramon Geronimo. All rights reserved.
//

import UIKit
import CoreData

protocol CreateCompanyControllerDelegate {
    func didAddCompany(company: Company)
    func didEditCompany(company: Company)
}

class CreateCompanyController: UIViewController {
    
    var company: Company? {
        didSet {
            nameTextField.text = company?.company
        }
    }
    
    var delegate: CreateCompanyControllerDelegate?
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = .white
        // enable autolayout
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "Enter company name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        setupUI()
        
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        navigationItem.leftBarButtonItem?.tintColor  = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        setupNavigationStyle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = company == nil ? "Create Company" : "Edit Company"
    }
    
    fileprivate func setupUI(){
        
        // Setup background color and auto layout
        let lightDarkBackground = UIView()
        lightDarkBackground.backgroundColor = .lightBlack
        lightDarkBackground.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(lightDarkBackground)
        lightDarkBackground.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        lightDarkBackground.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lightDarkBackground.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lightDarkBackground.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Setup name label auto layout
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Setup name textfield auto layout
        view.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        
    }
    
    @objc fileprivate func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func handleSave(){
        print("Saving...")
        
        if company == nil {
            createCompany()
        } else {
            saveCompanyChanges()
        }
        
//        dismiss(animated: true) {
//            guard let companyName = self.nameTextField.text else { return }
//            
//            let company = Company(firstName: "Ramon", surname: "Geronimo", userImage: "", cardImage: "", position: "Founder/CEO", company: companyName, address: BusinessAddress(street: "246 McAllister ST", city: "San Francisco", state: "CA", postalCode: "94102", coordinates: (latittude: 37.7809473, longtitude: -122.4135812)), website: SocialLinkData(link: "https://the2become1.us", type: .Website), phoneNumber: "2018510284", email: "rgero215@gmail.com", accountOne: SocialLinkData(link: "https://www.linkedin.com/in/rgero215/", type: .StackOverFlow), accountTwo: SocialLinkData(link: "https://github.com/RGero215", type: .GitHub))
//            
//            self.delegate?.didAddCompany(company: company)
//        }
        
    }
    
    fileprivate func createCompany(){
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
        company.setValue(nameTextField.text, forKey: "company")
        // perform save
        do {
            try context.save()
            dismiss(animated: true, completion: {
                self.delegate?.didAddCompany(company: company as! Company)
            })
        } catch let saveErr {
            print("Failed to create company:", saveErr)
        }
    }
    
    fileprivate func saveCompanyChanges(){
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        company?.company = nameTextField.text
        
        do {
            try context.save()
            dismiss(animated: true, completion: {
                self.delegate?.didEditCompany(company: self.company! )
            })
        } catch let saveErr {
            print("Failed to save company changes:", saveErr)
        }
    
    }
}
