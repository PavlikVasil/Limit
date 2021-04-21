//
//  CustomButton.swift
//  Limit
//
//  Created by Павел on 21.04.2021.
//

import UIKit

class CustomButton: UIButton {
    
    
    override init(frame: CGRect){
            super.init(frame: frame)
            setup()
        }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel?.font = UIFont(name: "GT America Mono", size: 12)
        self.setTitleColor(#colorLiteral(red: 0.137254902, green: 0.1490196078, blue: 0.1725490196, alpha: 1), for: .normal)
        let image = UIImage(named: "Vector")
        self.setImage(image, for: .normal)
        self.imageView?.contentMode = .right
        self.imageView?.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        self.imageView?.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25.93).isActive = true
        self.titleLabel?.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24).isActive = true
        self.titleLabel?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.imageView?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }

}
