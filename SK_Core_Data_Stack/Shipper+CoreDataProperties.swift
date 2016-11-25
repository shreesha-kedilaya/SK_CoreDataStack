//
//  Shipper+CoreDataProperties.swift
//  SK_Core_Data_Stack
//
//  Created by Shreesha on 25/11/16.
//  Copyright © 2016 YML. All rights reserved.
//

import Foundation
import CoreData

extension Shipper {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Shipper> {
        return NSFetchRequest<Shipper>(entityName: "Shipper");
    }

    @NSManaged public var companyName: String?
    @NSManaged public var phoneNumber: Int16
    @NSManaged public var shipperID: Double
    @NSManaged public var orders: NSSet?

}

// MARK: Generated accessors for orders
extension Shipper {

    @objc(addOrdersObject:)
    @NSManaged public func addToOrders(_ value: Order)

    @objc(removeOrdersObject:)
    @NSManaged public func removeFromOrders(_ value: Order)

    @objc(addOrders:)
    @NSManaged public func addToOrders(_ values: NSSet)

    @objc(removeOrders:)
    @NSManaged public func removeFromOrders(_ values: NSSet)

}
