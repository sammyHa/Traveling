//
//  LoginViewController.swift
//  Traveler
//
//  Created by Samim Hakimi on 4/11/22.
//

import UIKit

class LoginViewController: UIViewController {
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = UIColor(red: 3/255, green: 154/255, blue: 221/255, alpha: 1.0)
        button.layer.cornerRadius = 20
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginButton)
        
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loginButton.frame = CGRect(x: 100, y: 300, width: 145, height: 45)
        loginButton.addTarget(self, action: #selector(gotoNext), for: .touchUpInside)
    }
    

    @objc func gotoNext(){
        
        let nav = NavigationViewController()
        
        present(nav, animated: false)
        
    }


}
