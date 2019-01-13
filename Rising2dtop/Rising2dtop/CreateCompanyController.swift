//
//  CreateCompanyController.swift
//  Rising2dtop
//
//  Created by Ramon Geronimo on 1/10/19.
//  Copyright © 2019 Ramon Geronimo. All rights reserved.
//

import UIKit
import CoreData
import Firebase

protocol CreateCompanyControllerDelegate {
    func didAddCompany(company: Company)
    func didEditCompany(company: Company)
}

class CreateCompanyController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var ref: DatabaseReference!
    // Fetch user
    var uid = String()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.alwaysBounceVertical = true
        scrollView.isScrollEnabled = true
        scrollView.contentSize.height = 2000
        return scrollView
    }()
    
    lazy var companyImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "photo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectPhoto)))
        return imageView
    }()
    
    @objc fileprivate func handleSelectPhoto(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing  = true
        present(imagePickerController, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(info)
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            companyImageView.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            companyImageView.image = originalImage
        }
        
        setupCircularImageStyle()
        
        dismiss(animated: true, completion: nil)
    }
    
    var company: Company? {
        didSet {
            
            if let imageData = company?.logo {
                companyImageView.image = UIImage(data: imageData)
                setupCircularImageStyle()
            }
            
            positionTextField.text = company?.position
            nameTextField.text = company?.company
            addressTextField.text = company?.address
            websiteTextField.text = company?.website
            phoneTextField.text = company?.phoneNumber
            emailTextField.text = company?.email
            accountOneTextField.text = company?.accountOne
            accountTwoTextField.text = company?.accountTwo
            guard let started = company?.started else {return}
            datePicker.date = started
        }
    }
    
    fileprivate func setupCircularImageStyle(){
        companyImageView.layer.cornerRadius = companyImageView.frame.width / 2
        companyImageView.clipsToBounds = true
        companyImageView.layer.borderColor = UIColor.gold().cgColor
        companyImageView.layer.borderWidth = 2
    }
    
    var delegate: CreateCompanyControllerDelegate?
    
    // Company name textfield
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        textField.textColor = .black
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
        textField.textColor = .black
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
        textField.textColor = .black
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
        textField.textColor = .black
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
        textField.textColor = .black
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
        textField.textColor = .black
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
        textField.textColor = .black
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
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(string: "e.g. GitHub, Instagram", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // Starting Date
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.translatesAutoresizingMaskIntoConstraints = false
        return dp
    }()
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        setupUI()
        uid = Auth.auth().currentUser?.uid ?? ""
        print("********  UID:", uid)
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        navigationItem.leftBarButtonItem?.tintColor  = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        setupNavigationStyle()
        
    }
    // User object
    var user: User?
    
    fileprivate func fetchUser(){
        
        
    }
    
    
    
    fileprivate func setupScrollView(_ lightDarkgroundView: UIView) {
        scrollView.anchor(top: lightDarkgroundView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
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
        lightDarkBackground.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        // Setup company image
        view.addSubview(companyImageView)
        companyImageView.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: 100, height: 100)
        companyImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        // Setup scroll
        view.addSubview(scrollView)
        setupScrollView(lightDarkBackground)
        
        
        // Setup textfield auto layout
        
        setupInputFields()
    }
    
    @objc fileprivate func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func handleSave(){
        print("Saving...")
        
        if company == nil {
            print("Creating.....")
            createCompany()
        } else {
            print("Saving don't rush me.....")
            saveCompanyChanges()
        }
        
    }
    
    fileprivate func createCompany(){
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
        
        Database.fetchUserWithUID(uid: uid) { (user) in
            // User object
            self.user = user
            
            // Set the user name
            company.setValue(self.user?.firstName, forKey: "firstName")
            company.setValue(self.user?.lastName, forKey: "lastName")
            // Set user profile image
            if let profileImageUrl = self.user?.profileImageUrl {
                guard let url = URL(string: profileImageUrl) else {return}
                
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url)
                    DispatchQueue.main.async {
                        if let profileImage = UIImage(data: data!) {
                            let imageData = profileImage.jpegData(compressionQuality: 0.8)
                            company.setValue(imageData, forKey: "photo")
                        }
                        
                    }
                }
            }
        }
        
        // Company logo
        if let companyImage = companyImageView.image {
            let imageData = companyImage.jpegData(compressionQuality: 0.8)
            company.setValue(imageData, forKey: "logo")
        }
        
        // Company info
        company.setValue(positionTextField.text, forKey: "position")
        company.setValue(nameTextField.text, forKey: "company")
        company.setValue(addressTextField.text, forKey: "address")
        company.setValue(websiteTextField.text, forKey: "website")
        company.setValue(phoneTextField.text, forKey: "phoneNumber")
        company.setValue(emailTextField.text, forKey: "email")
        company.setValue(accountOneTextField.text, forKey: "accountOne")
        company.setValue(accountTwoTextField.text, forKey: "accountTwo")
        company.setValue(datePicker.date, forKey: "started")
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
        
        // Fetch for user
        let uid = Auth.auth().currentUser?.uid ?? ""
        Database.fetchUserWithUID(uid: uid) { (user) in
            // User object
            self.user = user
            
            // Save changes the user info
            self.company?.firstName = self.user?.firstName
            self.company?.lastName = self.user?.lastName
            self.company?.email = self.user?.email
            if let profileImageUrl = self.user?.profileImageUrl {
                guard let url = URL(string: profileImageUrl) else {return}
                
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url)
                    DispatchQueue.main.async {
                        if let profileImage = UIImage(data: data!) {
                            let imageData = profileImage.jpegData(compressionQuality: 0.8)
                            self.company?.photo = imageData
                        }
                        
                    }
                }
            }
        }
        
        // Company logo
        if let companyImage = companyImageView.image {
            let imageData = companyImage.jpegData(compressionQuality: 0.8)
            company?.logo = imageData
        }
        // Company info
        company?.company = positionTextField.text
        company?.company = nameTextField.text
        company?.company = addressTextField.text
        company?.company = websiteTextField.text
        company?.company = phoneTextField.text
        company?.company = emailTextField.text
        company?.company = accountOneTextField.text
        company?.company = accountTwoTextField.text
        company?.started = datePicker.date
        
        do {
            try context.save()
            dismiss(animated: true, completion: {
                self.delegate?.didEditCompany(company: self.company! )
            })
        } catch let saveErr {
            print("Failed to save company changes:", saveErr)
        }
    
    }
    
    fileprivate func setupInputFields() {
        
        let stackView = UIStackView(arrangedSubviews: [nameTextField, positionTextField, addressTextField, websiteTextField, phoneTextField, emailTextField, accountOneTextField, accountTwoTextField])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.layer.borderColor = UIColor.darkYellow.cgColor
        stackView.layer.borderWidth = 2
        
        scrollView.addSubview(stackView)
        
        
        stackView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.rightAnchor, paddingTop: 20, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: scrollView.bounds.height / 2)
        
        // setup date picker
        scrollView.addSubview(datePicker)
        datePicker.anchor(top: stackView.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.rightAnchor, paddingTop: 20, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 0)
    }
    
    

}
