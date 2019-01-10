//
//  ViewController.swift
//  Rising2dtop
//
//  Created by Ramon Geronimo on 1/10/19.
//  Copyright © 2019 Ramon Geronimo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let navColor = UIColor(red: 211/255, green: 183/255, blue: 134/255, alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup background color
        view.backgroundColor = .white
        // Setup navbar
        setupNavigationStyle()
    }
    
    fileprivate func setupNavigationStyle(){
        navigationItem.title = "Companies"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = navColor
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }


}

