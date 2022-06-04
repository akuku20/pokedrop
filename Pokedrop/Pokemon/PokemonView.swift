//  PokemonView.swift
//  Pokedrop

import Foundation
import UIKit

final class PokemonView: BaseView {
    
    private var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.5).isActive = true
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
        view.widthAnchor.constraint(equalToConstant: 95).isActive = true
        view.heightAnchor.constraint(equalToConstant: 36.1).isActive = true
        return view
    }()

    private var secondTypeImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.widthAnchor.constraint(equalToConstant: 95).isActive = true
        view.heightAnchor.constraint(equalToConstant: 36.1).isActive = true
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
        imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 75).isActive = true
        
        addSubview(nameLabel)
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        
        addSubview(firstTypeImage)
        firstTypeImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        firstTypeImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30).isActive = true
        
        addSubview(secondTypeImage)
        secondTypeImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        secondTypeImage.topAnchor.constraint(equalTo: firstTypeImage.bottomAnchor, constant: 30).isActive = true

        addSubview(button)
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }

    func configure(image: UIImage,
                   name: String,
                   stars: Int,
                   background: UIImage,
                   firstType: UIImage?,
                   secondType: UIImage?,
                   buttonText: NSMutableAttributedString) {
        imageView.image = image
        nameLabel.text = name
        //TODO: Stars amount
        backgroundColor = UIColor(patternImage: background)
        button.setAttributedTitle(buttonText, for: .normal)
        if let img = firstType {
            firstTypeImage.image = img
        }
        if let img = secondType {
            secondTypeImage.image = img
        } else {
            secondTypeImage.isHidden = true
        }
    }
}
