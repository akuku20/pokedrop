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
    
    var numberOfPokemon: Int {
        collectionData.count
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
        collectionData[idx].details
    }
    
    func pokemonImage(at idx: Int) -> UIImage {
        collectionData[idx].image
    }
    
    func pokemonEntity(at idx: Int) -> PokemonEntity {
        collectionEntities[idx]
    }
    
    func setUpData() {
        self.fetchFromCoreData()
        self.output.refresh()
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
    }
}

extension CollectionViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        reloadData()
        output.refresh()
    }
}
