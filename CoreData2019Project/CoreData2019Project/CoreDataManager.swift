//
//  CoreDataManager.swift
//  CoreData2019Project
//
//  Created by Jorge Casariego on 8/27/19.
//  Copyright © 2019 Jorge Casariego. All rights reserved.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    // 1. Initialization of our Core Data Stack
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataCoreTestModels")
        container.loadPersistentStores { (storeDescription, err) in
        
            if let err = err {
                fatalError("Loading of store failed: \(err)")
            }
        
        
        }
        
        return container
    }()
    
    func fetchCompanies() -> [Company] {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        do {
            let companies = try context.fetch(fetchRequest)
            return companies
            
        } catch let fetchError {
            print("Failed to fetch companies: ", fetchError)
            return []
        }
    }
}
