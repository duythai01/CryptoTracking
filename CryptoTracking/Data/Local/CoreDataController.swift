//
//  CoreDataController.swift
//  CryptoTracking
//
//  Created by DuyThai on 05/11/2023.
//

import Foundation
import CoreData

enum CoreDataState {
    case getEntitySucces([CoinHoldedEntity])
    case failure(String)
    case saveDone
    case updateDone
    case deleteDone
    case insertDone

}

struct CoinHolded {
    let id: String
    var currencyHold: Double
}


class CoreDataController: ObservableObject {
    static let shared = CoreDataController()
    let persistentContainer: NSPersistentContainer = NSPersistentContainer(name: "CoinHoldedEntity")
    private var corDataState: CoreDataState? {
        didSet { stateHandler?(corDataState) }
    }

    var stateHandler:((CoreDataState?) -> Void)?

    init () {
        persistentContainer.loadPersistentStores {decription, error in
            if let error = error {
                print ("Fail to load coredate: \(decription)")
                self.corDataState = .failure("Fail to load coredata: \(error.localizedDescription)")
            }
        }
    }

    private func saveContext(type: CoreDataState) {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                corDataState = type
            } catch {
                print("Failed to save context: \(error)")
                corDataState = .failure("Failed to save context: \(error.localizedDescription)")
            }
        }
    }

    func insert(element: CoinHolded) {
        let context = persistentContainer.viewContext
        let newEntity = CoinHoldedEntity(context: context)
        newEntity.id = element.id
        newEntity.currencyHold = element.currencyHold
        saveContext(type: .insertDone)
    }

    func updateEntity(id: String, newCurrencyHold: Double) {
        if var entity = getEntityByID(id: id) {
            entity.currencyHold = newCurrencyHold
            saveContext(type: .updateDone)
        } else {
            self.corDataState = .failure("Not found id")
        }

    }

    func deleteEntity(id: String) {
        let context = persistentContainer.viewContext

        if var entity = getEntityByID(id: id) {
            context.delete(entity)
            saveContext(type: .deleteDone)
        } else {
            self.corDataState = .failure("Not found id")
        }
    }

    func fetchAllEntities() {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<CoinHoldedEntity> = CoinHoldedEntity.fetchRequest()
        do {
            let entities =  try context.fetch(fetchRequest)
            self.corDataState = .getEntitySucces(entities)
        } catch {
            self.corDataState = .failure("Failed to fetch entities: \(error)")
        }
    }

    func coinHoldedEntityToCoinHolded(entity: CoinHoldedEntity) -> CoinHolded {
        return CoinHolded(id: entity.id ?? "N/A", currencyHold: entity.currencyHold)
    }


    func getEntityByID(id: String) -> CoinHoldedEntity? {
           let context = persistentContainer.viewContext
           let fetchRequest: NSFetchRequest<CoinHoldedEntity> = CoinHoldedEntity.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "id == %@", id)

           do {
               return try context.fetch(fetchRequest).first
           } catch {
               self.corDataState = .failure("Failed to fetch entities: \(error)")
               return nil
           }
       }
}
