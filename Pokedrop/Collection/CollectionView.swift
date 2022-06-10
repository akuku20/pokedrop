//  CollectionView.swift
//  Pokedrop

import UIKit

final class CollectionView: BaseView {
    
    //MARK: - Variables
    
    private var searchView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 10
        view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.8).isActive = true
        view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.05).isActive = true
       return view
    }()
    
    private var searchImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.04).isActive = true
        view.widthAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        view.image = UIImage(named: "searchIcon")!
        return view
    }()
    
    private var searchBar: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = .appFont(ofSize: 17)
        field.textAlignment = .left
        field.backgroundColor = .clear
        field.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.7).isActive = true
        field.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.05).isActive = true
        field.text = "Search..."
        field.textColor = .lightGray
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        return field
    }()
    
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
        layout.minimumInteritemSpacing = 20
        let size = (UIScreen.main.bounds.width - 80) / 3
        layout.itemSize = CGSize(width: size, height: size)
        collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = UIEdgeInsets(top: 20.0, left: 10.0, bottom: 20.0, right: 10.0)
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.identifier)
    }
    
    private func setUp() {
        backgroundColor = .white
        
        addSubview(searchView)
        searchView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        searchView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
        searchView.addSubview(searchImage)
        searchImage.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 5).isActive = true
        searchImage.centerYAnchor.constraint(equalTo: searchView.centerYAnchor).isActive = true
        
        searchView.addSubview(searchBar)
        searchBar.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: UIScreen.main.bounds.height * 0.04 + 10).isActive = true
        searchBar.centerYAnchor.constraint(equalTo: searchView.centerYAnchor).isActive = true
        
        addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: searchView.bottomAnchor).isActive = true
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
        if let delegate = controller as? UITextFieldDelegate {
            searchBar.delegate = delegate
        }
    }
    
    func resetSearch() {
        searchBar.text = "Search..."
        searchBar.textColor = .lightGray
    }
    
    func reload() {
        collectionView.reloadData()
    }
}
