//
//  Supplier+CoreDataProperties.swift
//  SK_Core_Data_Stack
//
//  Created by Shreesha on 25/11/16.
//  Copyright © 2016 YML. All rights reserved.
//

import Foundation
import CoreData

extension Supplier {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Supplier> {
        return NSFetchRequest<Supplier>(entityName: "Supplier");
    }

    @NSManaged public var companyName: String?
    @NSManaged public var supplierID: Double
    @NSManaged public var products: NSSet?
    @NSManaged public var users: NSSet?

}

// MARK: Generated accessors for products
extension Supplier {

    @objc(addProductsObject:)
    @NSManaged public func addToProducts(_ value: Product)

    @objc(removeProductsObject:)
    @NSManaged public func removeFromProducts(_ value: Product)

    @objc(addProducts:)
    @NSManaged public func addToProducts(_ values: NSSet)

    @objc(removeProducts:)
    @NSManaged public func removeFromProducts(_ values: NSSet)

}

// MARK: Generated accessors for users
extension Supplier {

    @objc(addUsersObject:)
    @NSManaged public func addToUsers(_ value: User)

    @objc(removeUsersObject:)
    @NSManaged public func removeFromUsers(_ value: User)

    @objc(addUsers:)
    @NSManaged public func addToUsers(_ values: NSSet)

    @objc(removeUsers:)
    @NSManaged public func removeFromUsers(_ values: NSSet)

}
