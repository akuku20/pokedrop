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
                           stars: viewModel.starsAmount,
                           background: viewModel.backgroundImage,
                           firstType: viewModel.typeImage(isFirst: true),
                           secondType: viewModel.typeImage(isFirst: false),
                           buttonText: viewModel.buttonString)
    }
}

extension PokemonViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

