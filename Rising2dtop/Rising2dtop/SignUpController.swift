//
//  RegistrationController.swift
//  Rising2dtop
//
//  Created by Ramon Geronimo on 1/11/19.
//  Copyright © 2019 Ramon Geronimo. All rights reserved.
//

import UIKit
import Firebase

protocol UserSignUpControllerDelegate {
    func didFinishLoggingIn()
}

class SignUpController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var delegate: UserSignUpControllerDelegate?
    
    let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "photo").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handlePlusPhoto), for: .touchUpInside)
        
        
        return button
    }()
    
    @objc func handlePlusPhoto(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[.editedImage] as? UIImage {
            plusPhotoButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
            
        } else if let originalImage = info[.originalImage] as? UIImage {
            plusPhotoButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        plusPhotoButton.clipsToBounds = true
        plusPhotoButton.imageView?.contentMode = .scaleAspectFit
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width/2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.rgb(red: 247, green: 208, blue: 120).cgColor
        plusPhotoButton.layer.borderWidth = 3
        
        
        
        dismiss(animated: true, completion: nil)
    }
    
    let emailTextField: UITextField = {
        let email = UITextField()
        email.placeholder = "Email"
        email.borderStyle = .roundedRect
        email.backgroundColor = UIColor(white: 0, alpha: 0.03)
        email.font = UIFont.systemFont(ofSize: 14)
        email.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return email
    }()
    
    @objc func handleTextInputChange(){
        let isFormValid = emailTextField.text?.count ?? 0 > 0 && nameTextField.text?.count ?? 0 > 0 && passwordTextField.text?.count ?? 0 > 0
        if isFormValid {
            signupButton.isEnabled = true
            signupButton.backgroundColor = UIColor.rgb(red: 240, green: 187, blue: 109)
        } else {
            signupButton.isEnabled = false
            signupButton.backgroundColor = UIColor.rgb(red: 249, green: 217, blue: 159)
        }
    }
    
    let nameTextField: UITextField = {
        let name = UITextField()
        name.placeholder = "Name"
        name.borderStyle = .roundedRect
        name.backgroundColor = UIColor(white: 0, alpha: 0.03)
        name.font = UIFont.boldSystemFont(ofSize: 14)
        name.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return name
    }()
    
    let lastNameTextField: UITextField = {
        let lastName = UITextField()
        lastName.placeholder = "Last Name"
        lastName.borderStyle = .roundedRect
        lastName.backgroundColor = UIColor(white: 0, alpha: 0.03)
        lastName.font = UIFont.boldSystemFont(ofSize: 14)
        lastName.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return lastName
    }()
    
    let passwordTextField: UITextField = {
        let password = UITextField()
        password.placeholder = "Password"
        password.borderStyle = .roundedRect
        password.isSecureTextEntry = true
        password.backgroundColor = UIColor(white: 0, alpha: 0.03)
        password.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return password
    }()
    
    let signupButton: UIButton = {
        let signup = UIButton(type: .system)
        signup.setTitle("Sign Up", for: .normal)
        signup.tintColor = .white
        signup.backgroundColor = UIColor.rgb(red: 249, green: 217, blue: 159)
        signup.layer.cornerRadius = 5
        signup.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        signup.setTitleColor(.white, for: .normal)
        
        signup.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        signup.isEnabled = false
        
        return signup
    }()
    
    @objc func handleSignUp() {
        
        guard let name = nameTextField.text, name.count > 0 else {return}
        guard let lastName = lastNameTextField.text, lastName.count > 0 else {return}
        guard let email = emailTextField.text, email.count > 0 else {return}
        guard let password = passwordTextField.text, password.count > 0 else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            // ...
            // Get a reference to the storage service using the default Firebase App
            let storageRef = Storage.storage().reference()
            
            // Create a storage reference from our storage service
            guard let image = self.plusPhotoButton.imageView?.image else {return}
            
            guard let uploadData = image.jpegData(compressionQuality:0.3) else {return}
            
            let filename = NSUUID().uuidString
            
            // Create a reference to the file you want to upload
            let profileImageRef = storageRef.child("profile_images").child(filename)
            
            // Upload the file to the path "images/rivers.jpg"
            _ = profileImageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                guard metadata != nil else {
                    // Uh-oh, an error occurred!
                    return
                }
                
                // You can also access to download URL after upload.
                profileImageRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        // Uh-oh, an error occurred!
                        return
                    }
                    print("Successfully uploaded profile image: ", downloadURL)
                    
                    guard let user = user?.user else { return }
                    
                    if let error = error {
                        print("Failed to create user: ", error)
                        return
                    }
                    print("Successfully created user: ", user.uid )
                    var ref: DatabaseReference!
                    
                    let dictionaryValues = ["name": name, "profileImageUrl": String(describing: downloadURL), "lastName": lastName, "email": email]
                    
                    let values = [user.uid: dictionaryValues]
                    ref = Database.database().reference()
                    ref.child("users").updateChildValues(values, withCompletionBlock: { (error, ref) in
                        if let error = error {
                            print("Failed to save user info into db: ", error)
                            return
                        }
                        print("Successfully saved user info to db")
                        let baseSlidingController = BaseSlidingController()
                        self.present(baseSlidingController, animated: true, completion: nil)
                        
                        
                    })
                }
            }
            
        }
    }
    
    let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: "Already have an account? ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: "Login", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 247, green: 208, blue: 120)]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        
        button.addTarget(self, action: #selector(handleAlreadyHaveAccount), for: .touchUpInside)
        return button
    }()
    
    @objc func handleAlreadyHaveAccount(){
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        navigationController?.navigationBar.tintColor = .gold()
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(top: nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        view.backgroundColor = .white
        
        view.addSubview(plusPhotoButton)
        view.addSubview(emailTextField)
        
        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
        
        
        plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        setupInputFields()
        
        
    }
    
    
    fileprivate func setupInputFields() {
        
        let stackView = UIStackView(arrangedSubviews: [nameTextField, lastNameTextField, emailTextField, passwordTextField, signupButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        
        
        stackView.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 200)
    }
    
    
}
