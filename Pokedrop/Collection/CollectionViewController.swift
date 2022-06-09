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
        self.viewModel.output = self
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDefaultNavBar(title: "Collection")
        CoinManager.shared.startupFetch()
        mainView.bindCollection(to: self)
        viewModel.setUpData()
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
}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfPokemon
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.identifier, for: indexPath) as? CollectionCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: viewModel.pokemonImage(at: indexPath.item))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vm = PokemonViewModel(details: viewModel.pokemonDetails(at: indexPath.item),
                                  image: viewModel.pokemonImage(at: indexPath.item),
                                  from: .preview,
                                  entity: viewModel.pokemonEntity(at: indexPath.item))
        let vc = PokemonViewController(viewModel: vm)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CollectionCell {
            cell.switchAppearance(highlight: true)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CollectionCell {
            cell.switchAppearance(highlight: false)
        }
    }
}

extension CollectionViewController: CollectionModelOutput {
    func refresh() {
        mainView.reload()
    }
}

