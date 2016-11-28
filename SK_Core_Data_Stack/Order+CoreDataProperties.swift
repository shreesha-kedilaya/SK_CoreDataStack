//
//  Order+CoreDataProperties.swift
//  SK_Core_Data_Stack
//
//  Created by Shreesha on 25/11/16.
//  Copyright © 2016 YML. All rights reserved.
//

import Foundation
import CoreData

extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order");
    }

    @NSManaged public var expectedDate: NSDate?
    @NSManaged public var orderedDate: NSDate?
    @NSManaged public var orderID: Double
    @NSManaged public var orderNumber: Int16
    @NSManaged public var shippedDate: NSDate?
    @NSManaged public var billing: Billing?
    @NSManaged public var customer: User?
    @NSManaged public var orderDetails: OrderDetails?
    @NSManaged public var shipper: Shipper?

}

extension Order {
    class func nextId() -> Double {
        let context = SK_CoredataStack.sharedInstance.backgroundContext()
        let predicate = NSPredicate(format: "orderID == max(orderID)")

        let order: Order! = context.executeFetchRequest (false, builder: { (fetchRequest) in
            fetchRequest.predicate = predicate
        }) { (error) in
            }?.first

        if let order = order {
            return order.orderID + Double(1)
        } else {
            return Double(100)
        }
    }
}
