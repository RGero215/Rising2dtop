//
//  User.swift
//  Rising2dtop
//
//  Created by Ramon Geronimo on 1/12/19.
//  Copyright © 2019 Ramon Geronimo. All rights reserved.
//

import Foundation

struct User {
    let uid: String
    let firstName: String
    let lastName: String
    let email: String
    let profileImageUrl: String
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.firstName = dictionary["firstName"] as? String ?? ""
        self.lastName = dictionary["lastName"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
}
