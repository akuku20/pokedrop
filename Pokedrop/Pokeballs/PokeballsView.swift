//  PokeballsView.swift
//  Pokedrop

import UIKit

final class PokeballsView: BaseView {
    
    //MARK: - Variables
    
    private var collectionView: UICollectionView!
    
    //MARK: - Lyfecycle
    
    override init() {
        super.init()
        setUpCollectionView()
        setUp()
    }
    
    //MARK: - Methods
    
    private func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: 150)
        collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 20.0, right: 0.0)
        collectionView.register(PokeballsCell.self, forCellWithReuseIdentifier: PokeballsCell.identifier)
    }
    
    private func setUp() {
        backgroundColor = .white
        
        addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func bindCollection(to controller: UIViewController) {
        if let delegate = controller as? UICollectionViewDelegate {
            collectionView.delegate = delegate
        }
        if let dataSource = controller as? UICollectionViewDataSource {
            collectionView.dataSource = dataSource
        }
    }
}
