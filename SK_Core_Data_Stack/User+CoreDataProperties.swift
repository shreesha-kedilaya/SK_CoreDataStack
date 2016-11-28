//
//  User+CoreDataProperties.swift
//  SK_Core_Data_Stack
//
//  Created by Shreesha on 25/11/16.
//  Copyright © 2016 YML. All rights reserved.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User");
    }

    @NSManaged public var admin: Bool
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var userID: Double
    @NSManaged public var bills: NSSet?
    @NSManaged public var cart: Cart?
    @NSManaged public var orders: NSSet?
    @NSManaged public var supplierCompany: Supplier?

}

extension User {

    class func nextId() -> Double {
        let context = SK_CoredataStack.sharedInstance.backgroundContext()
        let predicate = NSPredicate(format: "userID == max(userID)")

        let user: User! = context.executeFetchRequest (false, builder: { (fetchRequest) in
            fetchRequest.predicate = predicate
        }) { (error) in
            }?.first

        if let user = user {
            return user.userID + Double(1)
        } else {
            return Double(100)
        }
    }
}

// MARK: Generated accessors for bills
extension User {

    @objc(addBillsObject:)
    @NSManaged public func addToBills(_ value: Billing)

    @objc(removeBillsObject:)
    @NSManaged public func removeFromBills(_ value: Billing)

    @objc(addBills:)
    @NSManaged public func addToBills(_ values: NSSet)

    @objc(removeBills:)
    @NSManaged public func removeFromBills(_ values: NSSet)

}

// MARK: Generated accessors for orders
extension User {

    @objc(addOrdersObject:)
    @NSManaged public func addToOrders(_ value: Order)

    @objc(removeOrdersObject:)
    @NSManaged public func removeFromOrders(_ value: Order)

    @objc(addOrders:)
    @NSManaged public func addToOrders(_ values: NSSet)

    @objc(removeOrders:)
    @NSManaged public func removeFromOrders(_ values: NSSet)

}
