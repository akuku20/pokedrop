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
        button.clipsToBounds = true
        button.setBackgroundColor(.white, for: .normal)
        button.setBackgroundColor(.lightGray, for: .highlighted)
        return button
    }
}

final class BottomButtonFactory: ButtonFactory {
    
    static override func createButton() -> UIButton {
        let button = super.createButton()
        button.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.85).isActive = true
        button.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.06).isActive = true
        return button
    }
}

extension UIButton {
    
    private func image(withColor color: UIColor) -> UIImage? {
            let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
            UIGraphicsBeginImageContext(rect.size)
            let context = UIGraphicsGetCurrentContext()

            context?.setFillColor(color.cgColor)
            context?.fill(rect)

            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return image
    }
    
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        setBackgroundImage(image(withColor: color), for: state)
    }
}
