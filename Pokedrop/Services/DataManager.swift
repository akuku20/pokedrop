//  DataManager.swift
//  Pokedrop

import Alamofire
import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    private init() {}

    func getPokemonDatabase(completion: @escaping (_ pokemonDatabase: PokemonDatabase?) -> Void) {
        AF.request("https://pokeapi.co/api/v2/pokemon?limit=1300&offset=0").response { response in
            switch response.result {
            case .success(let json):
                if let result = try? JSONDecoder().decode(PokemonDatabase.self, from: json!) {
                    completion(result)
                } else {
                    completion(nil)
                }
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    func getPokemonData(endpoint: String, completion: @escaping (_ pokemonData: PokemonDetails?) -> Void) {
        AF.request(endpoint).response { response in
            switch response.result {
            case .success(let json):
                if let result = try? JSONDecoder().decode(PokemonDetails.self, from: json!) {
                    completion(result)
                } else {
                    completion(nil)
                }
            case .failure(_):
                completion(nil)
            }
        }
    }
}


