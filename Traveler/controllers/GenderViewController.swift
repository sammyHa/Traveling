//
//  GenderViewController.swift
//  Traveler
//
//  Created by Samim Hakimi on 4/5/22.
//

import UIKit
import FirebaseFirestore
class GenderViewController: UIViewController {

    var isMale = false
    var isFemale = false
    public var data: String?
    var list = [WhereTo]()
    
    let db = Firestore.firestore()
    
    private let tempreture: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let cityName: UILabel = {
       let label = UILabel()
        label.text = "New York"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    private let genderLabel: UILabel = {
       let label = UILabel()
        label.text = "Male or Female"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = UIColor(red: 66/255, green: 179/255, blue: 229/255, alpha: 100)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
       let label = UILabel()
        label.text = "We ask so we can personalize you’r packing items."
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = UIColor(red: 131/255, green: 131/255, blue: 131/255, alpha: 100)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private let maleIcon: UIButton = {
        
        var button = UIButton()
        button.setImage(UIImage(named: "male_normal"), for: .normal)
        //button.setImage(UIImage(named: "male_selected"), for: .selected)
        button.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let femaleIcon: UIButton = {
        
        var button = UIButton()
        button.setImage(UIImage(named: "female_normal"), for: .normal)
        //button.setImage(UIImage(named: "female_selected"), for: .selected)
        button.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.backgroundColor = UIColor(red: 3/255, green: 154/255, blue: 221/255, alpha: 1.0)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(genderLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(nextButton)
        view.addSubview(femaleIcon)
        view.addSubview(maleIcon)
        view.addSubview(tempreture)
        view.addSubview(cityName)
       
        isTrue()
        setupLayouts()
//        cityName.text = data
        for i in list {
            tempreture.text = i.temp
            cityName.text = i.city
            
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        nextButton.addTarget(self, action: #selector(gotoNext), for: .touchUpInside)
        femaleIcon.addTarget(self, action: #selector(selectFemale(_:)), for: .touchUpInside)
        maleIcon.addTarget(self, action: #selector(selectMale(_:)), for: .touchUpInside)
        
    }
  
    
    func isTrue(){
        nextButton.isEnabled = false
        nextButton.backgroundColor = .lightGray
    }

    
    
    func setupLayouts(){
 
        NSLayoutConstraint.activate([
            tempreture.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tempreture.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            
            cityName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            cityName.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            
            
            genderLabel.topAnchor.constraint(equalTo: tempreture.bottomAnchor, constant: 140),
            genderLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            descriptionLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 0),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor, constant: 0),
            
            maleIcon.widthAnchor.constraint(equalToConstant: 120),
            maleIcon.heightAnchor.constraint(equalToConstant: 160),
            maleIcon.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            view.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: maleIcon.leadingAnchor, constant: -85),
            
            femaleIcon.widthAnchor.constraint(equalToConstant: 120),
            femaleIcon.heightAnchor.constraint(equalToConstant: 160),
            femaleIcon.leadingAnchor.constraint(equalTo: maleIcon.trailingAnchor, constant: 10),
            femaleIcon.topAnchor.constraint(equalTo: maleIcon.topAnchor),
            
            
            nextButton.widthAnchor.constraint(equalToConstant: 140),
            nextButton.heightAnchor.constraint(equalToConstant: 40),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
        ])
        
       
       
        
    }
    
    @objc func selectMale(_ sender: UIButton) {
        
        if isMale == false {
            nextButton.isEnabled = true
            nextButton.backgroundColor = UIColor(red: 3/255, green: 154/255, blue: 221/255, alpha: 1.0)

            sender.setImage(UIImage(named: "male_selected"), for: .normal)
            sender.backgroundColor = UIColor(red: 3/255, green: 154/255, blue: 221/255, alpha: 1.0)
            isMale = true
          
            isFemale = false
            femaleIcon.setImage(UIImage(named: "female_normal"), for: .normal)
            femaleIcon.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        }
    }
    
    
    @objc func selectFemale(_ sender: UIButton) {
       
        if isFemale == false {
            nextButton.isEnabled = true
            nextButton.backgroundColor = UIColor(red: 3/255, green: 154/255, blue: 221/255, alpha: 1.0)
            sender.setImage(UIImage(named: "female_selected"), for: .normal)
            sender.backgroundColor = UIColor(red: 3/255, green: 154/255, blue: 221/255, alpha: 1.0)
            isFemale = true
            isMale = false
            maleIcon.setImage(UIImage(named: "male_normal"), for: .normal)
            maleIcon.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)


        }
        
    }

    @objc func gotoNext(){
    
        let vc = NumberDaysTravelingViewController()
        navigationController?.pushViewController(vc, animated: true)
        if isFemale {
            let female = "Female"
            saveGender(gender: GenderViewModel(gender: female))
        }else if isMale {
            let male = "Male"
            saveGender(gender: GenderViewModel(gender: male))
        }
    }
    
    public func getWatherCityName1(){
        
        db.collection("whereTo").addSnapshotListener { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.list = snapshot.documents.map { d in
                            return WhereTo(id: d.documentID,
                                           city: d["cityName"] as? String ?? "No city",
                                           temp: d["temp"]  as? String ?? "No temp",
                                           days: d["travelingDays"]  as? String ?? "no travling days")
                        }
                    }
                   
                    
                }
            }else {
                print("error getting data")
            }
        }
    }
    
    
    
    func saveGender(gender: GenderViewModel) {
        db.collection("gender").document("gender").setData(["gender": gender.gender], merge: true) {error in
            if error == nil {
                print("Save Succefully")
            }else {
                print("error saving gender")
                return
            }
        }
    }
}
