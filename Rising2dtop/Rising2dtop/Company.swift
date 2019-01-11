//
//  Company.swift
//  Rising2dtop
//
//  Created by Ramon Geronimo on 1/10/19.
//  Copyright © 2019 Ramon Geronimo. All rights reserved.
//

import Foundation

typealias SocialLinkData = (link: String, type: SocialLink)

/// The Information For The Business Card Node & Contact Details
struct Company{
    
    var firstName: String
    var surname: String
    var userImage: String
    var cardImage: String
    var position: String
    var company: String
    var address: BusinessAddress
    var website: SocialLinkData
    var phoneNumber: String
    var email: String
    var accountOne: SocialLinkData
    var accountTwo: SocialLinkData
}

/// The Associates Business Address
struct BusinessAddress{
    
    var street: String
    var city: String
    var state: String
    var postalCode: String
    var coordinates: (latittude: Double, longtitude: Double)
}



/// The Type Of Social Link
///
/// - Website: Business Website
/// - StackOverFlow: StackOverFlow Account
/// - GitHub: Github Account
enum SocialLink: String{
    
    case Website
    case StackOverFlow
    case GitHub
    case Youtube
}
