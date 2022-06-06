//  OpenBallView.swift
//  Pokedrop

import Foundation
import UIKit
import CloudKit

final class OpenBallView: BaseView {
    
    //MARK: - Variables
    
    var onBuyPress: (() -> Void)!
    
    var proceedToPokemon: (() -> Void)!
    
    var delegate: OpenViewDrawDelegte!
    
    private var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.4).isActive = true
        view.heightAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        return view
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .appFont(ofSize: 20, isBold: true)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private var descLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .appFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var button = BottomButtonFactory.createButton()
    
    //MARK: - Lifecycle
    
    override init() {
        super.init()
        setUp()
    }
    
    //MARK: - Methods
    
    private func setUp() {
        backgroundColor = .white
        
        addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 75).isActive = true
        
        addSubview(nameLabel)
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 60).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        
        addSubview(descLabel)
        descLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        descLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 40).isActive = true
        descLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        descLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        addSubview(button)
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
    
    @objc private func buttonPressed() {
        switchInteraction(allowed: false)
        onBuyPress()
    }
    
    func configure(image: UIImage, name: String, description: String, buttonText: NSMutableAttributedString) {
        imageView.image = image
        nameLabel.text = name
        descLabel.text = description
        button.setAttributedTitle(buttonText, for: .normal)
    }
    
    func beginDraw(idx: Int) {
        UIView.animate(withDuration: 1, animations: { [weak self] in
            self?.imageView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }, completion: { [weak self] _ in
            UIView.animate(withDuration: 1, animations: {
                self?.imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: { _ in
                self?.showSinglePokemon(idx: 0, goalIdx: idx, time: 0.06)
            })
        })
    }
    
    private func showSinglePokemon(idx: Int, goalIdx: Int, time: Double) {
        imageView.image = delegate.pokemonImage(at: idx)
        UIView.animate(withDuration: time/3, animations: { [weak self] in
            self?.imageView.alpha = 1
        }, completion:  { [weak self] _ in
            guard idx < goalIdx else {
                self?.highlightImage()
                return
            }
            UIView.animate(withDuration: time/3, delay: time/3 ,animations: { [weak self] in
                self?.imageView.alpha = 0
            }, completion: { [weak self] _ in
                self?.showSinglePokemon(idx: idx + 1, goalIdx: goalIdx, time: time * 1.15)
            })
        })
    }
    
    private func highlightImage() {
        UIView.animate(withDuration: 0.5, delay: 0.2, animations: { [weak self] in
            self?.imageView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }, completion: { [weak self] _ in
            UIView.animate(withDuration: 0.5, animations: {
                self?.imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: { _ in
                self?.delegate.launchDrawFetch()
                self?.proceedToPokemon()
                self?.switchInteraction(allowed: true)
            })
        })
    }
}
