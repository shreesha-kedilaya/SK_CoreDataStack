//
//  SK_CoreDataResolver+Save.swift
//  SK_CoreDataStack
//
//  Created by Shreesha on 24/11/16.
//  Copyright © 2016 Shreesha. All rights reserved.
//

import Foundation
import CoreData

//Coredata saving
extension NSManagedObjectContext {

    private func saveData(_ completion: CoredataErrorCallback?) {
        do {
            try save()
            if let parentContext = parent {
                parentContext.saveData {_ in
                    completion?(nil)
                }
            } else {
                completion?(nil)
            }

        }catch {
            completion?(error)
        }
    }

    private func asynchronouslySaveAll(_ completion: CoredataErrorCallback?) {
        perform {
            self.saveData {_ in
                completion?(nil)
            }
        }
    }

    private func synchronouslySaveAll(_ completion: CoredataErrorCallback?) {
        performAndWait {
            self.saveData {_ in
                completion?(nil)
            }
        }
    }

    func saveAllToStore(_ synchrnous: Bool, completion: CoredataErrorCallback?) {

        if synchrnous {
            self.synchronouslySaveAll({ (error) in
                completion?(error)
            })
        } else {
            self.asynchronouslySaveAll({ (error) in
                completion?(error)
            })
        }

    }

    func saveCurrent(_ synchronous: Bool, completion: CoredataErrorCallback?) {
        if synchronous {
            perform {
                do {
                    try self.save()
                } catch {
                    completion?(error)
                }
            }
        } else {
            performAndWait {
                do {
                    try self.save()
                } catch {
                    completion?(error)
                }
            }
        }
    }
}
