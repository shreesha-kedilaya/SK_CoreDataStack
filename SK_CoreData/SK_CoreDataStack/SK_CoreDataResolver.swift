//
//  SK_CoreDataResolver.swift
//  SK_CoreDataStack
//
//  Created by Shreesha on 23/11/16.
//  Copyright © 2016 Shreesha. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    func newObject<ManagedObject: NSManagedObject>() -> ManagedObject? {
        return NSEntityDescription.insertNewObject(forEntityName: ManagedObject.entityClassName(), into: self) as? ManagedObject
    }

    func executeTheFetchRequest<ManagedObject: NSManagedObject>(_ error: NSErrorPointer? = nil, returnAsFaults:Bool = true, builder: ((NSFetchRequest<NSFetchRequestResult>) -> ())? = nil) -> [ManagedObject]? {
        let className = ManagedObject.entityClassName()
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: className)
        request.returnsObjectsAsFaults = returnAsFaults
        builder?(request)

        var object : [ManagedObject]?
        do {
            object = try fetch(request) as? [ManagedObject]
        } catch _ as NSError {
            object = nil
        } catch {
            object = nil
        }
        return object
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
