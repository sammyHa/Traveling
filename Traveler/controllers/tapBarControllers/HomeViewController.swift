//
//  HomeViewController.swift
//  Traveler
//
//  Created by Samim Hakimi on 4/9/22.
//

import UIKit

class HomeViewController: UIViewController {

    var days: String?
    var observer: NSObjectProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let name = Notification.Name("colorChanged")
        observer = NotificationCenter.default.addObserver(forName: name, object: nil, queue: .main) { notification in
            guard let object = notification.object as? [String: Int] else {
                return
            }
            
            guard let days = object["days"] else {
                return
            }
            
            print("days received \(days)")
        }
    }
    

    @objc func notificationReceived() {
        view.backgroundColor = .red
    
    }
    
}
