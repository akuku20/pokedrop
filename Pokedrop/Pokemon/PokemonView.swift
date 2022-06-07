//  PokemonView.swift
//  Pokedrop

import Foundation
import UIKit

final class PokemonView: BaseView {
    
    var onSellPress: (() -> Void)?
    
    let margin = UIScreen.main.bounds.height * 0.06
    
    private var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.25).isActive = true
        view.heightAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        return view
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .appFont(ofSize: 25, isBold: true)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var firstTypeImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.1).isActive = true
        view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.038).isActive = true
        return view
    }()

    private var secondTypeImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.1).isActive = true
        view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.038).isActive = true
        return view
    }()

    private var button = BottomButtonFactory.createButton()

    override init() {
        super.init()
        setUp()
    }
    
    private func setUp() {
        addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 1.5 * margin).isActive = true
        
        addSubview(nameLabel)
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0.33 * margin).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        
        addSubview(firstTypeImage)
        firstTypeImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        firstTypeImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: UIScreen.main.bounds.width * 0.06 + 1.5 * margin).isActive = true
        
        addSubview(secondTypeImage)
        secondTypeImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        secondTypeImage.topAnchor.constraint(equalTo: firstTypeImage.bottomAnchor, constant: 0.67 * margin).isActive = true

        addSubview(button)
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -0.67 * margin).isActive = true
        button.addTarget(self, action: #selector(sellPressed), for: .touchUpInside)
    }

    func configure(image: UIImage,
                   name: String,
                   background: UIImage,
                   firstType: UIImage?,
                   secondType: UIImage?,
                   starsView: UIView,
                   buttonText: NSMutableAttributedString) {
        imageView.image = image
        nameLabel.text = name
        backgroundColor = UIColor(patternImage: background)
        button.setAttributedTitle(buttonText, for: .normal)
        if let img = firstType {
            firstTypeImage.image = img
        }
        
        addSubview(starsView)
        starsView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        starsView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0.33 * margin).isActive = true
        
        if let img = secondType {
            secondTypeImage.image = img
        } else {
            secondTypeImage.isHidden = true
        }
    }
    
    @objc func sellPressed() {
        onSellPress?()
    }
}
