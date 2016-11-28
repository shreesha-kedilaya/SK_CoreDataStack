//
//  OrderDetails+CoreDataProperties.swift
//  SK_Core_Data_Stack
//
//  Created by Shreesha on 25/11/16.
//  Copyright © 2016 YML. All rights reserved.
//

import Foundation
import CoreData

extension OrderDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrderDetails> {
        return NSFetchRequest<OrderDetails>(entityName: "OrderDetails");
    }

    @NSManaged public var orderDetailsID: Double
    @NSManaged public var orderNumber: Float
    @NSManaged public var productID: Double
    @NSManaged public var quantity: NSDecimalNumber?
    @NSManaged public var unitPrice: NSDecimalNumber?
    @NSManaged public var order: Order?

}

extension OrderDetails {
    class func nextId() -> Double {
        let context = SK_CoredataStack.sharedInstance.backgroundContext()
        let predicate = NSPredicate(format: "orderDetailsID == max(orderDetailsID)")

        let orderDetails: OrderDetails! = context.executeFetchRequest (false, builder: { (fetchRequest) in
            fetchRequest.predicate = predicate
        }) { (error) in
            }?.first


        if let orderDetails = orderDetails {
            return orderDetails.orderDetailsID + Double(1)
        } else {
            return Double(100)
        }
    }
}
