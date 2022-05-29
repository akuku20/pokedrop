//  PokemonModel.swift
//  Pokedrop

import UIKit

struct PokemonList: Decodable {
    var count: Int
    var results: [PokemonBase]
}

struct PokemonBase: Decodable {
    var name: String
    var url: String
    var imageUrl: URL? {
        guard let idString = url.split(separator: "/").last else { return nil }
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(idString).png")
    }
}

struct PokemonDetails: Decodable {
    var name: String
    var id: Int
    var sprites: spritesStruct
    var stats: [statsItemStruct]
    var types: [typesItemStruct]
    
    struct spritesStruct: Decodable {
        var frontDefault: String?
    }
    
    struct statsItemStruct: Decodable {
        var baseStat: Int
        var stat: statsNameStruct
    }
    
    struct statsNameStruct: Decodable {
        var name: String
    }
    
    struct typesItemStruct: Decodable {
        var type: typesNameStruct
    }
    
    struct typesNameStruct: Decodable {
        var name: String
    }
}

enum PokemonRarity: Int {
    case common, uncommon, rare, superRare, ultimate, unknown
    
    init(rawValue: Int) {
        switch rawValue {
        case 175..<425:
            self = .common
        case 425..<505:
            self = .uncommon
        case 505..<580:
            self = .rare
        case 580..<630:
            self = .superRare
        case 630...1125:
            self = .ultimate
        default:
            self = .unknown
        }
    }
    
    var priceMultiplier: Double {
        switch self {
        case .common:
            return 0.5
        case .uncommon:
            return 0.75
        case .rare:
            return 1.0
        case .superRare:
            return 1.25
        case .ultimate:
            return 1.5
        case .unknown:
            return 0.0
        }
    }
}

enum PokemonType: String {
    case bug, dark, dragon, electric, fairy, fighting, fire, flying, ghost, grass, ground, ice, normal, poison, psychic, rock, steel, water
}

extension PokemonDetails {
    var imageUrl: URL? {
        if let urlString = sprites.frontDefault {
            return URL(string: urlString)
        }
        return nil
    }
    
    var statsSum: Int {
        stats.reduce(0, { $0 + $1.baseStat })
    }
    
    var rarity: PokemonRarity {
        PokemonRarity(rawValue: statsSum)
    }
    
    var primaryType: PokemonType? {
        guard let type = types.first?.type.name else {return nil}
        return PokemonType(rawValue: type.lowercased())
    }
    
    var secondaryType: PokemonType? {
        guard types.count > 1, let type = types.last?.type.name else {return nil}
        return PokemonType(rawValue: type.lowercased())
    }
    
    var price: Int {
        Int(Double(statsSum) * rarity.priceMultiplier)
    }
    
    var isSingleType: Bool {
        types.count == 1
    }
    
    var isDualType: Bool {
        types.count == 2
    }
}
