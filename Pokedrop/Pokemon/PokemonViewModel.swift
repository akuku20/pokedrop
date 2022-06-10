//  PokemonViewModel.swift
//  Pokedrop

import Foundation
import UIKit
import CoreData

final class PokemonViewModel {
    
    enum Mode {
        case draw, preview
    }
    
    var mode: Mode
    
    var saved = false
    
    private var pokemon: PokemonDetails
    
    private var currentEntity: PokemonEntity?
    
    var pokemonImage: UIImage
    
    var name: String {
        pokemon.name.capitalized
    }
    
    var price: Int {
        pokemon.price
    }
    
    private var starsAmount: Int {
        switch pokemon.rarity {
        case .common: return 1
        case .uncommon: return 2
        case .rare: return 3
        case .superRare: return 4
        case .ultimate: return 5
        case .unknown: return 0
        }
    }
    
    var backgroundColor: UIColor {
        switch pokemon.rarity {
        case .common: return .lightGray
        case .uncommon: return .green
        case .rare: return .blue
        case .superRare: return .purple
        case .ultimate: return .red
        case .unknown: return .lightGray
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
    
    init(details: PokemonDetails, image: UIImage, from: Mode, entity: PokemonEntity? = nil) {
        pokemon = details
        pokemonImage = image
        mode = from
        if let entity = entity {
            currentEntity = entity
        }
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
    
    private func createStar(metric: CGFloat) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: metric).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        imageView.image = UIImage(named: (starsAmount == 5 ? "superStar" : "defaultStar"))
        return imageView
    }
    
    func starsView() -> UIView {
        let metric = UIScreen.main.bounds.height * 0.06
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: metric * CGFloat(starsAmount)).isActive = true
        view.heightAnchor.constraint(equalToConstant: metric).isActive = true
        
        for i in 1...starsAmount {
            let img = createStar(metric: metric)
            view.addSubview(img)
            img.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            img.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(i-1)*metric).isActive = true
        }
        
        view.backgroundColor = .clear
        return view
    }
    
    func saveToCoreData() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let newEntity = PokemonEntity(context: context)
            
            newEntity.uuid = UUID()
            newEntity.id = Int32(pokemon.id)
            newEntity.name = pokemon.name
            newEntity.statsSum = Int32(pokemon.statsSum)
            newEntity.primaryType = pokemon.primaryType?.rawValue
            newEntity.secondaryType = pokemon.secondaryType?.rawValue
            newEntity.image = pokemonImage.pngData()
            
            currentEntity = newEntity
            AppDelegate.shared.saveContext()
        }
    }
    
    func deleteFromCoreData() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext, let ent = currentEntity {
            context.delete(ent)
            AppDelegate.shared.saveContext()
        }
    }
    
    func isPokemonSold() -> Bool {
        if currentEntity?.uuid == nil {
            if mode == .preview {
                return true
            } else {
                return saved
            }
        }
        return false
    }
}
