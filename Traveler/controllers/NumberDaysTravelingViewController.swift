//
//  NumberDaysTravelingViewController.swift
//  Traveler
//
//  Created by Samim Hakimi on 4/5/22.
//

import UIKit
import FirebaseFirestore

protocol NumberDayDelegate {
    func getDayValue()
}

class NumberDaysTravelingViewController: UIViewController {

    var days: String?
    var daysAdded: String?
    var db = Firestore.firestore()
    var numberDayDelegate: NumberDayDelegate?
    

    private let parentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    public let numberOfDaysLabel: UILabel = {
       let label = UILabel()
        label.text = "How long do you want to pack for?"
        label.numberOfLines = 0
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
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.backgroundColor = UIColor(red: 3/255, green: 154/255, blue: 221/255, alpha: 1.0)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    public let sliderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .center
        label.text = "0"
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let sliderDays : UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 100
        slider.layer.cornerRadius = 15
        slider.isContinuous = true
        slider.tintColor = .lightGray
        slider.thumbTintColor = UIColor(red: 64/255, green: 178/255, blue: 255/255, alpha: 1)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(parentView)
        parentView.addSubview(numberOfDaysLabel)
        
        parentView.addSubview(descriptionLabel)
        parentView.addSubview(nextButton)
        parentView.addSubview(sliderDays)
        parentView.addSubview(sliderLabel)
        
        UIView.animate(withDuration: 1000){
            self.sliderDays.setValue(1.0, animated: true)
        }

        view.backgroundColor = .white
        nextButton.isEnabled = false
        nextButton.backgroundColor = .lightGray
        setupLayouts()

    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sliderDays.addTarget(self, action: #selector(sliderValueDidChange(_ :)), for: .valueChanged)
        nextButton.addTarget(self, action: #selector(done), for: .touchUpInside)
        
    }
    
    
    func buttonLayoutAlignment(button: UIButton) {
        button.widthAnchor.constraint(equalToConstant: 140).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func sliderLayouts(slider: UISlider) {
        slider.widthAnchor.constraint(equalToConstant: 300).isActive = true
        slider.heightAnchor.constraint(equalToConstant: 50).isActive = true
        slider.topAnchor.constraint(equalTo: sliderLabel.bottomAnchor, constant: 10).isActive = true
        slider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupLayouts(){
       
        NSLayoutConstraint.activate([
            parentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            parentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            parentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            parentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            numberOfDaysLabel.topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor, constant: 100.0),
            numberOfDaysLabel.leadingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            numberOfDaysLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor),
            numberOfDaysLabel.trailingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            
            
            descriptionLabel.leadingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            descriptionLabel.trailingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            descriptionLabel.bottomAnchor.constraint(equalTo: sliderLabel.topAnchor, constant: -20),
            
        
            sliderLabel.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            sliderLabel.bottomAnchor.constraint(equalTo: sliderDays.topAnchor, constant: -20),
            
            sliderDays.leadingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            sliderDays.trailingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            
            
            nextButton.widthAnchor.constraint(equalToConstant: 140),
            nextButton.heightAnchor.constraint(equalToConstant: 40),
            nextButton.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            nextButton.topAnchor.constraint(equalTo: sliderDays.bottomAnchor, constant: 50)
        ])
        

    }
   

    @objc func sliderValueDidChange(_ sender: UISlider) {
        
        let step: Float = 30
        let roundedStepValue = round(sender.value / step * step)
        sender.value = roundedStepValue
        sliderLabel.text = String(Int(roundedStepValue))
        
        if sliderDays.value > 0 {
            nextButton.isEnabled = true
           
            nextButton.backgroundColor = UIColor(red: 3/255, green: 154/255, blue: 221/255, alpha: 1.0)
        }

    }
    
    
    @objc func done(_ send: Any){
        guard let days = sliderLabel.text else {
            return
        }

        saveDays(daysTravling: DayViewModel(day: days))
        let name = Notification.Name("colorChanged")
        NotificationCenter.default.post(name: name, object: ["days": Int(sliderLabel.text ?? "0")])
        
        
        let tabBarController = self.tabBarController
        _ = self.navigationController?.popToRootViewController(animated: false)
        tabBarController?.selectedIndex = 2
        
       
        
    }
    
    //add data to the database
    func saveDays(daysTravling: DayViewModel){
        db.collection("whereTo").document("lMDeLSEhswOW0DsFSCgr").setData(["travelingDays" : daysTravling.day], merge: true) { error in
            if error == nil {
                print("City name \(daysTravling.day) is saved")
            }else {
                print("Error saving cityname.")
            }
        }
    }
    
   
}
