//
//  CustomHeaderView.swift
//  Rising2dtop
//
//  Created by Ramon Geronimo on 1/12/19.
//  Copyright © 2019 Ramon Geronimo. All rights reserved.
//

import Foundation
import UIKit

class CustomMenuHeaderView: UIView {
    
    let nameLabel = UILabel()
    let usernameLabel = UILabel()
    let statsLabel = UILabel()
    let profileImageView = ProfileImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupComponentProps()
        
        
        setupStackView()
        
        
    }
    
    // MARK:- Fileprivate
    fileprivate func setupComponentProps() {
        // Custom components for header
        nameLabel.text = "Rising To The Top"
        nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        nameLabel.textColor = .gold()
        usernameLabel.text = "rising2dtop.org"
        usernameLabel.textColor = UIColor(white: 0, alpha: 0.5)
        statsLabel.text = "42 Following 7091 Followers"
        profileImageView.image = #imageLiteral(resourceName: "app_icon").withRenderingMode(.alwaysOriginal)
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.cornerRadius = 5
        profileImageView.clipsToBounds = true
        
        setupStatsAttributedText()
    }
    
    fileprivate func setupStatsAttributedText(){
        statsLabel.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        let attributedText = NSMutableAttributedString(string: "3% ", attributes: [.font: UIFont.systemFont(ofSize: 15, weight: .medium), .foregroundColor: UIColor.gold()])
        attributedText.append(NSMutableAttributedString(string: "Fiscal Sponsorship ", attributes: [.foregroundColor: UIColor.gold()]))
        attributedText.append(NSAttributedString(string: "services", attributes: [.font: UIFont.systemFont(ofSize: 15, weight: .medium), .foregroundColor: UIColor.gold()]))
        statsLabel.attributedText = attributedText
    }
    
    fileprivate func setupStackView() {
        let rightSpacerView = UIView()
        let arrangedSubviews = [
            UIStackView(arrangedSubviews: [profileImageView, rightSpacerView]),
            nameLabel,
            usernameLabel,
            SpacerView(space: 16),
            statsLabel
        ]
        
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 4
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
