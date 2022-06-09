//  DetailsAdapter.swift
//  Pokedrop

import Foundation
import UIKit

struct FetchedPokemon {
    var details: PokemonDetails
    var image: UIImage
    var uuid: UUID
}

final class DetailsAdapter {
    
    func createDetails(from entity: PokemonEntity) -> FetchedPokemon? {
        guard let name = entity.name else { return nil }
        
        let id = Int(entity.id)
        
        let spritesStruct = PokemonDetails.spritesStruct()
        
        let statsStruct = PokemonDetails.statsItemStruct(baseStat: Int(entity.statsSum),
                                                             stat: .init(name: "statsSum"))
        
        var typesArray: [PokemonDetails.typesItemStruct] = []
        if let type1 = entity.primaryType {
            typesArray.append(.init(type: .init(name: type1)))
        }
        if let type2 = entity.secondaryType {
            typesArray.append(.init(type: .init(name: type2)))
        }
        
        let details = PokemonDetails(name: name,
                                     id: id,
                                     sprites: spritesStruct,
                                     stats: [statsStruct],
                                     types: typesArray)
        
        var image: UIImage
        if let data = entity.image, let img = UIImage(data: data) {
            image = img
        } else {
            image = UIImage(named: "questionMark")!
        }
        
        guard let uuid = entity.uuid else { return nil }
        
        return FetchedPokemon(details: details,
                              image: image,
                              uuid: uuid)
    }
}
