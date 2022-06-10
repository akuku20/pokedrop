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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.filterPokemons(by: "")
        mainView.resetSearch()
        mainView.endEditing(true)
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
        mainView.endEditing(true)
        let vm = PokemonViewModel(details: viewModel.pokemonDetails(at: indexPath.item),
                                  image: viewModel.pokemonImage(at: indexPath.item),
                                  from: .preview,
                                  entity: viewModel.pokemonEntity(at: indexPath.item))
        let vc = PokemonViewController(viewModel: vm)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        mainView.endEditing(true)
    }
}

extension CollectionViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "Search..." {
            textField.text = ""
            textField.textColor = .black
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.count == 0 {
            textField.textColor = .lightGray
            textField.text = "Search..."
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let nsString = NSString(string: textField.text ?? "")
        let finalString = String(nsString.replacingCharacters(in: range, with: string)).lowercased()
        viewModel.filterPokemons(by: finalString)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mainView.endEditing(true)
        return true
    }
}

extension CollectionViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}

extension CollectionViewController: CollectionModelOutput {
    func refresh() {
        mainView.reload()
    }
}

