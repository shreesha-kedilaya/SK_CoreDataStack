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
    @NSManaged public var phoneNumber: Int64
    @NSManaged public var shipperID: Double
    @NSManaged public var orders: NSSet?

}

extension Shipper {
    class func nextId() -> Double {
        let context = SK_CoredataStack.sharedInstance.backgroundContext()
        let predicate = NSPredicate(format: "shipperID == max(shipperID)")

        let shipper: Shipper! = context.executeFetchRequest (false, builder: { (fetchRequest) in
            fetchRequest.predicate = predicate
        }) { (error) in
            }?.first

        if let shipper = shipper {
            return shipper.shipperID + Double(1)
        } else {
            return Double(100)
        }

    }
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
