//
//  ViewController.swift
//  Traveler
//
//  Created by Samim Hakimi on 4/3/22.


import UIKit
import FirebaseFirestore

class ViewController: UIViewController {
    var database = Firestore.firestore()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    private let descriptionLabel: UILabel = {
       let label = UILabel()
        label.text = "We ask so we can personalize you’r packing items."
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = UIColor(red: 131/255, green: 131/255, blue: 131/255, alpha: 100)
        return label
        
    }()
    
    override func viewDidLoad() {

        super.viewDidLoad()
        view.addSubview(nextButton)
        let docRef = database.document("males/lRrXnGsyRzIGuyAb3KKm").collection("clothing").document("TgvmXX2v6xNuVLeYIYdQ")
        docRef.addSnapshotListener { docSnapshot, error in
            guard let data = docSnapshot?.data(), error == nil else {
                return
            }
    
            for (key, val) in data {
                print("keys: \(key), values \(val)")
            }
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nextButton.frame = CGRect(x: 50, y: 100, width: 130, height: 35)
        nextButton.addTarget(self, action: #selector(clickNext), for: .touchUpInside)
    }
    
    @objc func clickNext(){
        let location = AddViewController()
        location.modalPresentationStyle = .fullScreen

        present(location, animated: false)
    }

}

