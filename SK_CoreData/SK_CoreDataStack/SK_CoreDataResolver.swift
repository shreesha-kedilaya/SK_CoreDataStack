//
//  SK_CoreDataResolver.swift
//  SK_CoreDataStack
//
//  Created by Shreesha on 23/11/16.
//  Copyright © 2016 Shreesha. All rights reserved.
//

import Foundation
import CoreData

typealias CoredataRequestCallback = ((NSFetchRequest<NSFetchRequestResult>) -> ())

extension NSManagedObjectContext {
    
    //Creating new object with the NSManagedObjectContext method.
    func newObject<ManagedObject: NSManagedObject>() -> ManagedObject? {
        return NSEntityDescription.insertNewObject(forEntityName: ManagedObject.entityClassName(), into: self) as? ManagedObject
    }

    func executeFetchRequest<ManagedObject: NSManagedObject>(_ error: NSErrorPointer? = nil, returnAsFaults: Bool = true, builder: CoredataRequestCallback? = nil) -> [ManagedObject]? {
        let className = ManagedObject.entityClassName()
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: className)
        request.returnsObjectsAsFaults = returnAsFaults
        builder?(request)

        var objects : [ManagedObject]?
        do {
            objects = try fetch(request) as? [ManagedObject]
        } catch {
            objects = nil
        }
        return objects
    }
    
    func firstObject<ManagedObject: NSManagedObject>(predicate: NSPredicate? = nil, attribute: (name: String, value: Any)? = nil) -> ManagedObject? {
        let objects: [ManagedObject]? = self.executeFetchRequest { (fetchRequest) in
            if let predicate = predicate {
                fetchRequest.predicate = predicate
            } else if let attribute = attribute {
                fetchRequest.predicate = self.getPredicateWithAttributeName(attribute.name, attributeValue: attribute.value)
            }
        }
        return objects?.first
    }
    
    func totalObjects(entityType: NSManagedObject.Type, attribute: (name: String, value: Any)? = nil, builder: CoredataRequestCallback? = nil) -> Int {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityType.entityClassName())
        if let attribute = attribute {
            let predicate = getPredicateWithAttributeName(attribute.name, attributeValue: attribute.value)
            fetchRequest.predicate = predicate
        } else {
            builder?(fetchRequest)
        }
        
        var count = 0
        do {
            count = try self.count(for: fetchRequest)
        } catch {
            
        }
        
        return count
    }
    
    public func getPredicateWithAttributeName(_ attributeName: String, attributeValue: Any) -> NSPredicate? {
        var predicate: NSPredicate?
        switch attributeValue {
        case let str as String:
            predicate = NSPredicate(format: "%K == %@", attributeName, str)
        case let number as Int:
            predicate = NSPredicate(format: "%K == %d", attributeName, number)
        case let number as Float:
            predicate = NSPredicate(format: "%K == %f", attributeName, number)
        case let number as Double:
            predicate = NSPredicate(format: "%K == %lf", attributeName, number)
        case let boolValue as Bool:
            predicate = NSPredicate(format: "%K == %@", attributeName, boolValue as CVarArg)
        case let date as Date:
            predicate = NSPredicate(format: "%K == %@", attributeName, date as CVarArg)
        default:
            predicate = nil
        }
        return predicate
    }
    
}

extension NSManagedObject {
    class func entityClassName() -> String {
        let name = NSStringFromClass(self)
        if let className = name.components(separatedBy: ".").last{
            return className
        }
        return ""
    }

    //Creating the new Object with NSManagedObject initializer
    convenience init(managedObjectContext: NSManagedObjectContext) {
        let eName = type(of: self).entityClassName()
        let entity = NSEntityDescription.entity(forEntityName: eName, in: managedObjectContext)
        if let entity = entity {
            self.init(entity: entity, insertInto: managedObjectContext)
        } else {
            fatalError("Dont have the entity name")
        }
    }
}
