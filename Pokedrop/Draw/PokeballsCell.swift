//  PokeballsCell.swift
//  Pokedrop

import Foundation
import UIKit

final class PokeballsCell: UICollectionViewCell {
    
    static let identifier = "PokeballCell"
    
    private var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.heightAnchor.constraint(equalToConstant: 80).isActive = true
        view.widthAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        return view
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .appFont(ofSize: 17, isBold: true)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private var descLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .appFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private var coinImgView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "coinIcon")
        view.heightAnchor.constraint(equalToConstant: 32).isActive = true
        view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.67).isActive = true
        return view
    }()
    
    private var amountLabel: UILabel = {
        let label = UILabel()
        label.font = .appFont(ofSize: 18, isBold: true)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()
    
    private var priceView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 50).isActive = true
        view.heightAnchor.constraint(equalToConstant: 32).isActive = true
        return view
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        contentView.backgroundColor = .lightGray
        contentView.layer.cornerRadius = 20
        
        contentView.addSubview(imageView)
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        contentView.addSubview(nameLabel)
        nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -80).isActive = true
        nameLabel.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        
        contentView.addSubview(descLabel)
        descLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        descLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -80).isActive = true
        descLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        
        contentView.addSubview(priceView)
        priceView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        priceView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        
        priceView.addSubview(coinImgView)
        coinImgView.leadingAnchor.constraint(equalTo: priceView.leadingAnchor).isActive = true
        coinImgView.centerYAnchor.constraint(equalTo: priceView.centerYAnchor).isActive = true
        
        priceView.addSubview(amountLabel)
        amountLabel.leadingAnchor.constraint(equalTo: coinImgView.trailingAnchor, constant: 4).isActive = true
        amountLabel.centerYAnchor.constraint(equalTo: priceView.centerYAnchor).isActive = true
    }
    
    func configure(with pokeball: PokeballsViewModel.Pokeball) {
        imageView.image = pokeball.image
        nameLabel.text = pokeball.name
        descLabel.text = pokeball.description
        amountLabel.text = String(pokeball.price)
    }
    
}
