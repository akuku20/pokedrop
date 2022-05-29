//  PokeballsViewModel.swift
//  Pokedrop

import Foundation
import UIKit

final class PokeballsViewModel {
    
    struct Pokeball {
        var name: String
        var image: UIImage
        var description: String
        var price: Int
        var sampleSize: Int
        var range: ClosedRange<Int>
    }
    
    private var pokeballs: [Pokeball] = [
        Pokeball(name: "Poké Ball",
                 image: UIImage(named: "pokeball")!,
                 description: "Basic Poké Ball that can be found anywhere in Unova.",
                 price: 300,
                 sampleSize: 20,
                 range: 10...20),
        Pokeball(name: "Great Ball",
                 image: UIImage(named: "greatball")!,
                 description: "More refined version of Poké Ball, way more efficient.",
                 price: 400,
                 sampleSize: 20,
                 range: 6...14),
        Pokeball(name: "Ultra Ball",
                 image: UIImage(named: "ultraball")!,
                 description: "A Poké Ball of outstanding performance, pretty rare one.",
                 price: 550,
                 sampleSize: 20,
                 range: 3...9),
        Pokeball(name: "Master Ball",
                 image: UIImage(named: "masterball")!,
                 description: "The ultimate Poké Ball that only a few ever possesed.",
                 price: 750,
                 sampleSize: 20,
                 range: 1...5)
    ]
    
    var numberOfPokeballs: Int {
        pokeballs.count
    }
    
    func pokeballAt(row: Int) -> Pokeball {
        return pokeballs[row]
    }
}
