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
    case error(String)
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
    let persistentContainer: NSPersistentContainer = NSPersistentContainer(name: "CryptoTracking")
    private var corDataState: CoreDataState? {
        didSet { stateHandler?(corDataState) }
    }

    var stateHandler:((CoreDataState?) -> Void)?

    init () {
        persistentContainer.loadPersistentStores {decription, error in
            if let error = error {
                print ("Fail to load coredate: \(decription)")
                self.corDataState = .error("Failed to load coredata: \(error.localizedDescription)")
            }
        }
    }

    private func saveContext(type: CoreDataState) -> Bool {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                corDataState = type
                return true
            } catch {
                print("Failed to save context: \(error)")
                corDataState = .error("Failed to save context: \(error.localizedDescription)")
                return false

            }
        }
        return false
    }

    func insert(element: CoinHolded) -> Bool {
        let context = persistentContainer.viewContext
        let newEntity = CoinHoldedEntity(context: context)
        newEntity.id = element.id
        newEntity.currencyHold = element.currencyHold
        return saveContext(type: .insertDone)
    }

    func updateEntity(id: String, newCurrencyHold: Double) -> Bool {
        if let entity = getEntityByID(id: id) {
            entity.currencyHold = newCurrencyHold
            return saveContext(type: .updateDone)
        } else {
            self.corDataState = .error("Not found id")
            return false
        }

    }

    func deleteEntity(id: String)  -> Bool {
        let context = persistentContainer.viewContext

        if let entity = getEntityByID(id: id) {
            context.delete(entity)
            return saveContext(type: .deleteDone)
        } else {
            self.corDataState = .error("Not found id")
            return false
        }
    }

    func fetchAllEntities() -> [CoinHolded] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<CoinHoldedEntity> = CoinHoldedEntity.fetchRequest()
        do {
            let entities =  try context.fetch(fetchRequest)
            self.corDataState = .getEntitySucces(entities)
            return entities.map {
                coinHoldedEntityToCoinHolded(entity: $0)
            }
        } catch {
           return []
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
               self.corDataState = .error("Failed to fetch entities: \(error)")
               return nil
           }
       }
}


class CoreDataOrderController: ObservableObject {
    static let shared = CoreDataOrderController()
    let persistentContainer: NSPersistentContainer = NSPersistentContainer(name: "CryptoTracking")

    init () {
        persistentContainer.loadPersistentStores {decription, error in
            if let error = error {
                print ("Fail to load coredate: \(decription)")
            }
        }
    }

    private func saveContext(type: CoreDataState) -> Bool {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                return true
            } catch {
                print("Failed to save context: \(error)")
                return false

            }
        }
        return false
    }

    func insert(element: OrderHolded) -> Bool {
        let context = persistentContainer.viewContext
        let newEntity = OrderEntity(context: context)

        newEntity.id = element.id
        newEntity.rateValue = element.rate
        newEntity.progress = element.progress
        newEntity.rateTitle = element.rateTitle
        newEntity.type = element.type
        newEntity.createdDate = element.createdDate
        newEntity.amount = element.amount
        return saveContext(type: .insertDone)
    }

    func updateEntity(element: OrderHolded) -> Bool {
        if let entity = getEntityByID(id: element.id) {
            entity.id = element.id
            entity.rateValue = element.rate
            entity.progress = element.progress
            entity.rateTitle = element.rateTitle
            entity.type = element.type
            entity.createdDate = element.createdDate
            entity.amount = element.amount
            return saveContext(type: .updateDone)
        } else {
            return false
        }

    }

    func deleteEntity(id: String)  -> Bool {
        let context = persistentContainer.viewContext

        if let entity = getEntityByID(id: id) {
            context.delete(entity)
            return saveContext(type: .deleteDone)
        } else {
            return false
        }
    }

    func fetchAllEntities() -> [OrderHolded] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<OrderEntity> = OrderEntity.fetchRequest()
        do {
            let entities =  try context.fetch(fetchRequest)
            return entities.map {
                OrdeEntityToOrderHolded(entity: $0)
            }
        } catch {
           return []
        }
    }


    func getEntityByID(id: String) -> OrderEntity? {
           let context = persistentContainer.viewContext
           let fetchRequest: NSFetchRequest<OrderEntity> = OrderEntity.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "id == %@", id)

           do {
               return try context.fetch(fetchRequest).first
           } catch {
               return nil
           }
       }

    func OrdeEntityToOrderHolded(entity: OrderEntity) ->OrderHolded {
        return OrderHolded(id: entity.id ?? "N/A", rate: entity.rateValue, progress: entity.progress, rateTitle: entity.rateTitle ?? "BTC/USD" , type: entity.type ?? "Buy", createdDate: entity.createdDate ?? Date(), amount: entity.amount)
    }

}

struct OrderHolded: Identifiable {
    let id: String
    let rate: Double
    let progress: Double
    let rateTitle: String
    let type: String
    let createdDate: Date
    let amount: Double
}
