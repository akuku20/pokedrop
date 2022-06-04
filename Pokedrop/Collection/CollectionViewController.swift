//  CollectionViewController.swift
//  Pokedrop

import UIKit

final class CollectionViewController: BaseViewController {

    //MARK: - Variables
    
    private var mainView = CollectionView()
    private var viewModel: CollectionViewModel!
    
    //MARK: - Lifecycle
    
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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if PokemonDatabase.shared.listFetchPending {
            showLoader()
            PokemonDatabase.shared.fetchData { [weak self] error in
                guard error.isNil else {
                    fatalError(error!)
                }
                self?.hideLoader()
            }
        }
    }
    
    //MARK: - Methods
    
}

