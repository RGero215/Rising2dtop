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
            positionTextField.text = company?.position
            nameTextField.text = company?.company
//            addressTextField.text = company?.address
//            websiteTextField.text = company?.website
            phoneTextField.text = company?.phoneNumber
            emailTextField.text = company?.email
//            accountOneTextField.text = company?.accountOne
//            accountTwoTextField.text = company?.accountTwo
        }
    }
    
    var delegate: CreateCompanyControllerDelegate?
    
    // Company name textfield
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "Enter company name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // position textfield
    let positionTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        textField.textColor = .white
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "Enter company position", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // Address textfield
    let addressTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        textField.textColor = .white
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "Enter company address", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // Website textfield
    let websiteTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        textField.textColor = .white
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "Enter company website", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    // Phone textfield
    let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        textField.textColor = .white
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "Enter company phone number", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // company email textfield
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        textField.textColor = .white
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "Enter company email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // SocialLink Account 1 textfield
    let accountOneTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        textField.textColor = .white
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "e.g. LinkedIn, Facebook", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // SocialLink Account 2 textfield
    let accountTwoTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        textField.textColor = .white
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "e.g. GitHub, Instagram", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
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
        
        // Setup name textfield auto layout
        
        setupInputFields(lightDarkBackground)
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
        
    }
    
    fileprivate func createCompany(){
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
        company.setValue(positionTextField.text, forKey: "position")
        company.setValue(nameTextField.text, forKey: "company")
        company.setValue(addressTextField.text, forKey: "address")
        company.setValue(websiteTextField.text, forKey: "website")
        company.setValue(phoneTextField.text, forKey: "phone")
        company.setValue(emailTextField.text, forKey: "email")
        company.setValue(accountOneTextField.text, forKey: "accountOne")
        company.setValue(accountTwoTextField.text, forKey: "accountTwo")
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
        
        company?.company = positionTextField.text
        company?.company = nameTextField.text
        company?.company = addressTextField.text
        company?.company = websiteTextField.text
        company?.company = phoneTextField.text
        company?.company = emailTextField.text
        company?.company = accountOneTextField.text
        company?.company = accountTwoTextField.text
        
        do {
            try context.save()
            dismiss(animated: true, completion: {
                self.delegate?.didEditCompany(company: self.company! )
            })
        } catch let saveErr {
            print("Failed to save company changes:", saveErr)
        }
    
    }
    
    fileprivate func setupInputFields(_ lightBackgroundView: UIView) {
        
        let stackView = UIStackView(arrangedSubviews: [nameTextField, positionTextField, addressTextField, websiteTextField, phoneTextField, emailTextField, accountOneTextField, accountTwoTextField])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.layer.borderColor = UIColor.darkYellow.cgColor
        stackView.layer.borderWidth = 2
        
        view.addSubview(stackView)
        
        
        stackView.anchor(top: lightBackgroundView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: view.bounds.height / 2)
    }
}
