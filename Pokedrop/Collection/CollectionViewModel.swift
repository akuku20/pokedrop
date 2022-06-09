//  CollectionViewModel.swift
//  Pokedrop

import Foundation
import CoreData
import UIKit

final class CollectionViewModel: NSObject {
    
    private var fetchController: NSFetchedResultsController<PokemonEntity>
    
    var output: CollectionModelOutput!
    
    private var collectionData: [FetchedPokemon] = []
    private var collectionEntities: [PokemonEntity] = []
    
    private var filteredData: [FetchedPokemon] = []
    private var filteredEntities: [PokemonEntity] = []
    
    var numberOfPokemon: Int {
        filteredData.count
    }
    
    override init() {
        let fetchRequest = NSFetchRequest<PokemonEntity>(entityName: "PokemonEntity")
        fetchRequest.sortDescriptors = []
        let context = AppDelegate.shared.persistentContainer.viewContext
        fetchController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                     managedObjectContext: context,
                                                     sectionNameKeyPath: nil,
                                                     cacheName: nil)
        super.init()
        fetchController.delegate = self
    }
    
    func pokemonDetails(at idx: Int) -> PokemonDetails {
        filteredData[idx].details
    }
    
    func pokemonImage(at idx: Int) -> UIImage {
        filteredData[idx].image
    }
    
    func pokemonEntity(at idx: Int) -> PokemonEntity {
        filteredEntities[idx]
    }
    
    func setUpData() {
        fetchFromCoreData()
        output.refresh()
    }
    
    private func fetchFromCoreData() {
        try? fetchController.performFetch()
        reloadData()
    }
    
    private func reloadData() {
        collectionEntities = fetchController.fetchedObjects ?? []
        collectionEntities.sort(by: {
            if $0.statsSum != $1.statsSum {
                return $0.statsSum > $1.statsSum
            } else {
                return $0.name! < $0.name!
            }
        })
        
        let adapter = DetailsAdapter()
        collectionData = collectionEntities.compactMap({ adapter.createDetails(from: $0) })
        
        filteredData = collectionData
        filteredEntities = collectionEntities
    }
    
    func filterPokemons(by text: String) {
        if text == "" {
            filteredData = collectionData
            filteredEntities = collectionEntities
        } else {
            filteredData = collectionData.filter({ $0.details.name.lowercased().contains(text) })
            filteredEntities = collectionEntities.filter({ $0.name!.lowercased().contains(text) })
        }
        output.refresh()
    }
}

extension CollectionViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        reloadData()
        output.refresh()
    }
}
