//  PokemonViewModel.swift
//  Pokedrop

import Foundation
import UIKit

final class PokemonViewModel {
    
    private var pokemon: PokemonDetails
    
    var pokemonImage: UIImage
    
    var name: String {
        pokemon.name.capitalized
    }
    
    var starsAmount: Int {
        switch pokemon.rarity {
        case .common: return 1
        case .uncommon: return 2
        case .rare: return 3
        case .superRare: return 4
        case .ultimate: return 5
        case .unknown: return 0
        }
    }
    
    var backgroundImage: UIImage {
        switch pokemon.rarity {
        case .common: return UIImage(named: "commonBg")!
        case .uncommon: return UIImage(named: "uncommonBg")!
        case .rare: return UIImage(named: "rareBg")!
        case .superRare: return UIImage(named: "superRareBg")!
        case .ultimate: return UIImage(named: "ultimateBg")!
        case .unknown: return UIImage(named: "commonBg")!
        }
    }
    
    var buttonString: NSMutableAttributedString {
        let prefixAttributes = [NSAttributedString.Key.font: UIFont.appFont(ofSize: 18, isBold: true),
                                NSAttributedString.Key.foregroundColor: UIColor.black]
        let fullString = NSMutableAttributedString(string: "Sell ", attributes: prefixAttributes)
        let attachment = NSTextAttachment(image: UIImage(named: "coinIcon")!)
        attachment.bounds = CGRect(x: 0, y: -4, width: 15, height: 22)
        let attachmentString = NSAttributedString(attachment: attachment)
        fullString.append(attachmentString)
        let suffixAttributes = [NSAttributedString.Key.font: UIFont.appFont(ofSize: 16),
                                NSAttributedString.Key.foregroundColor: UIColor.black]
        fullString.append(NSAttributedString(string: " \(pokemon.price)", attributes: suffixAttributes))
        return fullString
    }
    
    init(details: PokemonDetails, image: UIImage) {
        pokemon = details
        pokemonImage = image
    }

    func typeImage(isFirst: Bool) -> UIImage? {
        let tmp = isFirst ? pokemon.primaryType?.rawValue : pokemon.secondaryType?.rawValue
        guard let type = tmp else { return nil }
        switch pokemon.primaryType {
        case .bug: return UIImage(named: type)!
        case .dark: return UIImage(named: type)!
        case .dragon: return UIImage(named: type)!
        case .electric: return UIImage(named: type)!
        case .fairy: return UIImage(named: type)!
        case .fighting: return UIImage(named: type)!
        case .fire: return UIImage(named: type)!
        case .flying: return UIImage(named: type)!
        case .ghost: return UIImage(named: type)!
        case .grass: return UIImage(named: type)!
        case .ground: return UIImage(named: type)!
        case .ice: return UIImage(named: type)!
        case .normal: return UIImage(named: type)!
        case .poison: return UIImage(named: type)!
        case .psychic: return UIImage(named: type)!
        case .rock: return UIImage(named: type)!
        case .steel: return UIImage(named: type)!
        case .water: return UIImage(named: type)!
        case .none: return nil
        }
    }
}
