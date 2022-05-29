//  PokemonDatabase.swift
//  Pokedrop

import Foundation

final class PokemonDatabase {
    
    static let shared = PokemonDatabase()
    
    private init() {}
    
    private var database: PokemonList?
    
    func fetchData(completion: @escaping (_ error: String?) -> Void) {
        DataManager.shared.getPokemonList() { list in
            guard let pokeList = list else {
                completion("Could not fetch data")
                return
            }
            self.database = pokeList
            completion(nil)
        }
    }
    
    func getRandomPokemon(count: Int) -> [PokemonBase]? {
        guard let list = database else { return nil }
        var arr: [PokemonBase] = []
        
        for _ in 0..<count {
            let idx = Int.random(in: 0 ..< list.count)
            arr.append(list.results[idx])
        }
        
        return arr
    }
}
