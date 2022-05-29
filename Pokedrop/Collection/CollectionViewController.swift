//  CollectionViewController.swift
//  Pokedrop

import UIKit

final class CollectionViewController: UIViewController {

    private var mainView = CollectionView()
    private var viewModel: CollectionViewModel!
    
    convenience init(viewModel: CollectionViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDefaultNavBar(title: "Collection")
    }


}

