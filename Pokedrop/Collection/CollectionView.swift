//  CollectionView.swift
//  Pokedrop

import UIKit

final class CollectionView: BaseView {
    
    //MARK: - Variables
    
    //MARK: - Lifecycle
    
    override init() {
        super.init()
        setUp()
    }
    
    //MARK: - Methods
    
    private func setUp() {
        backgroundColor = .white
    }
}
