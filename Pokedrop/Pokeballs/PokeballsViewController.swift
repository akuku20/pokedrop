//  PokeballsViewController.swift
//  Pokedrop

import Foundation
import UIKit

final class PokeballsViewController: BaseViewController {

    //MARK: - Variables
    
    private var mainView = PokeballsView()
    private var viewModel: PokeballsViewModel!
    
    //MARK: - Lifecycle
    
    convenience init(viewModel: PokeballsViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDefaultNavBar(title: "Open Poké Ball")
        mainView.bindCollection(to: self)
    }
}

//MARK: - UICollectionViewDelegate & DataSource

extension PokeballsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfPokeballs
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokeballsCell.identifier, for: indexPath) as? PokeballsCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: viewModel.pokeballAt(row: indexPath.item))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vm = OpenBallViewModel(pokeball: viewModel.pokeballAt(row: indexPath.item))
        let vc = OpenBallViewController(viewModel: vm)
        navigationController?.pushViewController(vc, animated: true)
    }
}
