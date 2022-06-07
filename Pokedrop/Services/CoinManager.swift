//  CoinManager.swift
//  Pokedrop

import Foundation
import CoreData
import UIKit

final class CoinManager {
    
    static let shared = CoinManager()
    
    var balance: Int!
    var lastReward: Date!
    
    private init() {}

    private func fetch() -> BalanceEntity? {
        do {
            let context = AppDelegate.shared.persistentContainer.viewContext
            let request = NSFetchRequest<BalanceEntity>(entityName: "BalanceEntity")
            request.predicate = NSPredicate(value: true)
            request.fetchLimit = 1
            request.sortDescriptors = []
            
            let requestController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            try requestController.performFetch()
            return requestController.fetchedObjects?.first
        } catch {
           fatalError()
        }
    }
    
    func startupFetch() {
        let ent = fetch()
        if let entity = ent {
            balance = Int(entity.amount)
            lastReward = entity.lastReward
        } else if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            balance = 300
            lastReward = Date()
            let newEntity = BalanceEntity(context: context)
            newEntity.amount = Int32(balance)
            newEntity.lastReward = lastReward
            AppDelegate.shared.saveContext()
        }
    }
    
    func changeBalance(by amount: Int, with date: Date? = nil) {
        balance += amount
        if let date = date {
            lastReward = date
        }
        let obj = fetch()
        obj?.amount = Int32(balance)
        obj?.lastReward = lastReward
        AppDelegate.shared.saveContext()
    }
}
