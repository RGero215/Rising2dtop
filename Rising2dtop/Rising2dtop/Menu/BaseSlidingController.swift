//
//  BaseSlidingController.swift
//  Rising2dtop
//
//  Created by Ramon Geronimo on 1/12/19.
//  Copyright © 2019 Ramon Geronimo. All rights reserved.
//

import UIKit
import Firebase

class RightContainerView: UIView {}
class MenuContainerView: UIView {}
class DarkContainerView: UIView {}

class BaseSlidingController: UIViewController {
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    let rightContainer: RightContainerView = {
        let v = RightContainerView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        return v
    }()
    
    let menuContainer: MenuContainerView = {
        let v = MenuContainerView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let darkCoverView: DarkContainerView = {
        let v = DarkContainerView()
        v.backgroundColor = UIColor(white: 0, alpha: 0.7)
        v.alpha = 0
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBar.layer.zPosition = -1

        if Auth.auth().currentUser == nil {
            
            DispatchQueue.main.async {
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
            }
            return
        }
        setupLayout()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss))
        darkCoverView.addGestureRecognizer(tapGesture)
        
    }
    
    @objc fileprivate func handleTapDismiss(){
        closeMenu()
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer){
        let translation = gesture.translation(in: view)
        var x = translation.x
        
        x = isMenueOpened ? x + menuWidth : x
        x = min(menuWidth, x)
        x = max(0, x)
        
        rightContainerLeadingConstraint.constant = x
        rightContainerTrailingConstraint.constant = x
        darkCoverView.alpha = x / menuWidth
        
        if gesture.state == .ended {
            handleEnded(gesture: gesture)
        }
    }
    
    fileprivate func handleEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        if isMenueOpened {
            if abs(velocity.x) > velocityThreshold {
                closeMenu()
                return
            }
            if abs(translation.x) < menuWidth / 2 {
                openMenu()
            } else {
                closeMenu()
            }
        } else {
            if abs(velocity.x) > velocityThreshold {
                openMenu()
                return
            }
            if translation.x < menuWidth / 2 {
                closeMenu()
            } else {
                openMenu()
            }
        }
        
    }
    
    func openMenu() {
        isMenueOpened = true
        rightContainerLeadingConstraint.constant = menuWidth
        rightContainerTrailingConstraint.constant = menuWidth
        performAnimations()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func closeMenu() {
        rightContainerLeadingConstraint.constant = 0
        rightContainerTrailingConstraint.constant = 0
        isMenueOpened = false
        performAnimations()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isMenueOpened ? .default : .lightContent
    }
    
    func didSelectMenuItem(indexPath: IndexPath) {
        performRightViewCleanUp()
        closeMenu()
        
        switch indexPath.row {
        case 0:
            rightViewController = CustomNavigationController(rootViewController: CompaniesController())
        case 1:
            rightViewController = CustomNavigationController(rootViewController: ServicesController())
        case 2:
            rightViewController = CustomNavigationController(rootViewController: ProjectsWeLoveController())
        case 3:
            rightViewController = CustomNavigationController(rootViewController: TellYourStoryController())
        case 4:
            rightViewController = DonateController()
        case 5:
            rightViewController = ScanController()
        default:
            print("Working on it")
        }
        rightContainer.addSubview(rightViewController.view)
        addChild(rightViewController)
        
        rightContainer.bringSubviewToFront(darkCoverView)
        
    }
    
    lazy var menuController = MenuController()
    lazy var companiesController = CompaniesController()
    
    lazy var customController = CustomNavigationController(rootViewController: self.companiesController)
    lazy var rightViewController: UIViewController = self.customController
    
    
    
    func performRightViewCleanUp(){
        rightViewController.view.removeFromSuperview()
        rightViewController.removeFromParent()
    }
    
    fileprivate func performAnimations(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.darkCoverView.alpha = self.isMenueOpened ? 1 : 0
        })
    }
    
    var rightContainerLeadingConstraint: NSLayoutConstraint!
    var rightContainerTrailingConstraint: NSLayoutConstraint!
    fileprivate let menuWidth: CGFloat = 300
    fileprivate let velocityThreshold: CGFloat = 500
    fileprivate var isMenueOpened = false
    
    fileprivate func setupLayout() {
        view.addSubview(rightContainer)
        view.addSubview(menuContainer)
        
        NSLayoutConstraint.activate([
            rightContainer.topAnchor.constraint(equalTo: view.topAnchor),
            rightContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            menuContainer.topAnchor.constraint(equalTo: view.topAnchor),
            menuContainer.trailingAnchor.constraint(equalTo: rightContainer.leadingAnchor),
            menuContainer.widthAnchor.constraint(equalToConstant: menuWidth),
            menuContainer.bottomAnchor.constraint(equalTo: rightContainer.bottomAnchor)
            
            
            ])
        rightContainerLeadingConstraint = rightContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        rightContainerLeadingConstraint.isActive = true
        
        rightContainerTrailingConstraint = rightContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        rightContainerTrailingConstraint.isActive = true
        
        
        setupViewControllers()
    }
    
    fileprivate func setupViewControllers(){
        
        let slideView = rightViewController.view!
        let menuView = menuController.view!
        
        
        slideView.translatesAutoresizingMaskIntoConstraints = false
        menuView.translatesAutoresizingMaskIntoConstraints = false
        
        rightContainer.addSubview(slideView)
        rightContainer.addSubview(darkCoverView)
        menuContainer.addSubview(menuView)
        
        NSLayoutConstraint.activate([
            slideView.topAnchor.constraint(equalTo: rightContainer.topAnchor),
            slideView.leadingAnchor.constraint(equalTo: rightContainer.leadingAnchor),
            slideView.bottomAnchor.constraint(equalTo: rightContainer.bottomAnchor),
            slideView.rightAnchor.constraint(equalTo: rightContainer.rightAnchor),
            
            menuView.topAnchor.constraint(equalTo: menuContainer.topAnchor),
            menuView.leadingAnchor.constraint(equalTo: menuContainer.leadingAnchor),
            menuView.bottomAnchor.constraint(equalTo: menuContainer.bottomAnchor),
            menuView.rightAnchor.constraint(equalTo: menuContainer.rightAnchor),
            
            darkCoverView.topAnchor.constraint(equalTo: rightContainer.topAnchor),
            darkCoverView.leadingAnchor.constraint(equalTo: rightContainer.leadingAnchor),
            darkCoverView.bottomAnchor.constraint(equalTo: rightContainer.bottomAnchor),
            darkCoverView.trailingAnchor.constraint(equalTo: rightContainer.trailingAnchor),
            
            ])
        addChild(rightViewController)
        addChild(menuController)
    }
    
}
