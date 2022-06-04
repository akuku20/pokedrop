//  PokeballsViewModel.swift
//  Pokedrop

import Foundation
import UIKit

final class PokeballsViewModel {
    
    //MARK: - Model
    
    struct Pokeball {
        var name: String
        var image: UIImage
        var description: String
        var price: Int
        var range: ClosedRange<Int>
    }
    
    //MARK: - Variables
    
    private var pokeballs: [Pokeball] = [
        Pokeball(name: "Poké Ball",
                 image: UIImage(named: "pokeball")!,
                 description: "Basic Poké Ball that can be found anywhere in Unova.",
                 price: 300,
                 range: 9...19),
        Pokeball(name: "Great Ball",
                 image: UIImage(named: "greatball")!,
                 description: "More refined version of Poké Ball, way more efficient.",
                 price: 400,
                 range: 5...13),
        Pokeball(name: "Ultra Ball",
                 image: UIImage(named: "ultraball")!,
                 description: "A Poké Ball of outstanding performance, pretty rare one.",
                 price: 550,
                 range: 2...8),
        Pokeball(name: "Master Ball",
                 image: UIImage(named: "masterball")!,
                 description: "The ultimate Poké Ball that only a few ever possesed.",
                 price: 750,
                 range: 0...4)
    ]
    
    var numberOfPokeballs: Int {
        pokeballs.count
    }
    
    //MARK: - Methods
    
    func pokeballAt(row: Int) -> Pokeball {
        return pokeballs[row]
    }
}
