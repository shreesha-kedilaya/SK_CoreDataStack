//
//  Product+CoreDataProperties.swift
//  SK_Core_Data_Stack
//
//  Created by Shreesha on 25/11/16.
//  Copyright © 2016 YML. All rights reserved.
//

import Foundation
import CoreData

extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product");
    }

    @NSManaged public var pricePerUnit: NSDecimalNumber?
    @NSManaged public var productDescription: String?
    @NSManaged public var productID: Double
    @NSManaged public var quantityPerUnitPackage: Int16
    @NSManaged public var unitsInStock: Float
    @NSManaged public var unitsOrdered: Float
    @NSManaged public var unitWeight: NSDecimalNumber?
    @NSManaged public var carts: NSSet?
    @NSManaged public var category: ProductCategory?
    @NSManaged public var supplier: Supplier?

}

// MARK: Generated accessors for carts
extension Product {

    @objc(addCartsObject:)
    @NSManaged public func addToCarts(_ value: Cart)

    @objc(removeCartsObject:)
    @NSManaged public func removeFromCarts(_ value: Cart)

    @objc(addCarts:)
    @NSManaged public func addToCarts(_ values: NSSet)

    @objc(removeCarts:)
    @NSManaged public func removeFromCarts(_ values: NSSet)

}
