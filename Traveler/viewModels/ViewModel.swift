//
//  ViewModel.swift
//  Traveler
//
//  Created by Samim Hakimi on 4/12/22.
//

import Foundation
import FirebaseFirestore

protocol ItemsDB {
    func add(listOf items: ItemViewModel)->Bool
    func delete(usingId id: String)-> Void
    func update(listOf items: ItemViewModel)-> Void
    func getAll(listOf items: ItemViewModel)->[ItemModel]
 
}

class ItemViewModel: Identifiable {
    
    var id: String
    var name: String
    var quantity: Int
    var isComplete: Bool

    init(id:String, name:String, qty:Int, isComplete: Bool){
        self.id = id
        self.name = name
        self.quantity = qty
        self.isComplete = isComplete
    }
    
    
}

class CityViewModel: Identifiable {
    
    var cityName: String
    
    init(cityName: String) {
        self.cityName = cityName
    
    }
    
}


class GenderViewModel: Identifiable {
    var gender: String
    
    init(gender: String) {
        self.gender = gender
        
    }
}

class DayViewModel {
    var day: String
    init(day: String) {
        self.day = day
    }
}
