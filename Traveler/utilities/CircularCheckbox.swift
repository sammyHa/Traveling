//
//  CircularCheckbox.swift
//  Traveler
//
//  Created by Samim Hakimi on 4/10/22.
//

import UIKit

class CircularCheckbox: UIView {

    private var isChecked = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderColor = CGColor(red: 1/255, green: 126/255, blue: 181/255, alpha: 1.0)
        layer.borderWidth = 0.5
        layer.cornerRadius = frame.size.width/2.0
        layer.backgroundColor = UIColor.white.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toggle(){
        self.isChecked = !isChecked
        if isChecked {
            layer.backgroundColor = CGColor(red: 1/255, green: 126/255, blue: 181/255, alpha: 1.0)
            
        }else {
            layer.backgroundColor = UIColor.white.cgColor
        }
    }
    
}
