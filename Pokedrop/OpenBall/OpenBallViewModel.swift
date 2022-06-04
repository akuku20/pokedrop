//  OpenBallViewModel.swift
//  Pokedrop

import Foundation
import UIKit

final class OpenBallViewModel {

    //MARK: - Variables
    
    var delegate: OpenControllerDrawDelegate!
    
    private var pokeball: PokeballsViewModel.Pokeball!
    private var pokemonsDetails: [PokemonDetails] = []
    private var pokemonsImages: [UIImage] = []
    
    var image: UIImage {
        pokeball.image
    }
    
    var name: String {
        pokeball.name
    }
    
    var description: String {
        pokeball.description
    }
    
    var price: Int {
        pokeball.price
    }
        
    var resultIndex: Int {
        19
    }
    
    var drawnPokemon: (PokemonDetails, UIImage) {
        (pokemonsDetails[resultIndex], pokemonsImages[resultIndex])
    }
    
    var buttonString: NSMutableAttributedString {
        let prefixAttributes = [NSAttributedString.Key.font: UIFont.appFont(ofSize: 18, isBold: true),
                                NSAttributedString.Key.foregroundColor: UIColor.black]
        let fullString = NSMutableAttributedString(string: "Buy ", attributes: prefixAttributes)
        let attachment = NSTextAttachment(image: UIImage(named: "coinIcon")!)
        attachment.bounds = CGRect(x: 0, y: -4, width: 15, height: 22)
        let attachmentString = NSAttributedString(attachment: attachment)
        fullString.append(attachmentString)
        let suffixAttributes = [NSAttributedString.Key.font: UIFont.appFont(ofSize: 16),
                                NSAttributedString.Key.foregroundColor: UIColor.black]
        fullString.append(NSAttributedString(string: " \(price)", attributes: suffixAttributes))
        return fullString
    }
    
    //MARK: - Lifecycle
    
    init(pokeball: PokeballsViewModel.Pokeball) {
        self.pokeball = pokeball
    }
    
    //MARK: - Methods
    
    func openPokeball() {
        if PokemonDatabase.shared.drawFetchFinished {
            choosePokemon()
        } else {
            delegate.switchLoader(show: true)
            awaitDrawFetch()
        }
    }
    
    private func awaitDrawFetch() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            if PokemonDatabase.shared.drawFetchFinished {
                self?.delegate.switchLoader(show: false)
                self?.choosePokemon()
            } else {
                self?.awaitDrawFetch()
            }
        }
    }
        
    private func choosePokemon() {
        pokemonsDetails = PokemonDatabase.shared.allDrawDetails()
        pokemonsImages = PokemonDatabase.shared.allDrawImages()
        
        let sortedPokemons = pokemonsDetails.sorted(by: { $0.statsSum > $1.statsSum })
        let chosenIdx = Int.random(in: pokeball.range)
        let chosenPokemon = sortedPokemons[chosenIdx]
        
        if let ogIdx = pokemonsDetails.firstIndex(where: {$0.id == chosenPokemon.id}) {
            let swapIdx = resultIndex
            let swapPokemon = pokemonsDetails[swapIdx]
            let swapImage = pokemonsImages[swapIdx]
            let chosenImage = pokemonsImages[ogIdx]
            
            pokemonsDetails[ogIdx] = swapPokemon
            pokemonsDetails[swapIdx] = chosenPokemon
            pokemonsImages[ogIdx] = swapImage
            pokemonsImages[swapIdx] = chosenImage
            
            delegate.readyToDraw()
        }
    }
}

//MARK: - OpenViewDrawDelegate

extension OpenBallViewModel: OpenViewDrawDelegte {    
    func pokemonImage(at idx: Int) -> UIImage {
        pokemonsImages[idx]
    }
    
    func launchDrawFetch() {
        PokemonDatabase.shared.fetchPokemonForDraw()
    }
}
