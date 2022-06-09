//  CollectionCell.swift
//  Pokedrop

import Foundation
import UIKit

final class CollectionCell: UICollectionViewCell {
    
    //MARK: - Variables
    
    static let identifier = "CollectionCell"
    
    private var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width) / 5).isActive = true
        view.widthAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        return view
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func setUp() {
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = (UIScreen.main.bounds.width - 80) / 12
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 0
        
        contentView.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    func configure(with image: UIImage) {
        imageView.image = image
    }
    
    func switchAppearance(highlight: Bool) {
        if highlight {
            contentView.layer.borderWidth = 1
        } else {
            contentView.layer.borderWidth = 0
        }
    }
}
