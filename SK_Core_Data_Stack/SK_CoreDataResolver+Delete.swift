//
//  SK_CoreDataResolver+Delete.swift
//  SK_CoreDataStack
//
//  Created by Shreesha on 24/11/16.
//  Copyright © 2016 Shreesha. All rights reserved.
//

import Foundation
import CoreData

//MARK: Delete

extension NSManagedObjectContext {
    func removeObjects(entityType: NSManagedObject.Type, attribute: (name: String, value: Any)? = nil, requestBuilder: CoredataRequestCallback? = nil, errorCallBack: CoredataErrorCallback? = nil) {

        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityType.entityClassName())

        if let attribute = attribute {
            fetchRequest.predicate = getPredicateWithAttributeName(attribute.name, attributeValue: attribute.value)
        } else {
            requestBuilder?(fetchRequest)
        }

        var entries: [NSManagedObject]?

        do {
            entries = try fetch(fetchRequest) as? [NSManagedObject]
            if let entries = entries {
                for entry in entries {
                    delete(entry)
                }
            } else {
                let error = NSError(domain: "No objects are Fetched. Objects are nil", code: NO_OBJECTS_FETCHED_ERROR_CODE, userInfo: nil)
                errorCallBack?(error as Error)
            }
        } catch {
            errorCallBack?(error)
        }
    }

    @available(iOS 9, *)
    func batchDeleteRequest(entityType: NSManagedObject.Type, attribute: (name: String, value: Any)? = nil, resultType: NSBatchDeleteRequestResultType = .resultTypeCount, requestBuilder: CoredataRequestCallback? = nil, errorCallBack: CoredataErrorCallback? = nil) -> Any? {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityType.entityClassName())

        if let attribute = attribute {
            let predicate = getPredicateWithAttributeName(attribute.name, attributeValue: attribute.value)
            fetchRequest.predicate = predicate
        } else {
            requestBuilder?(fetchRequest)
        }
        let batchDeleteRequest: NSBatchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        batchDeleteRequest.resultType = resultType
        var result: Any = NSPersistentStoreResult()

        do {
            result = try execute(batchDeleteRequest)
            //We call reset() on the managed object context, which means that the managed object context starts with a clean slate after deleting
            reset()
        } catch {
            errorCallBack?(error)
        }

        return (result as? NSBatchDeleteResult)?.result
    }

    func removeObject(object: NSManagedObject?) {
        guard let object = object else {
            return
        }
        delete(object)
    }

    func deleteSet(set: NSSet){
        let oldObjectsArray = set.allObjects
        for counter in (0..<oldObjectsArray.count).reversed() {
            if let oldObject = oldObjectsArray[counter] as? NSManagedObject {
                self.delete(oldObject)
            }
        }
    }
}
