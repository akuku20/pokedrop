//  PokemonDatabase.swift
//  Pokedrop

import Foundation
import UIKit

final class PokemonDatabase {
    
    //MARK: - Variables
    
    static let shared = PokemonDatabase()
    
    private var database: PokemonList?
    
    private var pokemonForDraw: [PokemonDetails] = []
    private var imagesForDraw: [UIImage] = []
    
    var listFetchPending: Bool {
        database.isNil
    }
    
    var drawFetchFinished: Bool {
        pokemonForDraw.count == 20 && imagesForDraw.count == 20
    }
    
    func allDrawDetails() -> [PokemonDetails] {
        pokemonForDraw
    }
    
    func allDrawImages() -> [UIImage] {
        imagesForDraw
    }
    
    //MARK: - Lifecycle
    
    private init() {}
    
    //MARK: - Methods
    
    func fetchData(completion: @escaping (_ error: String?) -> Void) {
        DataManager.shared.getPokemonList() { [weak self] list in
            guard let pokeList = list else {
                completion("Could not fetch data")
                return
            }
            self?.database = pokeList
            completion(nil)
            self?.fetchPokemonForDraw()
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
    
    func fetchPokemonForDraw() {
        DispatchQueue.main.async { [weak self] in
            self?.pokemonForDraw = []
            self?.imagesForDraw = []
            let baseData = self?.getRandomPokemon(count: 20) ?? []
            self?.fetchPokemon(idx: 0, base: baseData)
        }
    }
    
    private func fetchPokemon(idx: Int, base: [PokemonBase]) {
        DispatchQueue.main.async { [weak self] in
            if idx < base.count {
                let url = base[idx].url
                DataManager.shared.getPokemonData(endpoint: url) { details in
                    guard let details = details else {
                        return
                    }
                    self?.pokemonForDraw.append(details)
                    self?.fetchPokemon(idx: idx + 1, base: base)
                }
            } else {
                self?.fetchImage(idx: 0)
            }
        }
        
    }
    
    private func fetchImage(idx: Int) {
        DispatchQueue.main.async { [weak self] in
            if idx < self?.pokemonForDraw.count ?? 0 {
                if let url = self?.pokemonForDraw[idx].imageUrl, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    self?.imagesForDraw.append(image)
                } else {
                    self?.imagesForDraw.append(UIImage(named: "questionMark")!)
                }
                self?.fetchImage(idx: idx + 1)
            }
        }
    }
}
