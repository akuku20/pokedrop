//  DataManager.swift
//  Pokedrop

import Alamofire
import Foundation

class DataManager {
    
    //MARK: - Variables
    
    static let shared = DataManager()
    
    //MARK: - Lifecycle
    
    private init() {}
    
    //MARK: - Methods

    func getPokemonList(completion: @escaping (_ pokemonDatabase: PokemonList?) -> Void) {
        AF.request("https://pokeapi.co/api/v2/pokemon?limit=1300&offset=0").response { response in
            switch response.result {
            case .success(let json):
                if let result = try? JSONDecoder().decode(PokemonList.self, from: json!) {
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
                let jdec = JSONDecoder()
                jdec.keyDecodingStrategy = .convertFromSnakeCase
                if let result = try? jdec.decode(PokemonDetails.self, from: json!) {
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


