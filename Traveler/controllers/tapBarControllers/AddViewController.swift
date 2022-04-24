//
//  AddViewController.swift
//  Traveler
//
//  Created by Samim Hakimi on 4/9/22.
//

import UIKit
import Foundation
import FirebaseFirestore

class AddViewController: UIViewController, UITextFieldDelegate {
    
    private let db = Firestore.firestore()
    

    private let locationImage: UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "city")
        return image
    }()
    
    private let whereToLabel: UILabel = {
       let label = UILabel()
        label.text = "Where to?"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = UIColor(red: 66/255, green: 179/255, blue: 229/255, alpha: 100)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
       let label = UILabel()
        label.text = "We ask so we can personalize you’r packing items."
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = UIColor(red: 131/255, green: 131/255, blue: 131/255, alpha: 100)
        return label
        
    }()
    
    private let locationNameTextfield: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Enter city name or zip code"
        textField.font = .systemFont(ofSize: 18, weight: .regular)
        textField.textColor = UIColor(red: 131/255, green: 131/255, blue: 131/255, alpha: 1.0)
        textField.layer.borderColor = CGColor(red: 131/255, green: 131/255, blue: 131/255, alpha: 1.0)
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 0.5
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 10))
        textField.leftViewMode = .always
        textField.leftView = padding
        return textField
        
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.backgroundColor = UIColor(red: 3/255, green: 154/255, blue: 221/255, alpha: 1.0)
        button.layer.cornerRadius = 20
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    

        view.addSubview(locationImage)
        view.addSubview(whereToLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(locationNameTextfield)
        view.addSubview(nextButton)
        view.backgroundColor = .white
        
        locationNameTextfield.delegate = self
        self.hideKeyboard()
        
        locationImage.contentMode = .scaleAspectFit
        locationImage.translatesAutoresizingMaskIntoConstraints = false
        whereToLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        locationNameTextfield.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false

        nextButton.isEnabled = false
        nextButton.backgroundColor = .lightGray
       
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text!.count > 3 {
            nextButton.isEnabled = true
            nextButton.backgroundColor = UIColor(red: 3/255, green: 154/255, blue: 221/255, alpha: 1.0)

        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupLayouts()
        
    }

    func buttonLayoutAlignment(button: UIButton) {
        button.widthAnchor.constraint(equalToConstant: 140).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.addTarget(self, action: #selector(gotoGender), for: .touchUpInside)
    }
    
    func setupLayouts(){
        locationImage.centerXAnchor.constraint(equalTo: view.centerXAnchor ).isActive = true
        locationImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        
        whereToLabel.topAnchor.constraint(equalTo: locationImage.bottomAnchor, constant: 40).isActive = true
        whereToLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        
        descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: whereToLabel.bottomAnchor, constant: 0).isActive = true
        view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor, constant: 0).isActive = true
        
        locationNameTextfield.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 60).isActive = true
        locationNameTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        
        locationNameTextfield.widthAnchor.constraint(equalToConstant: view.frame.width-100).isActive = true
        locationNameTextfield.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        buttonLayoutAlignment(button: nextButton)
    }
    

    
    func decodeJsonData(jsonData: Data){
       
        do {
            let weatherData = try? JSONDecoder().decode(WeatherMain.self, from: jsonData)
            if let weatherData = weatherData {
                let weather = weatherData.main
                db.collection("whereTo").document("lMDeLSEhswOW0DsFSCgr").setData(["temp" : weather.temp!], merge: true) { error
                    in
                    if error != nil {
                        print("error getting weather data")
                        return
                    }else {
                        let vc = GenderViewController()
                        vc.getWatherCityName1()
                        print("temp saved to db")
                    }
                }
               
            }
        }
    }
    
    func getWeather(city: String){
        
        let APIKEY = "fb621d4c063ea1536d18cf7f6ea52605"
        
        let url =  "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(APIKEY)&units=imperial"
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
       
        URLSession.shared.dataTask(with: URL(string: urlString!)!) { data, res, error in
            if let data = data {
                self.decodeJsonData(jsonData: data)
            }
        }.resume()
    }
    
    // save to firebase
    
    func saveCity(city: CityViewModel){
        db.collection("whereTo").document("lMDeLSEhswOW0DsFSCgr").setData(["cityName" : city.cityName], merge: true) { error in
            
            if error == nil{
                print("City name saved")
                
            }else {
                print("Error saving cityname.")
                return
            }
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
    
    

    
    @objc func gotoGender(){
       
        guard let city = locationNameTextfield.text, !city.isEmpty else {
            return
        }
        
        saveCity(city: CityViewModel(cityName: city))
        getWeather(city: city)
        let vc =  GenderViewController()
        navigationController?.pushViewController(vc, animated: true)
        vc.data = locationNameTextfield.text
        
        
    }
}


extension UIViewController {
    func hideKeyboard(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
