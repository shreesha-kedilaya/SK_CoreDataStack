//
//  SK_CoreDataStack.swift
//  SK_CoreDataStack
//
//  Created by Shreesha on 22/11/16.
//  Copyright © 2016 Shreesha. All rights reserved.
//

import Foundation
import CoreData
private let extensionName = "mmod"

private let CORE_DATA_LOADING_ERROR_CODE = 102
private let NO_NSMANAGED_OBJECT_MODEL_ERROR_CODE = 103

struct SK_Configuration {
    // MARK: - Properties
    /// The name you would like to give for your Sqlite database storage.
    public var sqlFileName: String?
    
    /// The name of your Core Data Schematic file (.xcdatamodeld extension)
    public var modelName: String?
    
    /// If you are migrating your Core Data Model to new Model. Default value is true.
    public var needMigration: Bool = true
    
    /// The merge policy to be followed while saving changes in Core Data. Default value is NSErrorMergePolicy
    public var mergePolicy: Any = NSErrorMergePolicy

    public var fileProtectionType: FileProtectionType = .none

    /// Returns the default set of configurations of _CoreDataStack_
    public static var defaultConfiguration: SK_Configuration {
        var manager = SK_Configuration()
        manager.sqlFileName = "DataBase"
        
        return manager
    }
}

class SK_CoredataStack {
    
    static let sharedInstance = SK_CoredataStack()
    
    static var coreDataConfig = SK_Configuration.defaultConfiguration
    
    fileprivate (set) var ninjaContext: NSManagedObjectContext?
    
    fileprivate (set) var masterConext: NSManagedObjectContext?
    
    static var errorHandler: ((Error?) -> ())?

    @available(iOS 10.0, *)
    private lazy var persistentContainer: NSPersistentContainer! = {
        let container = self.coredataPersisitentContainer()
        return container
    }()

    @available (iOS 10.0, *)
    private func coredataPersisitentContainer() -> NSPersistentContainer? {
        let container = NSPersistentContainer(name: SK_CoredataStack.coreDataConfig.modelName ?? "Model_name")
        let description = container.persistentStoreDescriptions.first
        description?.url = SK_CoredataStack.storeURL
        let options = (NSNumber(value: true), NSNumber(value: true))

        description?.setOption(options.0, forKey: NSMigratePersistentStoresAutomaticallyOption)
        description?.setOption(options.1, forKey: NSInferMappingModelAutomaticallyOption)

        container.loadPersistentStores { (storeDescription, error) in
            print("CoreData: Inited \(storeDescription)")
            guard error == nil else {
                SK_CoredataStack.errorHandler?(error)
                return
            }
        }

        return container
    }

    class func begin() {
        _ = SK_CoredataStack.sharedInstance
    }
    
    init() {initializeCoreDataStack()}
    
    fileprivate (set) var persistentStoreCoordinator: NSPersistentStoreCoordinator?
    
    func initializeCoreDataStack() {
        guard let modelName = SK_CoredataStack.coreDataConfig.modelName, let pathUrl = Bundle.main.url(forResource: modelName, withExtension: "momd") else {
            let error = NSError(domain: "Error in loading the model from the bundle", code: CORE_DATA_LOADING_ERROR_CODE, userInfo: nil)
            SK_CoredataStack.errorHandler?(error)
            return
        }
        
        let managedObjectModel = NSManagedObjectModel(contentsOf: pathUrl)
        
        guard let objectModel = managedObjectModel else {
            let error = NSError(domain: "No Managed object at specified Url", code: NO_NSMANAGED_OBJECT_MODEL_ERROR_CODE, userInfo: nil)
            SK_CoredataStack.errorHandler?(error)
            return
        }
        
        initializePersitentStore(objectModel)
        
        let backgroundQueue = DispatchQueue.global(qos: .background)

        backgroundQueue.async { 
            let migrationOptions: [String: Any] = [ NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true , NSPersistentStoreFileProtectionKey: SK_CoredataStack.coreDataConfig.fileProtectionType]
            let persistentStoreCoordinator = self.ninjaContext?.persistentStoreCoordinator
            
            do {
                try persistentStoreCoordinator?.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: SK_CoredataStack.storeURL, options: migrationOptions)
            } catch {
                SK_CoredataStack.errorHandler?(error)
            }
        }
    }

    func excludeIcloudBackup(exculde: Bool) {
        if exculde {
            do {
                try  (SK_CoredataStack.storeURL as NSURL?)?.setResourceValue(true, forKey: URLResourceKey.isExcludedFromBackupKey)
            }catch {
                SK_CoredataStack.errorHandler?(error)
            }
        }
    }
    
    fileprivate static func getNinjaContext() -> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        return context
    }
    
    fileprivate static func getMasterContext() -> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        return context
    }
    
    fileprivate func initializePersitentStore(_ withObjectModel: NSManagedObjectModel) {
        
        if #available(iOS 10.0, *) {
            //Do nothing
            _ = persistentContainer
        } else {
            do {
                try persistentStoreCoordinator = NSPersistentStoreCoordinator.coordinator()
                ninjaContext = SK_CoredataStack.getNinjaContext()
                ninjaContext?.persistentStoreCoordinator = persistentStoreCoordinator
                masterConext = SK_CoredataStack.getMasterContext()
                masterConext?.parent = ninjaContext
            } catch NSPersistentStoreCoordinator.CoordinatorError.modelCreationError {
                SK_CoredataStack.errorHandler?(NSPersistentStoreCoordinator.CoordinatorError.modelCreationError)
            } catch NSPersistentStoreCoordinator.CoordinatorError.modelFileNotFound {
                SK_CoredataStack.errorHandler?(NSPersistentStoreCoordinator.CoordinatorError.modelFileNotFound)
            } catch NSPersistentStoreCoordinator.CoordinatorError.storePathNotFound {
                SK_CoredataStack.errorHandler?(NSPersistentStoreCoordinator.CoordinatorError.modelFileNotFound)
            } catch {
                SK_CoredataStack.errorHandler?(error)
            }
            
        }
        
    }
    
    func viewContext() -> NSManagedObjectContext {
        if #available (iOS 10, *) {
            return persistentContainer.viewContext
        } else {
            let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            context.parent = masterConext
            return context
        }
    }

    func backgroundContext() -> NSManagedObjectContext {
        if #available(iOS 10, *) {
            return persistentContainer.newBackgroundContext()
        } else {
            let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            context.parent = masterConext
            return context
        }
    }

    func reset() {
        masterConext?.reset()
        ninjaContext?.reset()
        SK_CoredataStack.errorHandler = nil
        if #available(iOS 10.0, *) {
            persistentContainer = nil
        } else {
        }
        
        guard let persistentStores = persistentStoreCoordinator?.persistentStores else {
            return
        }
        
        for store in persistentStores {
            
            do {
                try persistentStoreCoordinator?.remove(store)
            } catch {
                //Write some code to catch the removal of persistent store
            }
        }
        
        guard let storeUrl = SK_CoredataStack.storeURL else{
            return
        }
        
        do {
            try FileManager.default.removeItem(at: storeUrl)
        } catch {
            //Write the code to catch the error in removing the sqlite store file.
        }

        if #available(iOS 10.0, *) {
            persistentContainer = coredataPersisitentContainer()
        }
        initializeCoreDataStack()
    }
    
    static var storeURL: URL? {
        return NSPersistentStoreCoordinator.storeURL
    }
}

/// NSPersistentStoreCoordinator extension
extension NSPersistentStoreCoordinator {
    
    public enum CoordinatorError: Error {
        case modelFileNotFound
        case modelCreationError
        case storePathNotFound
    }
    
    /// Return NSPersistentStoreCoordinator object
    static func coordinator() throws -> NSPersistentStoreCoordinator? {
        
        guard let modelURL = Bundle.main.url(forResource: SK_CoredataStack.coreDataConfig.modelName, withExtension: "momd") else {
            throw CoordinatorError.modelFileNotFound
        }
        
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            throw CoordinatorError.modelCreationError
        }
        
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        guard let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            throw CoordinatorError.storePathNotFound
        }
        
        do {
            let url = documents.appendingPathComponent("\(SK_CoredataStack.coreDataConfig.sqlFileName).sqlite")
            let options = [ NSMigratePersistentStoresAutomaticallyOption : true,
                            NSInferMappingModelAutomaticallyOption : true ]
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        } catch {
            throw error
        }
        
        return coordinator
    }
    
    static var storeURL: URL? {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        let docURL = urls.last
        
        guard let sqlFileName =  SK_CoredataStack.coreDataConfig.sqlFileName else{
            return nil
        }
        
        let storeURL = docURL?.appendingPathComponent("\(sqlFileName).sqlite")
        
        guard let url = storeURL else {
            return nil
        }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            let defaultUrl = Bundle.main.url(forResource: sqlFileName, withExtension: "sqlite")
            
            if let defaultUrl = defaultUrl {
                do {
                    try FileManager.default.copyItem(at: defaultUrl, to: url)
                } catch {
                }
            }
        }
        
        return storeURL
    }
}
