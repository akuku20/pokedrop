//  PokemonViewController.swift
//  Pokedrop

import Foundation
import UIKit

final class PokemonViewController: BaseViewController {
    
    private var mainView = PokemonView()
    private var viewModel: PokemonViewModel!
    
    convenience init(viewModel: PokemonViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDefaultNavBar(title: "Pokémon")
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        mainView.configure(image: viewModel.pokemonImage,
                           name: viewModel.name,
                           background: viewModel.backgroundImage,
                           firstType: viewModel.typeImage(isFirst: true),
                           secondType: viewModel.typeImage(isFirst: false),
                           starsView: viewModel.starsView(),
                           buttonText: viewModel.buttonString)
        
        mainView.onSellPress = {
            CoinManager.shared.changeBalance(by: self.viewModel.price)
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension PokemonViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

