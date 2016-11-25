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
