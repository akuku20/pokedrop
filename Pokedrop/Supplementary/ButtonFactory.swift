//  ButtonFactory.swift
//  Pokedrop

import Foundation
import UIKit

class ButtonFactory {
    
    class func createButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 10
        button.titleLabel?.textColor = .black
        return button
    }
}

final class BottomButtonFactory: ButtonFactory {
    
    static override func createButton() -> UIButton {
        let button = super.createButton()
        button.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.85).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }
}
